//
//  SelectedImagesView.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 21/06/24.
//

import SwiftUI

struct SelectedImagesView: View {
    var image: UIImage
    var clothingType: String
    var clothingColor: String
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .padding()
            
            Text(clothingType)
                .padding()
            Text(clothingColor)
                .padding()
            Spacer()

        }
        .navigationTitle("Detalhes da foto")
    }

}

#Preview {
    SelectedImagesView(image: UIImage(systemName: "photo")!, clothingType: "Tipo de roupa", clothingColor: "Cor exemplo")
}
