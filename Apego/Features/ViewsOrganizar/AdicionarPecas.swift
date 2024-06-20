//
//  AdicionarPecas.swift
//  Apego
//
//  Created by Daniel Nobre on 20/06/24.
//

import SwiftUI

struct AdicionarPecas: View {
    @State private var isActive: Bool = false
    var body: some View {
        NavigationView{
            NavigationLink(destination: AdicionarPecasSheet()) {
                Text("oi")
            }
            
        }
    }
}


struct AdicionarPecasSheet: View {
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    CardAddPeca()
                }
                .padding(.top, 64)
                CardInfo()
                    .padding(.top, 31)
                BotaoContinuar()
                    .buttonStyle(MySecButtonStyle(color: .cinzaClaro))
                    .padding(.top, 25)
                Spacer()
            }
        }
        .navigationTitle("ADICIONAR PEÇAS")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    AdicionarPecas()
}
