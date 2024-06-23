//
//  BotaoContinuar.swift
//  Apego
//
//  Created by Daniel Nobre on 20/06/24.
//

import SwiftUI

struct BotaoContinuar: View {
//    @State private var isPresented = true
    var body: some View {
        Button(action:{
//            isPresented.toggle()
        }, label: {
            VStack{
                VStack{
                    Text("Continuar")
                }
            }
        })
    }
}

struct BotaoFinalizar: View {
//    @State private var isPresented = true
    var body: some View {
        Button(action:{
//            isPresented.toggle()
        }, label: {
            VStack{
                VStack{
                    Text("Finalizar")
                }
            }
        })
    }
}

#Preview {
    BotaoContinuar()
}
