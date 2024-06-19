import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct RemoveBackgroundView: View {
    @State private var inputImage: UIImage?
    @State private var outputImage: UIImage?
    @State private var isShowingImagePicker = false
    
    var body: some View {
        VStack {
            VStack {
                if let image = outputImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding()
                } else {
                    Text("Nenhuma imagem selecionada")
                        .padding()
                }
                
                Button(action: {
                    self.isShowingImagePicker.toggle()
                }) {
                    Text("Selecionar Imagem")
                }
                .padding()
                
                Button(action: {
                    if let inputImage = inputImage {
                        self.removeBackground(of: inputImage)
                    }
                }) {
                    Text("Remover Fundo")
                }
                .padding()
            }
        }
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        outputImage = inputImage
    }
    
    func removeBackground(of image: UIImage) {
        guard let ciImage = CIImage(image: image) else { return }
        
        // Aplicar filtro de máscara para remover o fundo
        let filter = CIFilter.colorClamp()
        filter.inputImage = ciImage
        filter.minComponents = CIVector(x: 0.0, y: 0.0, z: 0.0, w: 0.0)
        filter.maxComponents = CIVector(x: 1.0, y: 0.8, z: 1.0, w: 1.0)
        
        guard let outputCIImage = filter.outputImage else { return }
        
        // Converter CIImage de volta para UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return }
        outputImage = UIImage(cgImage: cgImage)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Update UI View Controller
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

