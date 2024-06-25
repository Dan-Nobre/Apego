//
//  EffectsPipelime.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 25/06/24.
//

import Foundation
import Combine
import CoreImage.CIFilterBuiltins
import UIKit
import Vision


enum Background: String, Equatable, CaseIterable {
    case original = "Original"
    case transparent = "Transparent"
//    case sunset = "Sunset"
//    case greenScreen = "Green Screen"
}

final class EffectsPipeline: ObservableObject {
    @Published var inputImage = CIImage()
    @Published var output: UIImage = UIImage()
//    @Published var effect: Effect = .none
    @Published var background: Background = .original
    @Published var subjectPosition: CGPoint? = nil
    @Published var inputImages: [CIImage] = []

    private var processingQueue = DispatchQueue(label: "EffectsProcessing")
    private var cancellables: [AnyCancellable] = []

    init() {
        // Regenerate the composite when the pipeline input changes.
        Publishers
            .CombineLatest3(
                $inputImage,
                $background,
                $subjectPosition)
            .sink { (inputImage, background, subjectPosition) in
                self.regenerate(
                    usingInputImage: inputImage,
                    background: background,
                    subjectPosition: subjectPosition)
            }
            .store(in: &self.cancellables)
    }

    func regenerate(
        usingInputImage inputImage: CIImage,
        background: Background,
        subjectPosition: CGPoint?
    ) {
        processingQueue.async {
            // Generate the input-image mask.
            guard let mask = self.subjectMask(fromImage: inputImage, atPoint: subjectPosition) else {
                return
            }

            // Acquire the selected background image.
            let backgroundImage = self.image(forBackground: background, inputImage: inputImage)
                .cropped(to: inputImage.extent)

            // Apply the visual effect and composite.
            let composited = self.apply(
                toInputImage: inputImage,
                background: backgroundImage,
                mask: mask)

            let output = UIImage(cgImage: self.render(ciImage: composited))

            DispatchQueue.main.async {
                self.output = output
            }
        }
    }

    private func apply(
          toInputImage inputImage: CIImage,
          background: CIImage,
          mask: CIImage
      ) -> CIImage {
          let filter = CIFilter.blendWithMask()
          filter.inputImage = inputImage
          filter.backgroundImage = background
          filter.maskImage = mask
          return filter.outputImage!
      }

    private func subjectMask(fromImage image: CIImage, atPoint point: CGPoint?) -> CIImage? {
        let request = VNGenerateForegroundInstanceMaskRequest()
        let handler = VNImageRequestHandler(ciImage: image)

        do {
            try handler.perform([request])
        } catch {
            print("Failed to perform Vision request.")
            return nil
        }

        guard let result = request.results?.first else {
            print("No subject observations found.")
            return nil
        }

        let instances = instances(atPoint: point, inObservation: result)

        do {
            let mask = try result.generateScaledMaskForImage(forInstances: instances, from: handler)
            return CIImage(cvPixelBuffer: mask)
        } catch {
            print("Failed to generate subject mask.")
            return nil
        }
    }

    private func instances(
        atPoint maybePoint: CGPoint?,
        inObservation observation: VNInstanceMaskObservation
    ) -> IndexSet {
        guard let point = maybePoint else {
            return observation.allInstances
        }

        let instanceMap = observation.instanceMask
        let coords = VNImagePointForNormalizedPoint(
            point,
            CVPixelBufferGetWidth(instanceMap) - 1,
            CVPixelBufferGetHeight(instanceMap) - 1)

        CVPixelBufferLockBaseAddress(instanceMap, .readOnly)
        guard let pixels = CVPixelBufferGetBaseAddress(instanceMap) else {
            fatalError("Failed to access instance map data.")
        }
        let bytesPerRow = CVPixelBufferGetBytesPerRow(instanceMap)
        let instanceLabel = pixels.load(
            fromByteOffset: Int(coords.y) * bytesPerRow + Int(coords.x),
            as: UInt8.self)
        CVPixelBufferUnlockBaseAddress(instanceMap, .readOnly)

        return instanceLabel == 0 ? observation.allInstances : [Int(instanceLabel)]
    }

    private func image(forBackground background: Background, inputImage: CIImage) -> CIImage {
        switch background {
        case .original:
            return inputImage
        case .transparent:
            return CIImage(color: CIColor.clear)
        }
    }

    private func loadImage(named: String, withExtension ext: String = "jpg") -> CIImage {
        guard let url = Bundle.main.url(forResource: named, withExtension: ext) else {
            fatalError("Sample image asset \(named).\(ext) not found.")
        }
        guard let image = CIImage(contentsOf: url) else {
            fatalError("Failed to load sample image \(named).\(ext) data.")
        }
        return image
    }

    private func render(ciImage img: CIImage) -> CGImage {
        guard let cgImage = CIContext(options: nil).createCGImage(img, from: img.extent) else {
            fatalError("Failed to render CIImage.")
        }
        return cgImage
    }
}
