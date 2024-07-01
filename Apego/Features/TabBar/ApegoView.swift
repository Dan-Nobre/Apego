import SwiftUI
import SwiftData

struct ApegoView: View {
    @ObservedObject var roupa: RoupaModelo
    @Environment(\.modelContext) private var modelContext
    @State private var imageData: Data?

    var body: some View {
        NavigationStack {
            VStack {
                if let data = imageData, let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .padding()
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(8)
                } else {
                    Text("Nenhuma foto disponível")
                }
            }
            .navigationTitle("Apego")
            .onAppear {
                loadImage()
            }
        }
    }

    private func loadImage() {
        imageData = roupa.foto
    }

    private func saveImage() {
        roupa.foto = imageData
        do {
            try modelContext.save()
            print("Imagem salva")
        } catch {
            print("Erro ao salvar imagem: \(error)")
        }
    }
}

//#Preview {
//    let context = ModelContext(for: RoupaModelo.self)
//    let roupa = RoupaModelo(categoria: "Camisa", foto: nil, cor: "Azul", pecasCombinadas: [])
//    context.insert(roupa)
//    return ApegoView(roupa: roupa)
//        .environment(\.modelContext, context)
//}
