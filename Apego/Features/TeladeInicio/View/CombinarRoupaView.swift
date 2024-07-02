//
//  CombinarRoupaView.swift
//  Apego
//
//  Created by Leticia França on 29/06/24.
//

import SwiftUI
import PhotosUI
import SwiftData

struct CombinarRoupaView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Bindable var roupa: RoupaModelo
    @Query var roupas: [RoupaModelo]
    
    @State private var modoGrid = true
    
    @State private var tempFinal: [RoupaModelo] = []
    @State private var roupasSelecionadas: [RoupaModelo] = []
    
    private func toggleSelecionar(for roupa: RoupaModelo) {
        if roupasSelecionadas.contains(roupa) {
            roupasSelecionadas.removeAll(where: { $0 == roupa })
        } else {
            roupasSelecionadas.append(roupa)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text("Modo grade ativado")
                            .bold()
                        
                        Toggle("", isOn: $modoGrid)
                            .toggleStyle(SwitchToggleStyle(tint: .terroso))
                    }
                    Text("O modo grade permite uma visualização mais rápida de todas as peças. Clique para alternar entre modos de exibição")
                        .font(.system(size: 14))
                        .multilineTextAlignment(.leading)
                }
                    if modoGrid {
                        withAnimation {
                            modoGrade
                        }
                    } else {
                        withAnimation {
                            modoProvador
                        }
                    }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Combinar peça")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        self.tempFinal = self.roupasSelecionadas
                        roupa.pecasCombinadas = tempFinal
                        dismiss()
                    }
                }
            }
            
        }
    }
    
    var modoProvador: some View {
        VStack {
            if let foto = roupa.foto, let uiImage = UIImage(data: foto) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 240, height: 240)
                    .cornerRadius(8)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 240, height: 240)
                    .foregroundColor(.gray)
                    .cornerRadius(8)
            }
            
            TabView{
                ForEach(roupas, id: \.self) { roupaItem in
                    CardRoupaMenorComboHorizontal(roupa: roupaItem, isSelected: self.roupasSelecionadas.contains(roupaItem))
                    
                        .onTapGesture {
                            print(self.roupasSelecionadas.contains(roupaItem))
                            self.toggleSelecionar(for: roupaItem)
                        }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            Spacer()
        }
    }
    
    var modoGrade: some View {
        VStack {
            if let foto = roupa.foto, let uiImage = UIImage(data: foto) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .cornerRadius(8)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .foregroundColor(.gray)
                    .cornerRadius(8)
            }
            
            ScrollView (.vertical, showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                    ForEach(roupas, id: \.self) { roupaItem in
                        CardRoupaMenorCombo(roupa: roupaItem, isSelected: self.roupasSelecionadas.contains(roupaItem))
                        
                            .onTapGesture {
                                print(self.roupasSelecionadas.contains(roupaItem))
                                self.toggleSelecionar(for: roupaItem)
                            }
                    }
                }
            }
        }
    }
}
