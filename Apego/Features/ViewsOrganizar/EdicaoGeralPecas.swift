//
//  SwiftUIView.swift
//  Apego
//
//  Created by Daniel Nobre on 21/06/24.
//

import SwiftUI

struct EdicaoGeralPecas: View {
    @State private var categoriaSelecionada: String?
    var body: some View {
        VStack{
            MyDropDown(title: "Categoria", prompt: "Selecione a categoria", options: categorias, selection: $categoriaSelecionada)
                .padding(.top, 14)
                .padding(.bottom, 14)
                
            MyDropDown(title: "Estado da peça", prompt: "Escolha um estado", options: ["Bom", "Ruim"], selection: $categoriaSelecionada)
                .padding(.bottom, 14)
            MyDropDown(title: "Ocasião", prompt: "Escolha a ocasião", options: ["Casamento", "Festa", "Dia-a-dia"], selection: $categoriaSelecionada)
                .padding(.bottom, 14)
            BotaoFinalizar()
                .buttonStyle(MyButtonStyle(color: Color.accentColor))
        }
        
        //nao esta preenchendo a categoria ali no lugar do prompt
    }
}

#Preview {
    EdicaoGeralPecas()
}
