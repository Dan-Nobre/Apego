//
//  TeladeInicioView.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 17/06/24.
//

import SwiftUI
import PhotosUI

struct TeladeInicioView: View {
    @State private var title = "Organizar"
    @State private var showSheet = false
    
    @State private var pecas: [String] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Text(" ").font(.system(size: .leastNormalMagnitude)) // gambiarra pra fixar large title :P triste
                ScrollView {
                    if pecas.isEmpty {
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
                        ForEach(pecas, id: \.self) {
                            Text($0)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle(title)
                .toolbarTitleDisplayMode(.large)
                .toolbar {
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        //                            Button(action: {
                        //                                showSheet.toggle()
                        //                            })
                        //                            {
                        //                                Image(systemName: "camera.viewfinder")
                        //                                    .resizable()
                        //                                    .scaledToFill()
                        //                                    .frame(width: 30, height: 30)
                        //                                    .foregroundColor(.principal)
                        //                                    .zIndex(1.0)
                        //                            }
                        NavigationLink(destination: AdicionarPecasSheet()){
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
    
}
#Preview {
    TeladeInicioView()
}
