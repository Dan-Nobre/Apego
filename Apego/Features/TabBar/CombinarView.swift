//
//  CombinarView.swift
//  Apego
//
//  Created by Daniel Nobre on 18/06/24.
//

import SwiftUI

struct CombinarView: View {
    var body: some View {
        NavigationView{
            Text("Tudo quieto por enquanto 👀")
                .navigationTitle("Combinar Roupas")
                .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    CombinarView()
}
