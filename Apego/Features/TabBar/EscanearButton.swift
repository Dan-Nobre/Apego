//
//  EscanearButton.swift
//  Apego
//
//  Created by Daniel Nobre on 18/06/24.
//

import SwiftUI

struct EscanearButton: View {
    @State private var isPresented = false
    
    var body: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
//            Image()
        })
    }
}

#Preview {
    EscanearButton()
}
