////  ContentView.swift
////  Apego
////
////  Created by Daniel Nobre on 17/06/24.
////
//

import SwiftUI
import SwiftData


struct ContentView: View{
    @Environment (\.modelContext) private var modelContext
    @Query private var roupas: [RoupaModelo]
    @State private var nome: String = ""
    @State private var categoria: String = ""
    @State private var cor: String = ""
    @State private var imageData: Data = Data()
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack{
            List{
                ForEach(roupas, id: \.id) { roupa in
                    HStack{
                        if let imageData = roupa.foto, let image = UIImage(data: imageData) {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                        VStack(alignment: .leading) {
                            Text(roupa.nome)
                            Text(roupa.categoria).font(.subheadline).foregroundColor(.gray)
                            Text(roupa.cor).font(.subheadline).foregroundColor(.gray)
                        }
                        Spacer()
                        Button(action: {
                            removeItem(roupa)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            
            TextField("Nome", text: $nome)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Categoria", text: $categoria)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Cor", text: $cor)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                showingImagePicker = true
            }) {
                Text("Selecionar Imagem")
            }
            .padding()
            
            Button(action: {
                save()
            }) {
                Text("Adicionar Item")
            }
            .padding()
        }
        .navigationTitle("Gerenciamento de Roupas")
        .sheet(isPresented: $showingImagePicker) {
            ImagePickerModel(imageData: $imageData)
        }
    }
    
    private func save() {
        withAnimation{
            let novaRoupa = RoupaModelo(nome: nome, categoria: categoria,foto:imageData,cor: cor)
            modelContext.insert(novaRoupa)
            saveContext()
            
            // Limpar cache depois de add
            nome = ""
            categoria = ""
            cor = ""
            imageData = Data()
        }
    }
    
    
    private func removeItem(_ roupa: RoupaModelo) {
        withAnimation{
            modelContext.delete(roupa)
            saveContext()
        }
    }
    
    private func removeItems(at offset: IndexSet) {
        withAnimation {
            offset.map { roupas[$0] }.forEach(modelContext.delete)
            saveContext()
            }
        }
    
    private func saveContext() {
        do{
            try modelContext.save()
        } catch{
            //tratamento de erro
            let nsError = error as NSError
            fatalError("Erro ao salvar o contexto: \(nsError), \(nsError.userInfo)")
        }
    }
}
    

    
    
    
    


//#Preview {
//    ContentView()
//}



//import SwiftUI
//import SwiftData
//
//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
