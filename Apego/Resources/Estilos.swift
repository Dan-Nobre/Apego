//
//  Estilos.swift
//  Apego
//
//  Created by Daniel Nobre on 19/06/24.
//

import SwiftUI

struct MySecButtonStyle: ButtonStyle {
    
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 352, height: 49)
            .background(color)
            .cornerRadius(40)
            .foregroundColor(.black)
            .font(.body)
    }
}

struct MyDesatButtonStyle: ButtonStyle {
    
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 12)
            .frame(width: 200)
            .background(color.opacity(0.5))
            .cornerRadius(50)
            .foregroundColor(.white)
            .font(.body)
            .fontWeight(.bold)
    }
}

struct MyButtonStyle: ButtonStyle {
    
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 352, height: 49)
            .background(color)
            .cornerRadius(40)
            .foregroundColor(.white)
            .font(.body)
    }
}
