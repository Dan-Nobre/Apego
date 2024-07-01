//
//  RoupaDetailSheet.swift
//  Apego
//
//  Created by Leticia França on 29/06/24.
//

import SwiftUI

struct RoupaDetailSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var menuSelecionado = 0
    @Bindable var roupa: RoupaModelo
    
    @State private var alerta = false
    
    @State private var toggleState = false
    
    func deletarPeca() {
        modelContext.delete(roupa)
        dismiss()
    }
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    if let foto = roupa.foto, let uiImage = UIImage(data: foto) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .cornerRadius(8)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.gray)
                            .cornerRadius(8)
                    }
                }
                .padding(30)
                
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.terroso.opacity(0.1))
                            .frame(height: 30)
                        
                        Picker("View Selection", selection: $menuSelecionado) {
                            Text("Geral").tag(0)
                            Text("Combinações").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    if menuSelecionado == 0 {
                        GeralView(roupa: roupa, isToggled: $toggleState)
                    } else {
                        CombinacoesView(roupa: roupa)
                    }
                }
                .navigationTitle("Editar peça")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancelar") {
                            dismiss()
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        
    }
}
