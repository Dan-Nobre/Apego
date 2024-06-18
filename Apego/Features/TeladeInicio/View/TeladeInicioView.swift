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
    
    var body: some View {
        NavigationView {
            VStack {
                Image("avatar")
                
                Text("Adicione suas peças")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.8))
                Text("Use a \(Image(systemName:"camera.viewfinder"))para adicionar items no seu guarda roupa")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.gray.opacity(0.8))
            }
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        CustomButtonCam()
                            .padding(.top, 95)
                    }
                }
            }
        }
    }
#Preview {
    TeladeInicioView()
}
