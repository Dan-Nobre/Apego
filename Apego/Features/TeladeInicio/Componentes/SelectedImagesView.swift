//
//  SelectedImagesView.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 21/06/24.
//

import SwiftUI

struct SelectedImagesView: View {
    var images: [Image]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(images.indices, id: \.self) { index in
                        images[index]
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationTitle("Imagens Selecionadas")
        }
    }
}

#Preview {
    SelectedImagesView(images: [])
}
