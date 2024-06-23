//
//  MyTextField.swift
//  Apego
//
//  Created by Daniel Nobre on 21/06/24.
//
import Foundation
import SwiftUI

struct MyTextFieldApego: View {
    @State private var selection = "Escolha a categoria"
        let colors = ["Camisa", "Calça", "Sapato", "Acessório""]

        var body: some View {
            VStack {
                Picker("Select a paint color", selection: $selection) {
                    ForEach(colors, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)

                Text("Selected color: \(selection)")
            }
        }
}

#Preview {
    MyTextFieldApego()
}
