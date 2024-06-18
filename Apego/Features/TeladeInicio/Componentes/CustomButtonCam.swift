//
//  customButtonCam.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 17/06/24.
//

import SwiftUI
struct CustomButtonCam: View {
    var body: some View {
        Button(action: {
            // Ação do botão
            print("Botão customizado pressionado")
        }) {
            Image(systemName: "camera.viewfinder")
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
                .foregroundColor(.principal)
               
        }
       
    }
}
#Preview {
    CustomButtonCam()
}
