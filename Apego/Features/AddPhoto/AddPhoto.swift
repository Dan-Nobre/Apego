import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins
import UniformTypeIdentifiers
import CoreML
import Vision

struct AddPhoto: View {
    @Binding var showSheet: Bool
    @State private var selectedImage: UIImage?
    @State private var presentPicker = false
    @State private var backgroundRemovedImage: UIImage?
    @State private var isLoading = false
    @State private var clothingType: String = "Tipo de roupa desconhecido"
    
    var body: some View {
        VStack {
            if let image = backgroundRemovedImage ?? selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            } else {
                Text("Nenhuma imagem selecionada")
                    .padding()
            }
            
            Text(clothingType)
                .padding()
            
            Button(action: {
                showSheet = false // Fechar o sheet
            }) {
                Text("Tirar uma foto")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Button(action: {
                showSheet = false // Fechar o sheet
            }) {
                Text("Cancelar")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button(action: {
                // Abrir a galeria de fotos
                presentPicker.toggle()
            }) {
                Text("Adicionar foto da galeria")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
            .sheet(isPresented: $presentPicker, content: {
                PHPickerViewController.View(image: $selectedImage, isLoading: $isLoading, clothingType: $clothingType)
            })
            .padding(.top, 10)
            
            if isLoading {
                ProgressView("Removendo fundo...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
            
            Spacer()
        }
        .onDisappear {
            // Limpar a imagem selecionada ao fechar o sheet
            selectedImage = nil
        }
    }
}

extension PHPickerViewController {
    struct View: UIViewControllerRepresentable {
        @Binding var image: UIImage?
        @Binding var isLoading: Bool
        @Binding var clothingType: String
        
        func makeUIViewController(context: Context) -> PHPickerViewController {
            var configuration = PHPickerConfiguration()
            configuration.filter = .images
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = context.coordinator
            return picker
        }
        
        func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
            // Nothing to update
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(parent: self)
        }
        
        class Coordinator: NSObject, PHPickerViewControllerDelegate {
            var parent: View
            
            init(parent: View) {
                self.parent = parent
            }
            
            func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
                picker.dismiss(animated: true)
                
                guard let provider = results.first?.itemProvider else { return }
                
                if provider.canLoadObject(ofClass: UIImage.self) {
                    self.parent.isLoading = true
                    provider.loadObject(ofClass: UIImage.self) { image, error in
                        guard let image = image as? UIImage else { return }
                        Dispatch.DispatchQueue.main.async {
                            self.parent.image = image
                            self.removeBackgroundIfNeeded(image)
                            self.detectClothingType(image)
                        }
                    }
                }
            }
            
            func removeBackgroundIfNeeded(_ image: UIImage) {
                guard let ciImage = CIImage(image: image) else { return }
                
                // Aplicar filtro de máscara para remover o fundo
                let filter = CIFilter.colorClamp()
                filter.inputImage = ciImage
                filter.minComponents = CIVector(x: 0.0, y: 0.0, z: 0.0, w: 0.0)
                filter.maxComponents = CIVector(x: 1.0, y: 0.8, z: 1.0, w: 1.0)
                
                guard let outputCIImage = filter.outputImage else {
                    self.parent.isLoading = false
                    return
                }
                
                // Converter CIImage de volta para UIImage
                let context = CIContext()
                guard let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return }
                let outputImage = UIImage(cgImage: cgImage)
                
                // Atualizar a imagem na tela principal
                DispatchQueue.main.async {
                    self.parent.isLoading = false
                    self.parent.image = outputImage
                }
            }
            
            
            func detectClothingType(_ image: UIImage) {
                // Configuração do modelo
                let configuration = MLModelConfiguration()
                configuration.computeUnits = .cpuAndGPU // Escolha a opção apropriada aqui
                
                // Carregar o modelo com a configuração
                guard let model = try? VNCoreMLModel(for: modelosRoupa(configuration: configuration).model) else {
                    print("Falha ao carregar o modelo")
                    return
                }
                
                // Restante do código da função detectClothingType...
            }
            
            
            // Criar a requisição Core ML
            let request = VNCoreMLRequest(model: model) { [weak self] (request, error) in
                if let error = error {
                    print("Erro ao processar a imagem: \(error.localizedDescription)")
                    return
                }
                
                guard let results = request.results as? [VNClassificationObservation],
                      let topResult = results.first else {
                    print("Falha ao processar a imagem")
                    return
                }
                
                DispatchQueue.main.async {
                    self?.parent.isLoading = false
                    self?.parent.clothingType = "Tipo de roupa: \(topResult.identifier) - Confiança: \(topResult.confidence)"
                }
            }
            
            // Criar um handler para a imagem
            guard let ciImage = CIImage(image: image) else {
                print("Não foi possível criar CIImage a partir da UIImage")
                return
            }
            
            let handler = VNImageRequestHandler(ciImage: ciImage)
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    try handler.perform([request])
                } catch {
                    print("Falha ao executar a solicitação: \(error.localizedDescription)")
                }
            }
        }
    }
}


#Preview {
    AddPhoto(showSheet: .constant(true))
}
