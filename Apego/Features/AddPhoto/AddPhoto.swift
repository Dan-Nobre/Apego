import SwiftUI
import PhotosUI
import CoreML
import Vision

struct AddPhoto: View {
    @Binding var showSheet: Bool
    @State private var selectedImage: UIImage?
    @State private var presentPicker = false
    @State private var isLoading = false
    @State private var clothingType: String = "Tipo de roupa desconhecido"
    
    var body: some View {
        VStack {
            if let image = selectedImage {
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
                ProgressView("Carregando...")
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
                        DispatchQueue.main.async {
                            self.parent.image = image
                            self.detectClothingType(image)
                        }
                    }
                }
            }
            
            func detectClothingType(_ image: UIImage) {
                // Configuração modelo
                let configuration = MLModelConfiguration()
                configuration.computeUnits = .cpuAndGPU 
           
                guard let model = try? VNCoreMLModel(for: modelosRoupa(configuration: configuration).model) else {
                    print("Falha ao carregar o modelo")
                    return
                }
                
                // Criar a requisição Core ML
                let request = VNCoreMLRequest(model: model) { (request, error) in
                    if let error = error {
                        print("Erro ao processar a imagem: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let results = request.results as? [VNRecognizedObjectObservation],
                          let topResult = results.first else {
                        print("Falha ao processar a imagem")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.parent.isLoading = false
                        self.parent.clothingType = "Tipo de roupa: \(topResult.labels.first?.identifier) - Confiança: \(topResult.labels.first?.confidence)"
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
}

#Preview {
    AddPhoto(showSheet: .constant(true))
}

