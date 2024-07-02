//
//  FiltroView.swift
//  Apego
//
//  Created by Daniel Nobre on 28/06/24.
//

import SwiftUI
import SwiftData

struct FiltroView: View {
    let categorias = ["Todas as peças", "Camisa", "Calça", "Vestido", "Casaco", "Short", "Saia", "Blusa", "Camiseta"]
    let cores = ["Sem cor", "Vermelho", "Verde", "Azul", "Amarelo", "Preto", "Branco", "Roxo", "Laranja"]

    @State private var selectedCategory: String? = "Sem categoria"
    @State var filteredPecas: [RoupaModelo] = []
    @Query var roupas: [RoupaModelo]
    
    func filterClothing(by category: String?) {
        if let category = category, !category.isEmpty {
            filteredPecas = roupas.filter { $0.categoria == category }
        } else {
            filteredPecas = roupas
        }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categorias, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                        filterClothing(by: category)
                    }) {
                        Text(category)
                            .padding(8)
                            .padding(.horizontal, 10)
                            .foregroundColor(selectedCategory == category ? Color.white : Color.principal)
                            .background(selectedCategory == category ? Color.principal : Color.bege)
                            .cornerRadius(10)
                            .padding(2)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    FiltroView()
}
