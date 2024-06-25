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
