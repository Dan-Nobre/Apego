import SwiftUI
import PhotosUI
import SwiftData


struct ApegoView: View {
    
    @Query private var roupas: [RoupaModelo]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    if roupas.filter({ roupa in roupa.isDesapegada }).isEmpty {
                        Text("Nenhuma peça desapegada encontrada.")
                            .padding()
                    } else {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                            ForEach(roupas.filter { roupa in roupa.isDesapegada }, id: \.self) { roupa in
                                CardRoupaMenor(roupa: roupa, isSelected: false)
                            }
                        }
                    }
                }
                
                .padding()
                .navigationTitle("Apego")
                .toolbarTitleDisplayMode(.inlineLarge)
                .navigationBarTitleDisplayMode(.automatic)
            }
            
        }
        
    }
}

#Preview {
    ApegoView()
}
