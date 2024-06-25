//
//  BotaoContinuar.swift
//  Apego
//
//  Created by Daniel Nobre on 20/06/24.
//

import SwiftUI

//let imageStore = ImageStore()

struct BotaoContinuar: View {
    @State private var isPresented = false
    @Binding var selectedImages: [Image]
    
    var body: some View {
        Button(action:{
            isPresented.toggle()
        }, label: {
            VStack{
                VStack{
                    Text("Continuar")
                }
            }
        })
        .sheet(isPresented: $isPresented, content: {
            VStack {
                BotaoFoto()
                    .buttonStyle(MyButtonStyle(color: Color.accentColor))
                    .padding(.bottom, 15)
                BotaoVariasImagens(selectedImages: $selectedImages)
                    .buttonStyle(MyButtonStyle(color: Color.accentColor))
                    .padding(.bottom, 15)
                BotaoCancelar()
                    .buttonStyle(MySecButtonStyle(color: Color.cinzinha))
                    
            }
            .bold()
//            .presentationDetents([.height(300)])
            .padding(.top, 44)
                .frame(width: 393, height: 272)
                .presentationDetents([.fraction(0.30)])
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

struct BotaoSalvar: View {
//    @State private var isPresented = true
    var body: some View {
        Button(action:{
//            isPresented.toggle()
        }, label: {
            VStack{
                VStack{
                    Text("Salvar")
                }
            }
        })
    }
}

//#Preview {
//    BotaoContinuar()
//}
