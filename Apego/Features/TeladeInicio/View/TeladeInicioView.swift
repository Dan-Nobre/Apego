import SwiftUI
import PhotosUI
import SwiftData

let categorias = ["Sem categoria", "Camisa", "Calça", "Vestido", "Casaco", "Short", "Saia", "Blusa", "Camiseta"]
let cores = ["Sem cor", "Vermelho", "Verde", "Azul", "Amarelo", "Preto", "Branco", "Roxo", "Laranja"]


struct TeladeInicioView: View {
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.terroso
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.terroso], for: .normal)
    }
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var title = "Organizar"
    @State var showSheet = false
    @State var roupaSelecionada: RoupaModelo?
    @Query var roupas: [RoupaModelo]
    
    @State var filteredPecas: [RoupaModelo] = []
    @State private var selectedCategory: String? = "Sem categoria"
    
    
    private func filterClothing(by category: String?) {
        if let category = category, !category.isEmpty {
            filteredPecas = roupas.filter { $0.categoria == category }
        } else {
            filteredPecas = roupas
        }
    }
    
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
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(categorias, id: \.self) { category in
                                    Button(action: {
                                        selectedCategory = category
                                        filterClothing(by: category)
                                    }) {
                                        Text(category)
                                            .padding(8)
                                            .padding(.horizontal, 10)
                                            .foregroundColor(selectedCategory == category ? Color.white : Color.principal)
                                            .background(selectedCategory == category ? Color.principal : Color.bege)
                                            .cornerRadius(10)
                                            .padding(2)
                                    }
                                }
                            }
                            .padding()
                        }
                        
                        if filteredPecas.isEmpty {
                            Text("Nenhuma peça encontrada")
                                .padding()
                        } else {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                                ForEach(filteredPecas, id: \.self) { roupa in
                                    CardRoupa2(roupa: roupa, isSelected: roupa == roupaSelecionada)
                                        .onTapGesture {
                                            roupaSelecionada = roupa
                                            showSheet.toggle()
                                        }
                                }
                            }
                            .padding()
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle(title)
                .toolbarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: Adicionar()) {
                            Image(systemName: "camera.viewfinder")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.terroso)
                        }
                    }
                }
                .sheet(isPresented: $showSheet, onDismiss: {
                    filterClothing(by: selectedCategory)
                }) {
                    if let roupaSelecionada = roupaSelecionada {
                        RoupaDetailView(roupa: roupaSelecionada)
                    }
                }
                .onAppear {
                    filterClothing(by: selectedCategory)
                }
            }
        }
        .onChange(of: roupas) { _ in
            filterClothing(by: selectedCategory)
        }
    }
}


struct RoupaDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var menuSelecionado = 0
    @Bindable var roupa: RoupaModelo
    
    @State private var alerta = false
    
    @State private var toggleState = false
    
    func deletarPeca() {
        modelContext.delete(roupa)
        dismiss()
    }
    
    
    var body: some View {
        NavigationView{
            VStack {
                VStack {
                    if let foto = roupa.foto, let uiImage = UIImage(data: foto) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .cornerRadius(8)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.gray)
                            .cornerRadius(8)
                    }
                }
                .padding(20)
                
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.terroso.opacity(0.1))
                            .frame(height: 30)
                        Picker("View Selection", selection: $menuSelecionado) {
                            Text("Geral").tag(0)
                            Text("Combinações").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    if menuSelecionado == 0 {
                        GeralView(roupa: roupa, isToggled: $toggleState)
                    } else {
                        CombinacoesView(roupa: roupa)
                    }
                }
                .navigationTitle("Editar peça")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancelar") {
                            dismiss()
                        }
                    }
                }
            Text("Excluir peça")
                .underline()
                .foregroundColor(.red)
                .onTapGesture{
                    alerta = true
                } .alert(isPresented: $alerta) {
                    Alert(
                        title: Text("Excluir peça"),
                        message: Text("Tem certeza que deseja excluir esta peça?"),
                        primaryButton: .default(Text("Cancelar")),
                        secondaryButton: .destructive(Text("Excluir"), action: deletarPeca)
                    )
                }
                .padding(.bottom, 10)
                Spacer()
                
            }
            .padding(.horizontal, 20)
        }
    }
}


struct GeralView: View {
    @Bindable var roupa: RoupaModelo
    @State var tempCategoriaSelecionada: String
    @State var tempCorSelecionada: String
    @Environment(\.dismiss) var dismiss
    
    @State var corSelecionada = ""
    
//    @Binding var isToggled: Bool
    
    init(roupa: RoupaModelo, isToggled: Binding<Bool>) {
        self.roupa = roupa
        _tempCategoriaSelecionada = State(initialValue: roupa.categoria)
        _tempCorSelecionada = State(initialValue: roupa.cor)
//        self._isToggled = isToggled
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Categoria")
                    .font(.headline)
                    .fontWeight(.medium)
                
                Menu {
                    Picker(selection: $tempCategoriaSelecionada, label: EmptyView()) {
                        ForEach(categorias, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
                    .onChange(of: tempCategoriaSelecionada) { novaCategoria in
                        tempCategoriaSelecionada = novaCategoria
                    }
                    .onAppear {
                        tempCategoriaSelecionada = roupa.categoria
                    }
                } label: {
                    HStack {
                        Text(tempCategoriaSelecionada)
                            .padding(10)
                        Spacer()
                        Image(systemName: "chevron.up.chevron.down")
                            .padding(10)
                    }
                    .background(Color.cinzinha.opacity(0.5))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Cor")
                    .font(.headline)
                    .fontWeight(.medium)
                
                Menu {
                    Picker(selection: $tempCorSelecionada, label: EmptyView()) {
                        ForEach(cores, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
                    .onChange(of: tempCorSelecionada) { novaCor in
                        tempCorSelecionada = novaCor
                    }
                    .onAppear {
                        tempCorSelecionada = roupa.cor
                    }
                } label: {
                    HStack {
                        Text(tempCorSelecionada)
                            .padding(10)
                        Spacer()
                        Image(systemName: "chevron.up.chevron.down")
                            .padding(10)
                    }
                    .background(Color.cinzinha.opacity(0.5))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            Button(action: {
                roupa.categoria = tempCategoriaSelecionada
                roupa.cor = tempCorSelecionada
//                isToggled = false
                dismiss()
            }) {
                Text("Salvar")
            }
            .buttonStyle(MyButtonStyle(color: Color.accentColor))
        }
        .padding()
    }
}


struct CombinacoesView: View {
    var roupa: RoupaModelo
    @Query var roupas: [RoupaModelo]
    var body: some View {
//        ScrollView(.vertical, showsIndicators: false){
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
//                ForEach(roupas, id: \.self) { roupa in
//                    CardRoupaMenor(roupa: roupa, isSelected: false)
//                }
//            }
//        }
        Text("Tudo queito por enquanto 👀")
    }
}
