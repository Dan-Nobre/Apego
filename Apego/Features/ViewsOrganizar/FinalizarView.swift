//
//  Finalizar.swift
//  Apego
//
//  Created by Daniel Nobre on 25/06/24.
//

import SwiftUI
import SwiftData

struct Finalizar: View {
    @Binding var roupas: [UIImage]
    @Environment(\.modelContext) private var modelContext
    @State private var selectedImage: UIImage?

    var body: some View {
        NavigationStack{
            
            VStack{
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                    ForEach(roupas, id: \.self) { roupa in
                        CardRoupa(roupa: roupa)
                    }
                }
                .padding()
                Button(action: save) { // Passando a função save() como ação do botão
                            VStack {
                                Text("Salvar")
                            }
                        }
                        .padding()
                    .buttonStyle(MyButtonStyle(color: Color.accentColor))
                Spacer()
            }
        }
        .navigationTitle("Adicione peças")
        .navigationBarTitleDisplayMode(.inline)
    }
    func save() {
        for roupa in roupas {
            let fotoData = roupa.jpegData(compressionQuality: 1.0)!
            let novaRoupa = RoupaModelo(nome: "", categoria: "", foto: fotoData, cor:"")
            modelContext.insert(novaRoupa)
            
        }
        
        do{
            try modelContext.save()
        }catch{
            let nsError = error as NSError
            fatalError("Erro ao salvar o contexto: file: \(nsError),  \(nsError.userInfo)")
        }
        // codigo que salva no swift data
    }

}

