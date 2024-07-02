//
//  BotaoFoto.swift
//  Apego
//
//  Created by Daniel Nobre on 18/06/24.
//

import SwiftUI
import PhotosUI
import CoreML
import Vision

struct BotaoFoto: View {
    @State private var inputImage: UIImage?
    @State private var isShowingPicker = false
    @State private var clothingType: String = "Desconhecido" // Adicionada a variável clothingType
    @Environment(\.dismiss) var dismiss
    @Binding var selectedImages: [UIImage]
    @Binding var showGaleriaSelecionada: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                self.isShowingPicker = true
            }) {
                Text("Tirar nova foto")
            }
            .buttonStyle(MySecButtonStyle(color: Color.terroso))
            .sheet(isPresented: $isShowingPicker) {
                CameraImagePicker(image: self.$inputImage, clothingType: self.$clothingType) //sheet camera
                    .ignoresSafeArea()
            }
            
            if let inputImage = inputImage {
                Image(uiImage: inputImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
             // Mostrar o tipo de roupa detectad
            
        }
        .onChange(of: inputImage) { newImage in
            if let newImage = newImage {
                selectedImages.append(newImage)
//                self.isShowingPicker // false fehcar o sheet n funcionou
                dismiss()
                showGaleriaSelecionada = true
            }
        }
    }
}


struct BotaoRolo: View {
    @State private var tirarRoloItem: PhotosPickerItem?
    @State private var tirarRoloImage: Image?
    @State private var clothingType: String = "Desconhecido" // Variável para armazenar o tipo de roupa detectado

    
    
    var body: some View {
            VStack {
                PhotosPicker("Selecionar do rolo da câmera", selection: $tirarRoloItem, matching: .images)
                
                tirarRoloImage?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            .buttonStyle(MyButtonStyle(color: Color.terroso))
            .onChange(of: tirarRoloItem) {
                Task {
                    if let loaded = try? await tirarRoloItem?.loadTransferable(type: Image.self){
                        tirarRoloImage = loaded
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


