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
                let picker = CustomImagePicker(image: $inputImage)
            }) { VStack {
                    Text("Tirar nova foto")
                }
            }
            
            .sheet(isPresented: $isShowingPicker) {
                           CustomImagePicker(image: $inputImage)
            }
            
            if let inputImage = inputImage {
                Image(uiImage: inputImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onChange(of: inputImage) { _, newImage  in
            // nova imagem
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

#Preview {
    BotaoFoto()
}
