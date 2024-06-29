import SwiftUI
import UIKit
import CoreML
import Vision
import PhotosUI

struct CustomImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var clothingType : String
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CustomImagePicker
        
        init(parent: CustomImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
                parent.detectClothingType(uiImage) // Chamando a função para detectar o tipo de roupa

                print("Imagem selecionada: \(uiImage.size)")
            } else {
                print("Falha ao selecionar imagem")
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func detectClothingType(_ image: UIImage) {
        guard let model = try? VNCoreMLModel(for: MyImageClassifierCP(configuration: MLModelConfiguration()).model) else {
            print("Failed to load CoreML model")
            return
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation], let topResult = results.first {
                DispatchQueue.main.async {
                    self.clothingType = "Tipo de roupa: \(topResult.identifier) - Confiança: \(topResult.confidence)"
                }
            } else {
                print("Failed to classify image: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        
        guard let ciImage = CIImage(image: image) else {
            print("Unable to create CIImage")
            return
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform classification: \(error.localizedDescription)")
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
//TAISSA 
struct CameraImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var clothingType: String // Adicionado binding para clothingType
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CameraImagePicker
        
        init(parent: CameraImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        picker.cameraDevice = .rear 
        picker.showsCameraControls = true
        picker.modalPresentationStyle = .fullScreen


        
        return picker
    }
    
    
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

//#Preview {
//    ImagePicker()
//}
