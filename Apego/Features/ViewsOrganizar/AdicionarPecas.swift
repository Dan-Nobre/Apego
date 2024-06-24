//
//  AdicionarPecas.swift
//  Apego
//
//  Created by Daniel Nobre on 20/06/24.
//

import SwiftUI

struct AdicionarPecas: View {
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Botão que mostra a sheet
                //                Text("oi")
                //                    .font(.system(size: 20, weight: .semibold))
                //                    .foregroundColor(Color.blue)
                //                    .onTapGesture {
                //                        showSheet.toggle()
                //                    }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showSheet.toggle()
                    })
                    {
                        Image(systemName: "camera.viewfinder")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.principal)
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                AdicionarPecasSheet()
            }
        }
    }
}

#Preview {
    AdicionarPecas()
}
