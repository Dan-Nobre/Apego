//
//  ColorPicker.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 24/06/24.
//

import SwiftUI

struct ColorPickerView: View {
    var body: some View {
        @State private var selectedColor: Color = .re
        
        VStack{
            ColorPicker("escolha a cor", selection: <#T##Binding<Color>#>)
        }
            
        }
      
}

#Preview {
    ColorPickerView()
}
