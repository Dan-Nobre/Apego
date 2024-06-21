//
//  AdicionarPecasSheet.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 21/06/24.
//

import SwiftUI

struct AdicionarPecasSheet: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
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
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close") {
                    // Código para fechar a sheet
                    // É automaticamente gerenciado pelo .sheet em AdicionarPecas
                }
            }
        }
    }
}

#Preview {
    AdicionarPecasSheet()
}
