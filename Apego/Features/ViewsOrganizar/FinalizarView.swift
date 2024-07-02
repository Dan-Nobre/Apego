
 import SwiftUI
 import SwiftData

struct Finalizar: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var roupas: [UIImage]
    @Environment(\.modelContext) private var modelContext
    @State private var clothingTypes: [String]

    init(roupas: Binding<[UIImage]>) {
        self._roupas = roupas
        self._clothingTypes = State(initialValue: Array(repeating: "", count: roupas.wrappedValue.count))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView (.vertical, showsIndicators: false) {
                VStack {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                        ForEach(roupas.indices, id: \.self) { index in
                            CardRoupa(roupa: roupas[index], clothingType: $clothingTypes[index])
                        }
                    }
                    .padding()
                    Button(action: save) {
                        VStack {
                            Text("Salvar")
                                .bold()
                        }
                    }
                    .padding()
                    .buttonStyle(MyButtonStyle(color: Color.terroso))
                    Spacer()
                }
            }
            
        }
        .navigationTitle("Adicionar peças")
        .navigationBarTitleDisplayMode(.inline)
    }

    func save() {
        for (index, roupa) in roupas.enumerated() {
            guard let foto = roupa.jpegData(compressionQuality: 0.1) else {
                continue
            }
            let model = RoupaModelo(categoria: clothingTypes[index], foto: foto, cor: "Sem cor", pecasCombinadas: [], isDesapegada: false)
            modelContext.insert(model)
        }
        dismiss()
    }
}



 
