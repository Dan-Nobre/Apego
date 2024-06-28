//
//  Adicionar.swift
//  Apego
//
//  Created by Daniel Nobre on 25/06/24.
//

import SwiftUI
import _PhotosUI_SwiftUI

#Preview {
    Adicionar()
}

struct Adicionar: View {
    @State var selectedImages: [UIImage] = []
    @State var selectedCam: [UIImage] = []
    @State var showBotaoGaleria: Bool = false
    @State var showGaleriaSelecionada: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                AdicionarPecasSheet()
                Button("Continue") {
                    showBotaoGaleria = true
                }
                .buttonStyle(MySecButtonStyle(color: Color.accentColor))
                .padding()
                .bold()
                Spacer()
            }
            .scrollIndicators(.hidden)
            .navigationDestination(isPresented: $showGaleriaSelecionada) {
                Finalizar(roupas: $selectedImages)
            }
        }
        .navigationTitle("Adicionar peças")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showBotaoGaleria) {
            BotaoGaleria(
                selectedImages: $selectedImages,
                showGaleriaSelecionada: $showGaleriaSelecionada
            )
        }
    }
}

struct BotaoGaleria: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedItens = [PhotosPickerItem]()
    @State private var showingPhotosPicker: Bool = false
    @Binding var selectedImages: [UIImage]
    @Binding var showGaleriaSelecionada: Bool

    var body: some View {
        NavigationStack {
            VStack {
                BotaoFoto(selectedImages: $selectedImages, showGaleriaSelecionada: $showGaleriaSelecionada)
                    .buttonStyle(MyButtonStyle(color: Color.accentColor))
                    .padding(.bottom, 15)

                Button("Selecionar da Galeria") {
                    showingPhotosPicker = true
                }
                .buttonStyle(MySecButtonStyle(color: Color.accentColor))
                .padding(.bottom, 15)

                Button("Cancelar") {
                    dismiss()
                }
                .buttonStyle(MyCancelStyle(color: Color.cinzinha))
            }
            .bold()
        }
        .presentationDetents([.fraction(0.35)])
        .photosPicker(isPresented: $showingPhotosPicker, selection: $selectedItens, matching: .images)
        .toolbar {
            Button("Select Imagens") {
                showingPhotosPicker = true
            }
        }
        .onChange(of: selectedItens) { _ in
            Task {
                for item in selectedItens {
                    if let imageData = try? await item.loadTransferable(type: Data.self), let image = UIImage(data: imageData) {
                        selectedImages.append(image)
                    }
                }
                dismiss()
                showGaleriaSelecionada = true
            }
        }
    }
}
