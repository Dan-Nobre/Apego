//
//  CardRoupa.swift
//  Apego
//
//  Created by Daniel Nobre on 21/06/24.
//

import SwiftUI

struct CardRoupa: View {
    let roupa: UIImage
    
    var body: some View {
        RoundedRectangle(cornerRadius: 11)
            .stroke(
                .gray.opacity(0.5),
                style: .init(
                    lineWidth: 3,
                    dash: [5,5]
                )
            )
            .overlay {
                Image(uiImage: roupa)
                    .resizable()
                    .scaledToFill()
            }
            .aspectRatio(1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 11))
    }
}

#Preview {
    NavigationStack{
        
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(100)), count: 3)) {
                ForEach([0,1,2], id: \.self) { _ in
                    CardRoupa(roupa: .avatar)
                }
            }
            .padding()
            BotaoSalvar()
                .buttonStyle(MyButtonStyle(color: Color.accentColor))
            Spacer()
        }
    }
    .navigationTitle("Adicione peças")
    .navigationBarTitleDisplayMode(.inline)
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


struct CardRoupa2: View {
    var roupa: RoupaModelo

    var body: some View {
        VStack {
            if let foto = roupa.foto, let uiImage = UIImage(data: foto) {
//                Image(uiImage: uiImage)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 170, height: 170)
//                    .cornerRadius(8)
                RoundedRectangle(cornerRadius: 11)
                    .stroke(
                        .gray.opacity(0.5),
                        style: .init(
                            lineWidth: 3,
                            dash: [5,5]
                        )
                    )
                    .overlay {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 11))
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                    .cornerRadius(8)
            }
        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(8)
//        .shadow(radius: 4)
    }
}


