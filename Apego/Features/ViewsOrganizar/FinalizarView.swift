// Finalizar.swift
import SwiftUI
import SwiftData

struct Finalizar: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var roupas: [UIImage]
    @Environment(\.modelContext) private var modelContext
    @State private var selectedImage: UIImage?
    


    var body: some View {
        NavigationStack {
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                    ForEach(roupas, id: \.self) { roupa in
                        CardRoupa(roupa: roupa)
                    }
                }
                .padding()
                Button(action: save) {
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
            guard let foto = roupa.jpegData(compressionQuality: 0.1) else {
                continue
            }
            let model = RoupaModelo(categoria: "Sem categoria", foto: foto, cor: "Sem cor", pecasCombinadas: [])
            modelContext.insert(model)
        }
        dismiss()
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
