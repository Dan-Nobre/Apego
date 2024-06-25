//
//  OrganizarView.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 24/06/24.
//

import SwiftUI

struct OrganizarViewModel: View {
    @State private var title = "Organizar"
    @State private var showSheet = false
    
    @State private var pecas: [String] = []
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    if pecas.isEmpty {
                        
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
    OrganizarViewModel()
}
