//
//  CardInfo.swift
//  Apego
//
//  Created by Daniel Nobre on 20/06/24.
//

import SwiftUI

struct CardInfo: View {
    var body: some View {
//        ZStack{
//            RoundedRectangle(cornerRadius: 9)
//                .frame(width: 352, height: 93)
//                .foregroundColor(.cinzaClaro)
//            //            .opacity(0.4)
//            Text("""
//                Use um local bem iluminado com luz natural e um fundo neutro, como uma parede branca. Garanta que a peça de roupa esteja bem visível, sem sombras ou objetos que possam confundir o recorte automático do fundo.
//                """)
//        }
        VStack{
            Text("""
                Use um local bem iluminado com luz natural e um fundo neutro, como uma parede branca. Garanta que a peça
                de roupa esteja bem visível, sem sombras ou objetos
                que possam confundir o recorte automático do fundo.
                """)
            .font(.system(size: 12))
            .multilineTextAlignment(.leading)
            .padding(10)
            .padding(.vertical)
            .overlay(alignment: .topTrailing) {
                Image(systemName: "info.circle")
                    .font(.system(size: 15))
                    .padding(.top, 6)
            }
        }
        .frame(width: 352)
        .background(Color.cinzaClaro)
        .cornerRadius(9)
        
    }
}

#Preview {
    CardInfo()
}
