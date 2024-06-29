//
//  AdicionarPecasSheet.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 21/06/24.
//

import SwiftUI

struct AdicionarPecasSheet: View {
    
    @State var showNextView: Bool = false
    @State var selectedImages: [Image] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Adicionar peças!")
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
                    .lineLimit(2, reservesSpace: true)
//                    .padding(.bottom, 15)
                    HStack(alignment: .top){
                        Image(systemName: "square.dashed")
                        Text("Centralizar a câmera")
                            .foregroundColor(Color.accentColor)
                        + Text(" na peça dá uma foto melhor")
                    }
                    .lineLimit(2, reservesSpace: true)
                    .padding(.bottom, 15)
                    HStack(alignment: .top){
                        Image(systemName: "wand.and.stars.inverse")
                        Text("Sombras e objetos")
                            .foregroundColor(Color.accentColor)
                        + Text(" do local podem atrapalhar no recorte do fundo")
                    }
                    .lineLimit(2, reservesSpace: true)
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
