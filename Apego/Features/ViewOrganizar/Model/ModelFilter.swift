//
//  ModelFilter.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 24/06/24.
//

import SwiftUI

class ClothingViewModel: ObservableObject {
    @Published var pecas: [Peca] = []
    @Published var filteredPecas: [Peca] = []
    @Published var selectedCategory: String = "Todas"
    
    init() {
        // Inicialmente, todas as peças são filtradas
        let exemploPeca = Peca(name: "Camisa Azul", image: UIImage(systemName: "photo")!, color: "Azul", category: "Camisas")
               pecas.append(exemploPeca)
        filterClothing(by: selectedCategory)
    }
    
    func addPeca(_ peca: Peca) {
        pecas.append(peca)
        filterClothing(by: selectedCategory)
    }
    
    func filterClothing(by category: String) {
        if category == "Todas" {
            filteredPecas = pecas
        } else {
            filteredPecas = pecas.filter { $0.category == category }
        }
    }
}

//#Preview {
//    ModelFilter()
//}
