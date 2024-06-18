//
//  TeladeInicioView.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 17/06/24.
//

import SwiftUI
import PhotosUI

struct TeladeInicioView: View {
    @State private var title = "Organizar"
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("avatar")
                
                Text("Adicione suas peças")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black.opacity(0.8))
                
                Text("Use a \(Image(systemName: "camera.viewfinder")) para adicionar itens no seu guarda-roupa")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color.gray.opacity(0.8))
                    .navigationTitle(title)
                    .toolbar {
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                showSheet.toggle()
                            }) {
                                Image(systemName: "camera.viewfinder")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.principal) // Ajuste a cor conforme necessário
                                    }
//                            .padding(.bottom, -95)
                        }
                        
                    }
                
            }
            .sheet(isPresented: $showSheet) {
                AddPhoto()
            }
        }
        
    }
}

struct AddPhoto: View {
    var body: some View {
        Text("Olá, aqui você pode adicionar uma foto!")
    }
}


#Preview {
    TeladeInicioView()
}
