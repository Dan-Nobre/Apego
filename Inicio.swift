////
////  Inicio.swift
////  Apego
////
////  Created by Taissa Vitoria Rodrigues de Paula on 21/06/24.
////
//
//import SwiftUI
//
//struct Inicio: View {
//    @State private var title = "Organizar"
//    @State private var showSheet = false
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                Image("bonecoavatar")
//                
//                Text("Adicione suas peças")
//                    .font(.system(size: 20, weight: .semibold))
//                    .foregroundColor(Color.black.opacity(0.8))
//                
//                Text("Use a \(Image(systemName: "camera.viewfinder")) para adicionar itens no seu guarda-roupa")
//                    .multilineTextAlignment(.center)
//                    .font(.system(size: 17, weight: .semibold))
//                    .foregroundColor(Color.gray.opacity(0.8))
//                    .navigationTitle(title)
//                    .toolbar {
//                        
//                        ToolbarItem(placement: .topBarTrailing) {
//                            Button(action: {
//                                showSheet.toggle()
//                            })
//                            {
//                                Image(systemName: "camera.viewfinder")
//                                    .resizable()
//                                    .scaledToFill()
//                                    .frame(width: 30, height: 30)
//                                    .foregroundColor(.principal)
//                            }
//                        }
//                        
//                    }
//                
//            }
//            .sheet(isPresented: $showSheet) {
//                AddPhoto(showSheet: .constant(true))
//            }
//        }
//        
//    }
//}
//
//#Preview {
//    Inicio()
//}
