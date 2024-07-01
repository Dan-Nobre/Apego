//
//  TabBar.swift
//  Apego
//
//  Created by Daniel Nobre on 18/06/24.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        
        TabView{
            TeladeInicioView()
                .tabItem{
                    Label("Organizar", systemImage: "cabinet")
                }
            
            ApegoView(roupa: RoupaModelo(categoria: "Exemplo", foto: nil, cor: "Exemplo", pecasCombinadas: []))                
                .tabItem {
                    Label("Apego", systemImage: "shippingbox.fill")
                    Color.cinzinha
                }
        }
        .background(Color.white)
    }
      
}
#Preview {
    TabBar()
}
