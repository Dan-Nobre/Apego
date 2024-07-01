//
//  CardRoupa.swift
//  Apego
//
//  Created by Daniel Nobre on 21/06/24.
//

import SwiftUI
import CoreML
import Vision

struct CardRoupa: View {
    let roupa: UIImage
    @State private var clothingType = ""
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 11)
                .stroke(
                    Color.gray.opacity(0.5),
                    style: StrokeStyle(lineWidth: 3, dash: [5, 5])
                )
                .overlay {
                    Image(uiImage: roupa)
                        .resizable()
                        .scaledToFill()
                }
                .aspectRatio(1, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 11))
                .onAppear {
                    classifyClothingType(roupa)
                }
            Spacer()
           
            ZStack {
//                RoundedRectangle(cornerRadius: 10)
//                    .frame(width: 101, height: 37)
//                    .foregroundColor(.bege)
//                    .overlay {
                        VStack {
                            Text("Tipo de roupa")
                                .font(.system(size: 13))
                                .foregroundColor(.principal)
                            Text(clothingType)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.principal)
                        }
                    
            }
        }
    }
    
    private func classifyClothingType(_ image: UIImage) {
        guard let model = try? VNCoreMLModel(for: MyImageClassifierCP(configuration: MLModelConfiguration()).model) else {
            print("Failed to load CoreML model")
            return
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
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
                clothingType = "\(topResult.identifier)"
                print("Classificação bem-sucedida: \(topResult.identifier) com confiança de \(topResult.confidence)")

            }
            
            print("Tipo de roupa detectado: \(topResult.identifier) - Confiança: \(topResult.confidence)")
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
}

#Preview {
    NavigationStack {
        
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(100)), count: 3)) {
                ForEach([0,1,2], id: \.self) { _ in
                    CardRoupa(roupa: UIImage(named: "bonecoavatar")!)
                }
            }
            .padding()
            BotaoSalvar()
                .buttonStyle(MyButtonStyle(color: Color.accentColor))
            Spacer()
        }
    }
    .navigationTitle("Adicione peças")
    .navigationBarTitleDisplayMode(.inline)
}
struct CardRoupaMenorCombo: View {
    var roupa: RoupaModelo
    var isSelected: Bool
    
    var body: some View {
        VStack {
            if let foto = roupa.foto, let uiImage = UIImage(data: foto) {
                ZStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .cornerRadius(8)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.terroso.opacity(isSelected ? 0.05 : 0))
                        .frame(width: 110, height: 110)
                }
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? Color.terroso : Color.clear, lineWidth: 3)
                )
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 110)
                    .foregroundColor(.gray)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isSelected ? Color.terroso : Color.clear, lineWidth: 3)
                    )
                    .cornerRadius(8)
            }
        }
    }
}

struct CardRoupaMenorComboHorizontal: View {
    var roupa: RoupaModelo
    var isSelected: Bool
    
    var body: some View {
        VStack {
            if let foto = roupa.foto, let uiImage = UIImage(data: foto) {
                ZStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 240, height: 240)
                        .cornerRadius(8)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.terroso.opacity(isSelected ? 0.05 : 0))
                        .frame(width: 240, height: 240)
                }
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? Color.terroso : Color.clear, lineWidth: 3)
                )
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 110)
                    .foregroundColor(.gray)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isSelected ? Color.terroso : Color.clear, lineWidth: 3)
                    )
                    .cornerRadius(8)
            }
        }
    }
}




struct CardRoupaMenor: View {
    var roupa: RoupaModelo
    @State var isSelected: Bool = false
    
    var body: some View {
        VStack {
            if let foto = roupa.foto, let uiImage = UIImage(data: foto) {
                ZStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .cornerRadius(8)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.botao.opacity(isSelected ? 0.2 : 0))
                        .frame(width: 110, height: 110)
                }
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? Color.botao : Color.clear, lineWidth: 3)
                )
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 110)
                    .foregroundColor(.gray)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isSelected ? Color.botao : Color.clear, lineWidth: 3)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.botao.opacity(isSelected ? 0.5 : 0))
                    )
                    .cornerRadius(8)
            }
        }
    }
}

struct CardRoupa2: View {
    var roupa: RoupaModelo
    @State var isSelected: Bool
    
    var body: some View {
        VStack {
            if let foto = roupa.foto, let uiImage = UIImage(data: foto) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 170)
                    .cornerRadius(8)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 170)
                    .foregroundColor(.gray)
                    .cornerRadius(8)
            }
        }
    }
}



