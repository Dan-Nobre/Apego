////
////  ImagePicker.swift
////  Apego
////
////  Created by Maria Eduarda on 23/06/24.
////
//
//import SwiftUI
//import UIKit
//
//struct CustomImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//    @Environment(\.presentationMode) var presentationMode
//    
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        var parent: CustomImagePicker
//        
//        init(parent: CustomImagePicker) {
//            self.parent = parent
//        }
//        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                parent.image = uiImage
//                print("Imagem selecionada: \(uiImage.size)")
//            } else {
//                print("Falha ao selecionar imagem")
//            }
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//    
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//    
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//}
//
////TAISSA
//struct ImagePicker: UIViewControllerRepresentable {
//    var sourceType: UIImagePickerController.SourceType = .camera
//    
//    func makeUIViewControllerCam(context: UIViewControllerRepresentableContext<ImagePicker) ->
//    UIImagePickerController {
//        let imagePicker = UIImagePickerController()
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = sourceType
//        
//        return imagePicker 
//        
//    }
//
//    func updateUIViewControllerCam(_ uiViewController: UIImagePickerController, context: Context) {
//        
//    }
//}
//
////#Preview {
////    ImagePicker()
////}
