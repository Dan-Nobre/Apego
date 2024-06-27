//
//  CardInfo.swift
//  Apego
//
//  Created by Daniel Nobre on 20/06/24.
//

import SwiftUI

struct CardAddPeca: View {
    @State private var isPresented = false
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5, 5]))
                    .foregroundColor(.gray)
                    .frame(width: 106, height: 106)
                    .foregroundColor(Color.cinza)
                    .opacity(0.4)
                Image(systemName: "plus")
                    .opacity(0.4)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $isPresented, content: {
            VStack {
//                BotaoFoto(showCam: $isPresented, selectedCam: $)
//                    .buttonStyle(MyButtonStyle(color: Color.accentColor))
                BotaoRolo()
                    .buttonStyle(MyButtonStyle(color: Color.accentColor))
              
                BotaoCancelar()
                    .buttonStyle(MySecButtonStyle(color: Color.cinzaClaro))
                    
            }
//            .presentationDetents([.height(300)])
            .padding(.top, 44)
                .frame(width: 393, height: 272)
                .presentationDetents([.fraction(0.25)])
        })
    }
}

struct CardAddPecaVariante: View {
    var body: some View {
        ZStack{
            Rectangle()
                .cornerRadius(10)
                .frame(width: 106, height: 106)
                .foregroundColor(Color.white)
            Image(systemName: "plus")
        }
    }
}

#Preview {
    CardAddPeca()
}
