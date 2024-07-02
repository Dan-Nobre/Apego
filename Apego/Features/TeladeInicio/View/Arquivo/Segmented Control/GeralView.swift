import SwiftUI

struct GeralView: View {
    @Bindable var roupa: RoupaModelo
    @State private var tempCategoriaSelecionada: String
    @State private var tempCorSelecionada: String
    @Environment(\.dismiss) private var dismiss
    
    init(roupa: RoupaModelo, isToggled: Binding<Bool>) {
        self.roupa = roupa
        _tempCategoriaSelecionada = State(initialValue: roupa.categoria)
        _tempCorSelecionada = State(initialValue: roupa.cor)
        
    }
    
    var body: some View {
        NavigationStack {
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
                dismiss()
            }) {
                Text("Salvar")
            }
            .frame(maxWidth: .infinity, maxHeight: 52)
            .bold()
            .background(Color.terroso)
            .cornerRadius(10)
            .foregroundColor(.white)
            .font(.body)
        }
        .padding()
    }
}
