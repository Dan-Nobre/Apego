//
//  BotaoFoto.swift
//  Apego
//
//  Created by Daniel Nobre on 18/06/24.
//

import SwiftUI
import PhotosUI

struct BotaoFoto: View {
    @State private var inputImage: UIImage?
    @State private var isShowingPicker = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.isShowingPicker = true
            }) {
                Text("Tirar nova foto")
            }
            .sheet(isPresented: $isShowingPicker) {
                CameraImagePicker(image: self.$inputImage)
            }
            
            if let inputImage = inputImage {
                Image(uiImage: inputImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onChange(of: inputImage) {
            print("Nova imagem capturada")
        }
        }
    }

struct BotaoRolo: View {
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    var body: some View {
            VStack {
                PhotosPicker("Selecionar do rolo da câmera", selection: $avatarItem, matching: .images)
                
                avatarImage?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            .buttonStyle(MyButtonStyle(color: Color.accentColor))
            .onChange(of: avatarItem) {
                Task {
                    if let loaded = try? await avatarItem?.loadTransferable(type: Image.self){
                        avatarImage = loaded
                    } else {
                        print("failed")
                    }
                }
            }
    }
}

struct BotaoVariasImagens: View {
    @State private var selectedItens = [PhotosPickerItem] ()
    @Binding var selectedImages: [Image]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(0..<selectedImages.count, id: \.self) {
                        i in selectedImages[i]
                            .resizable()
                            .scaledToFit()
                            .frame(width: 170, height: 170)
                    }
                }
            }
            .toolbar {
                PhotosPicker("Select Imagens", selection: $selectedItens, matching: .images)
            }
            .onChange(of: selectedItens){
                Task {
                    selectedImages.removeAll()
                    
                    for item in selectedItens {
                        if let image = try? await item.loadTransferable(type: Image.self) {
                            selectedImages.append(image)
                        }
                    }
                }
            }
        }
    }
}

struct BotaoCancelar: View {
    @State private var isPresented = true
    var body: some View {
        Button(action:{
            isPresented.toggle()
        }, label: {
            VStack{
                VStack{
                    Text("Cancelar")
                }
            }
        })
    }
}


// MARK: - Gabi daqui pra baixo
//#Preview {
//    TirarFotoView()
//}
//
//struct TirarFotoView: View {
//    
//    @State var selectedImages: [Image] = []
//    @State var showBotaoGaleria: Bool = false
//    @State var showGaleriaSelecionada: Bool = false
//    
//    var body: some View {
//        NavigationStack {
//            Text("Quantidade imagens selecionadas: \(selectedImages.count)")
//            Button("Adicione Peças") {
//                showBotaoGaleria = true
//            }
//            .navigationDestination(isPresented: $showGaleriaSelecionada) {
//                Text("Galeria com imagens selecionadas: \(selectedImages.count)")
//            }
//        }
//        .sheet(isPresented: $showBotaoGaleria) {
//            BotaoGaleria(
//                selectedImages: $selectedImages,
//                showGaleriaSelecionada: $showGaleriaSelecionada
//            )
//        }
//    }
//}
//
//struct BotaoGaleria: View {
//    
//    @Environment(\.dismiss) var dismiss
//    
//    @State private var selectedItens = [PhotosPickerItem] ()
//    @State var showingPhotosPicker: Bool = false
//    @Binding var selectedImages: [Image]
//    @Binding var showGaleriaSelecionada: Bool
//    
//    var body: some View {
//        NavigationStack {
//            Button("Selecionar da Galeria") {
//                showingPhotosPicker = true
//            }
//        }
//        .photosPicker(isPresented: $showingPhotosPicker, selection: $selectedItens, matching: .images)
//        .toolbar {
//            Button("Select Imagens") {
//                showingPhotosPicker = true
//            }
//        }
//        .onChange(of: selectedItens){
//            Task {
//                selectedImages.removeAll()
//                
//                for item in selectedItens {
//                    if let image = try? await item.loadTransferable(type: Image.self) {
//                        selectedImages.append(image)
//                    }
//                }
//                
//                dismiss()
//                
//                showGaleriaSelecionada = true
//            }
//        }
//    }
//}
