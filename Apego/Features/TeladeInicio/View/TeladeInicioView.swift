//
//  TeladeInicioView.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 17/06/24.
//

import SwiftUI

struct TeladeInicioView: View {
    @State private var title = "Organizar"
    var body: some View {
        NavigationStack {
            Image("avatar")
                .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .navigationTitle($title)
            Text("Adicione suas peças")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black.opacity(0.8))
            Text("Use a 􀎼 para adicionar items no seu guarda roupa ")
                .multilineTextAlignment(.center)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.gray.opacity(0.8))
                .frame(width: 400, height: 5)
        }
        
    }
}

#Preview {
    TeladeInicioView()
}
