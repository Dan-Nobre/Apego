//
//  customButtonCam.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 17/06/24.
//

import SwiftUI
struct CustomButtonCam: View {
    @State private var isPresented = false
    
    var body: some View {
        Button(action: {
            isPresented.toggle()
            print("Botão customizado pressionado")
        }, label: {
            Image(systemName: "camera.viewfinder")
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
                .foregroundColor(.principal)
        })
        
        .sheet(isPresented: $isPresented, content: {
            VStack{
                BotaoFoto()
                    .buttonStyle(MyButtonStyle(color: Color.accentColor))
                BotaoRolo()
                    .buttonStyle(MyButtonStyle(color: Color.accentColor))
                BotaoCancelar()
                    .buttonStyle(MySecButtonStyle(color: Color.cinzaClaro))
                    
            }
//            .presentationDetents([.height(300)])
            .padding(.top, 44)
                .frame(width: 393, height: 272)
                .presentationDetents([.fraction(0.25)])
        })
        
       
    }
}

#Preview {
    CustomButtonCam()
}
