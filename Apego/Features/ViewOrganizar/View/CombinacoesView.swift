//
//  CombinacoesView.swift
//  Apego
//
//  Created by Leticia França on 29/06/24.
//

import SwiftUI
import PhotosUI
import SwiftData

struct CombinacoesView: View {
    var roupa: RoupaModelo
    @Query var roupas: [RoupaModelo]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            if roupa.pecasCombinadas.isEmpty {
                VStack (alignment: .center) {
                    Text("Você ainda não fez combinações com essa peça!")
                        .multilineTextAlignment(.center)
                }
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                    ForEach(roupa.pecasCombinadas, id: \.self) { roupa in
                        CardRoupaMenor(roupa: roupa, isSelected: false)
                    }
                }
            }
            
        }
    }
}
