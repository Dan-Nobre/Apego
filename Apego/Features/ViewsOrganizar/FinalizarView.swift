//
//  Finalizar.swift
//  Apego
//
//  Created by Daniel Nobre on 25/06/24.
//

import SwiftUI

struct Finalizar: View {
    @Binding var roupas: [UIImage]
    
    var body: some View {
        NavigationStack{
            
            VStack{
                HStack{
                    ForEach(roupas, id: \.self) { roupa in
                        CardRoupa(roupa: roupa)
                    }
//                    CardRoupa(roupas:)
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
    
    func save() {
        let imageDatas = roupas.map { $0.jpegData(compressionQuality: 1.0) }
        // codigo que salva no swift data
    }
}

#Preview {
    Finalizar(roupas: .constant([
        .roupa1
    ]))
}
