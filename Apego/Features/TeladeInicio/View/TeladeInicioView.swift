//
//  TeladeInicioView.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 17/06/24.
//

import SwiftUI
import PhotosUI
import SwiftData

struct TeladeInicioView: View {
    @Environment (\.modelContext) private var modelContext
    @State private var title = "Organizar"
    @State private var showSheet = false
    @Query private var roupas: [RoupaModelo]
    
//    @State private var pecas: [String] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(" ").font(.system(size: .leastNormalMagnitude)) // gambiarra pra fixar large title :P triste
                ScrollView {
                    if roupas.isEmpty {
                        VStack {
                            Image("avatar")
                            Text("Adicione suas peças")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color.black.opacity(0.8))
                            
                            Text("Use a \(Image(systemName: "camera.viewfinder")) para adicionar itens no seu guarda-roupa")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(Color.gray.opacity(0.8))
                        }
                        .containerRelativeFrame(.vertical)
                    } else {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                            ForEach(roupas, id: \.self) { roupa in
                                CardRoupa2(roupa: roupa, deleteAction: {
                                    deleteItem(roupa)
                                })
                            }
                        }
                        .padding()
                    }
                }
                .scrollIndicators(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle(title)
                .toolbarTitleDisplayMode(.large)
                .toolbar {
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: Adicionar()){
                            Image(systemName: "camera.viewfinder")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.principal)
                            //.padding(.top, 95)
                            //                                    .zIndex(3.0)
                        }
                    }
                    
                }
                //            .sheet(isPresented: $showSheet) {
                //                AdicionarPecasSheet()
                //            }
            }
        }
    }
    
    private func deleteItem(_ roupa: RoupaModelo) {
        withAnimation{
            modelContext.delete(roupa)
            saveContext()
        }
    }
    private func saveContext() {
        do{
            try modelContext.save()
        }catch {
            //tratamento de erro
            let nsError = error as NSError
            fatalError("Erro ao salvar contexto: \(nsError), \(nsError.userInfo)")
        }
    }
    
    
}
#Preview {
    TeladeInicioView()
        .modelContainer(for: RoupaModelo.self, inMemory: true)
}
