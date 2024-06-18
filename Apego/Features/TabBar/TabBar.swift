//
//  TabBar.swift
//  Apego
//
//  Created by Daniel Nobre on 18/06/24.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        NavigationView {
            TabView{
                TeladeInicioView()
                    .tabItem {
                        Label("Organizar", systemImage: "cabinet")
                    }
                CombinarView()
                    .tabItem {
                        Image(systemName: "circlebadge.2.fill") .font(.system(size: 22))
                        Text("Combinar")
    //                    Label("Combinar", systemImage: "circlebadge.2.fill")
                    }
                ApegoView()
                    .tabItem {
                        Label("Apego", systemImage: "shippingbox.fill")
                    }
            }
        }
    }
}

#Preview {
    TabBar()
}
