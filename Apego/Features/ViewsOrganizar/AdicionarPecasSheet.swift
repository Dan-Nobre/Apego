//
//  AdicionarPecasSheet.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 21/06/24.
//

import SwiftUI

//struct AdicionarPecasSheet: View {
//    var body: some View {
//        NavigationView {
//            VStack {
//                HStack {
//                    CardAddPeca()
//                }
//                .padding(.top, 64)
//                CardInfo()
//                    .padding(.top, 31)
//                BotaoContinuar()
//                    .buttonStyle(MySecButtonStyle(color: .cinzaClaro))
//                    .padding(.top, 25)
//                Spacer()
//            }
//        }
//        .navigationTitle("ADICIONAR PEÇAS")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .cancellationAction) {
//                Button("Close") {
//                    // Código para fechar a sheet
//                    // É automaticamente gerenciado pelo .sheet em AdicionarPecas
//                }
//            }
//        }
//    }
//}

struct AdicionarPecasSheet: View {
    
    @State var showNextView: Bool = false
    @State var selectedImages: [Image] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Adicione peças!")
                    .bold()
                    .font(.system(size: 28))
                    .foregroundColor(.accentColor)
                
                CamPreview()
                    .padding(.bottom, 15)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top){
                        Image(systemName: "sun.max")
                        Text("Utilize um local com ")
                        + Text("luz natural").foregroundColor(Color.accentColor)
                    }
                    .padding(.bottom, 15)
                    HStack(alignment: .top){
                        Image(systemName: "person.and.background.dotted")
                        Text("Fundo neutro")
                            .foregroundColor(Color.accentColor)
                        + Text(" te ajuda no enquadramento")
                    }
                    .padding(.bottom, 15)
                    HStack(alignment: .top){
                        Image(systemName: "square.dashed")
                        Text("Centralizar a câmera")
                            .foregroundColor(Color.accentColor)
                        + Text(" na peça dá uma foto melhor")
                    }
                    .padding(.bottom, 15)
                    HStack(alignment: .top){
                        Image(systemName: "wand.and.stars.inverse")
                        Text("Sombras e objetos")
                            .foregroundColor(Color.accentColor)
                        + Text(" do local podem atraplahar no recorte do fundo")
                    }
                    .padding(.bottom, 15)
                    
//                    BotaoContinuar(selectedImages: $selectedImages)
//                        .buttonStyle(MyButtonStyle(color: Color.accentColor))
//                        .padding(.top, 20)
                }
                .bold()
                .padding()
            }
        }
//        .navigationTitle("Adicionar peças")
//        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showNextView) {
            Text("\(selectedImages.count)")
        }
        .onChange(of: selectedImages) { _, newValue in
            print(newValue.count)
            if !newValue.isEmpty {
                showNextView = true
            }
        }
    }
}

#Preview {
    AdicionarPecasSheet()
}
