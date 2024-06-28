//
//  OrganizarViewTela.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 24/06/24.
//

import SwiftUI

struct OrganizarViewTela: View {
    @ObservedObject var viewModel = ClothingViewModel()
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    let editarPecaTip = EditarPecaTip()
    
    let categories = ["Sem categoria", "Camisas", "Blusas", "Shorts", "Saias", "Vestidos"]
    var body: some View {
        NavigationView {
            VStack {
             
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                viewModel.selectedCategory = category
                                viewModel.filterClothing(by: category)
                            }) {
                                Text(category)
                                    .padding(8)
                                    .padding(.horizontal, 8)
                                    .foregroundColor(viewModel.selectedCategory == category ?
                                                     Color.white: Color.principal)
                                    .background(viewModel.selectedCategory == category ? Color.principal : Color.bege)
                                    .cornerRadius(10)
                                    .padding(2)
                            }
                        }
                    }
                    .padding()
                }
 
                ScrollView {
                    if viewModel.filteredPecas.isEmpty {
                        Text("Nenhuma peça encontrada")
                            .padding()
                    } else {
                        LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                            ForEach(viewModel.filteredPecas) { peca in
                                VStack {
                                    Image(uiImage: peca.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 50)
                                        .padding()
                                        .background(Color.secondary.opacity(0.1))
                                        .cornerRadius(8)
                    
                                }
                                .popoverTip(editarPecaTip)
                                .padding()
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("Organizar")
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AdicionarPecasSheet()) {
                            Image(systemName: "camera.viewfinder")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.principal)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OrganizarViewTela()
}
