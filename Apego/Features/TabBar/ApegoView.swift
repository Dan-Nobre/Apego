import SwiftUI

struct ApegoView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Tudo quieto por enquanto 👀")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color.black.opacity(0.8))
                Spacer()
            }
            .navigationTitle("Apego")
            .toolbarTitleDisplayMode(.inlineLarge)
            .navigationBarTitleDisplayMode(.automatic)
            .background(
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.terroso.opacity(0.2), Color.terroso.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    Image("gambiarra")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
            )
        }
    }
}

#Preview {
    ApegoView()
}
