//
//  RemoveBackgroundView.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 25/06/24.
//

import SwiftUI
import PhotosUI
//struct EffectPicker: View {
//    
//    @Binding var effect: Effect
//    
//    var body: some View {
//        Picker("Effect", selection: $effect) {
//            ForEach(Effect.allCases, id: \.self) { effect in
//                Text(effect.rawValue)
//                    .tag(effect)
//            }
//        }
//    }
//}

/// A preset picker for background images.
struct BackgroundPicker: View {
    
    @Binding var background: Background
    
    var body: some View {
        Picker("Background", selection: $background) {
            ForEach(Background.allCases, id: \.self) { background in
                Text(background.rawValue)
                    .tag(background)
            }
        }
    }
}

struct ImagePicker: View {
    
    var pipeline: EffectsPipeline
    
    @State private var imageSelection: PhotosPickerItem? = nil
    
    var body: some View {
        PhotosPicker(selection: $imageSelection, matching: .images) {
            Label("Select Image", systemImage: "photo")
        }
        .onChange(of: imageSelection) { _, newSelection in
            self.loadInputImage(fromPhotosPickerItem: newSelection)
        }
    }
    
    private func loadInputImage(fromPhotosPickerItem item: PhotosPickerItem?) {
        guard let item else {
            return
        }
        item.loadTransferable(type: Data.self) { result in
            switch result {
            case .failure(let error):
                print("Failed to load: \(error)")
                return
                
            case .success(let maybeData):
                guard let data = maybeData else {
                    print("Failed to load image data.")
                    return
                }
                guard let image = CIImage(data: data) else {
                    print("Failed to create image from selected photo.")
                    return
                }
                DispatchQueue.main.async {
                    pipeline.inputImage = image
                }
            }
        }
    }
}
struct OutputView: View {
    
    @Binding var output: UIImage
    
    var body: some View {
        Image(uiImage: output)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct RemoverFundo: View {
    @EnvironmentObject var pipeline: EffectsPipeline
    @State private var outputViewSize = CGSize.zero
    
    var body: some View {
        VStack {
            ZStack {
                GeometryReader { geometry in
                    OutputView(output: $pipeline.output)
                        .onAppear {
                            outputViewSize = geometry.size
                        }
                        .onTapGesture { location in
                            // Normalize the tap position.
                            pipeline.subjectPosition = CGPoint(
                                x: location.x / outputViewSize.width,
                                y: location.y / outputViewSize.height)
                        }
                }
            }
            Form {
//                EffectPicker(effect: $pipeline.effect)
                BackgroundPicker(background: $pipeline.background)
                ImagePicker(pipeline: pipeline)
            }
            .frame(height: 200)
        }
    }
}
#Preview {
//
    RemoverFundo()
    
}
