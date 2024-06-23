//
//  CardRoupa.swift
//  Apego
//
//  Created by Daniel Nobre on 21/06/24.
//

import SwiftUI

struct CardRoupa: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            Image("Roupa1")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: 194, height: 207)
        }
    }
}
struct CardRoupaMenor: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            Image("Roupa1")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: 112, height: 112)
        }
    }
}

#Preview {
    CardRoupa()
}
