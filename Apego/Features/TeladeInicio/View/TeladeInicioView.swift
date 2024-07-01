import SwiftUI
import PhotosUI
import SwiftData

let categorias = ["Sem categoria", "Camisa", "Calça", "Vestido", "Casaco", "Short", "Saia", "Blusa", "Camiseta"]
let cores = ["Sem cor", "Vermelho", "Verde", "Azul", "Amarelo", "Preto", "Branco", "Roxo", "Laranja"]

struct TeladeInicioView: View {
    
    init() {
        let appearance = UISegmentedControl.appearance()
        appearance.selectedSegmentTintColor = UIColor.white
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.terroso], for: .selected)
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.terroso], for: .normal)
        UIPageControl.appearance().currentPageIndicatorTintColor = .terroso
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.terroso.withAlphaComponent(0.2)
        UIPageControl.appearance().backgroundStyle = .minimal
    }
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var alertaExcluir = false
    
    @State private var alertaDesapegar = false
    
    @State private var title = "Organizar"
    @State private var showSheetDetail = false
    @State private var showSheetCombo = false
    @State private var roupaSelecionada: RoupaModelo?
    @Query private var roupas: [RoupaModelo]
    @State private var filteredPecas: [RoupaModelo] = []
    @State private var selectedCategory: String? = "Sem categoria"
    
    @State private var size = CGSize(width: 50, height: 50)
    @State private var isHeaderSticky = false
    @State private var headerOffset: CGFloat = 0
    
    private func deletarPeca() {
        if let roupa = roupaSelecionada {
            modelContext.delete(roupa)
        }
    }
    private func desapegarPeca() {
        if let roupa = roupaSelecionada {
            roupa.isDesapegada = true
        }
    }
    private func reapegarPeca() {
        if let roupa = roupaSelecionada {
            roupa.isDesapegada = false
        }
    }
    private func filterClothing(by category: String?) {
        filteredPecas = category?.isEmpty == false ? roupas.filter { $0.categoria == category } : roupas
    }
    var body: some View {
        
        NavigationStack {
            ScrollViewReader { proxy in
                scrollPrincipal
                .toolbarTitleDisplayMode(.inlineLarge)
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
                .toolbarBackground(Color.rosinha)
                .coordinateSpace(name: "scrollView")
                .navigationBarTitle("Armário", displayMode: .inline)
                .scrollIndicators(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .sheet(isPresented: $showSheetDetail, onDismiss: {
                    filterClothing(by: selectedCategory)
                }) {
                    if let roupaSelecionada = roupaSelecionada {
                        RoupaDetailSheet(roupa: roupaSelecionada)
                    }
                }
                .onAppear {
                    filterClothing(by: selectedCategory)
                }
                .sheet(isPresented: $showSheetCombo, onDismiss: {
                    filterClothing(by: selectedCategory)
                }) {
                    if let roupaSelecionada = roupaSelecionada {
                        CombinarRoupaView(roupa: roupaSelecionada)
                    }
                }
                //                .blendMode(.multiply)
                //                .background(.thickMaterial)
                //
                //                .toolbarBackground(
                //                                ZStack {
                //                                    (isHeaderSticky ? Color.white : Color.rosinha)
                //                                    .blendMode(.multiply)
                //                                    .background(.thickMaterial)
                //                                }
                //                            )
//                .background(roupas.isEmpty ? Color.terroso.opacity(0.2) : Color.white)
            }
            .onChange(of: roupas) { _ in
                filterClothing(by: selectedCategory)
            }
        }
    }
    
    private var scrollPrincipal: some View {
        VStack {
            if roupas.isEmpty {
                semRoupasView
            } else {
                ScrollView {
                    LazyVStack(alignment: .center, pinnedViews: [.sectionHeaders]) {
                        Section(header: filtroCategorias) {
                            roupasMap
                        }
                    }
                    .onChange(of: headerOffset) { newValue in
                        isHeaderSticky = newValue <= 0
                    }
                    .background(GeometryReader {
                        Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .named("scrollView")).minY)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) { value in
                        headerOffset = value
                    }
                }
                .coordinateSpace(name: "scrollView")
            }
        }
    }

    
    private var roupasMap: some View {
        VStack {
            if filteredPecas.isEmpty {
                Text("Nenhuma peça encontrada.").padding()
            } else {
                gridRoupas
            }
        }
    }
    private var semRoupasView: some View {
        VStack {
            Image("bonecoavatar")
            Text("Adicione suas peças")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color.black.opacity(0.8))
            Text("Use a \(Image(systemName: "camera.viewfinder")) para adicionar itens no seu guarda-roupa")
                .multilineTextAlignment(.center)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Color.black.opacity(0.8))
        }
        .containerRelativeFrame(.vertical)
    }
    
    var filtroCategorias: some View {
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
                            .foregroundColor(selectedCategory == category ? .white : .principal)
                            .background(selectedCategory == category ? Color.principal : Color.bege)
                            .fontWeight(selectedCategory == category ? .semibold : .regular)
                            .cornerRadius(10)
                            .padding(2)
                    }
                }
            }
            .padding()
            
            .background(isHeaderSticky ? Color.white : Color.rosinha)
            //            .background(isHeaderSticky ? Color.white : Color.terroso.opacity(0.5))
            //            .blendMode(isHeaderSticky ? .normal : .multiply)
            //                                .background(.thinMaterial)
        }
    }
    
    private var gridRoupas: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
            ForEach(filteredPecas, id: \.self) { roupa in
                
                CardRoupa2(roupa: roupa, isSelected: roupa == roupaSelecionada)
                    .onTapGesture {
                        roupaSelecionada = roupa
                        showSheetDetail.toggle()
                    }
                    .contextMenu {
                        Button(action: {
                            roupaSelecionada = roupa
                            showSheetCombo.toggle()
                        }) {
                            Label("Combinar", systemImage: "circlebadge.2")
                                .foregroundColor(.red)
                        }
                        
                        Button(action: {
                                roupaSelecionada = roupa
                                desapegarPeca()
                                
                            }) {
                                Label("Desapegar", systemImage: "tshippingbox")
                            }
                        
                        Button(role: .destructive, action: {
                            roupaSelecionada = roupa
                            alertaExcluir = true
                            
                        }) {
                            Label("Apagar", systemImage: "trash")
                        }
                        
                    }
            }
            
        }
        
        
//        .popoverTip()combinarPecaTip
        .alert(isPresented: $alertaExcluir) {
            Alert(
                title: Text("Excluir peça"),
                message: Text("Tem certeza que deseja excluir esta peça?"),
                primaryButton: .default(Text("Cancelar")),
                secondaryButton: .destructive(Text("Excluir"), action: {
                    deletarPeca()
                })
            )
        }
        .padding()

    }
}

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
#Preview {
    TeladeInicioView()
}
