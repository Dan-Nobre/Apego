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
struct CardRoupaMenorCombo: View {
    var roupa: RoupaModelo
    var isSelected: Bool
    
    var body: some View {
        VStack {
            if let foto = roupa.foto, let uiImage = UIImage(data: foto) {
                ZStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .cornerRadius(8)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.terroso.opacity(isSelected ? 0.05 : 0))
                        .frame(width: 110, height: 110)
                }
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? Color.terroso : Color.clear, lineWidth: 3)
                )
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 110)
                    .foregroundColor(.gray)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isSelected ? Color.terroso : Color.clear, lineWidth: 3)
                    )
                    .cornerRadius(8)
            }
        }
    }
}

struct CardRoupaMenorComboHorizontal: View {
    var roupa: RoupaModelo
    var isSelected: Bool
    
    var body: some View {
        VStack {
            if let foto = roupa.foto, let uiImage = UIImage(data: foto) {
                ZStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 240, height: 240)
                        .cornerRadius(8)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.terroso.opacity(isSelected ? 0.05 : 0))
                        .frame(width: 240, height: 240)
                }
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? Color.terroso : Color.clear, lineWidth: 3)
                )
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 110)
                    .foregroundColor(.gray)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isSelected ? Color.terroso : Color.clear, lineWidth: 3)
                    )
                    .cornerRadius(8)
            }
        }
    }
}




struct CardRoupaMenor: View {
    var roupa: RoupaModelo
    @State var isSelected: Bool = false
    
    var body: some View {
        VStack {
            if let foto = roupa.foto, let uiImage = UIImage(data: foto) {
                ZStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .cornerRadius(8)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.botao.opacity(isSelected ? 0.2 : 0))
                        .frame(width: 110, height: 110)
                }
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? Color.botao : Color.clear, lineWidth: 3)
                )
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 110)
                    .foregroundColor(.gray)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isSelected ? Color.botao : Color.clear, lineWidth: 3)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.botao.opacity(isSelected ? 0.5 : 0))
                    )
                    .cornerRadius(8)
            }
        }
    }
}

struct CardRoupa2: View {
    var roupa: RoupaModelo
    @State var isSelected: Bool
    
    var body: some View {
        VStack {
            if let foto = roupa.foto, let uiImage = UIImage(data: foto) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 170)
                    .cornerRadius(8)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 170)
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


