//
//  CardInfo.swift
//  Apego
//
//  Created by Daniel Nobre on 20/06/24.
//

import SwiftUI

struct CardAddPeca: View {
    @State private var isPresented = false
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5, 5]))
                    .foregroundColor(.gray)
                    .frame(width: 106, height: 106)
                    .foregroundColor(Color.cinza)
                    .opacity(0.4)
                Image(systemName: "plus")
                    .opacity(0.4)
                struct Adicionar: View {
                    
                    @State var selectedImages: [UIImage] = []
                    @State var selectedCam: [UIImage] = []
                    @State var showBotaoGaleria: Bool = false
                    @State var showGaleriaSelecionada: Bool = false
                    @Environment(\.dismiss) private var dismiss
                    
                    var body: some View {
                        NavigationStack {
                            ScrollView {
                                AdicionarPecasSheet()
                                Button("Continue") {
                                    showBotaoGaleria = true
                                }
                                .buttonStyle(MyButtonStyle(color: Color.accentColor))
                                .padding(.top, 20)
                                .padding(.bottom, 20)
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
                                selectedCam: $selectedCam, showGaleriaSelecionada: $showGaleriaSelecionada
                            )
                        }
                    }
                }

                struct BotaoGaleria: View {
                    
                    @Environment(\.dismiss) var dismiss
                    
                    @State private var selectedItens = [PhotosPickerItem]()
                    @State var showingPhotosPicker: Bool = false
                    @Binding var selectedImages: [UIImage]
                    @Binding var selectedCam: [UIImage]
                    @Binding var showGaleriaSelecionada: Bool
                //    @Binding var showCamSelecionada: Bool
                    
                    var body: some View {
                        NavigationStack {
                            VStack {
                                
                //                Button("Tirar foto") {
                //                    showCamSelecionada = true
                //                }
                                
                //                BotaoFoto(showCam: $showBotaoCam, selectedCam: $selectedCam)
                //                    .buttonStyle(MyButtonStyle(color: Color.accentColor))
                //                    .padding(.bottom, 15)
                                Button("Selecionar da Galeria") {
                                    showingPhotosPicker = true
                                }
                                .buttonStyle(MyButtonStyle(color: Color.accentColor))
                                .padding(.bottom, 15)
                    .buttonStyle(MySecButtonStyle(color: Color.cinzaClaro))
                    
            }
//            .presentationDetents([.height(300)])
            .padding(.top, 44)
                .frame(width: 393, height: 272)
                .presentationDetents([.fraction(0.25)])
        })
    }
}

struct CardAddPecaVariante: View {
    var body: some View {
        ZStack{
            Rectangle()
                .cornerRadius(10)
                .frame(width: 106, height: 106)
                .foregroundColor(Color.white)
            Image(systemName: "plus")
        }
    }
}

#Preview {
    CardAddPeca()
}
