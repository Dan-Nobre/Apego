//
//  customButtonCam.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 17/06/24.
//

import SwiftUI
struct CustomButtonCam: View {
    @State var showSheet: Bool = false
    var body: some View {
        Button(action: {
            // Ação do botão
            print("Botão customizado pressionado antes de toggle, showSheet: \(showSheet)")
            showSheet.toggle()
            print("Botão customizado pressionado depois de toggle, showSheet: \(showSheet)")
            
        }){
            Image(systemName: "camera.viewfinder")
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
                .foregroundColor(.principal)
            
        }
        .sheet(isPresented: $showSheet, content:{
            AddPhoto()
        })
        
    }
}

struct AddPhoto: View {
    var body: some View {
        Text("olaaa")
            .onAppear {
                print("AddPhoto View apareceu")
            }
    }
}
#Preview {
    CustomButtonCam()
}
