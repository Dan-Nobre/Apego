//
//  ImageListView.swift
//  Apego
//
//  Created by Maria Eduarda on 23/06/24.
//

import SwiftUI

struct ImageListView: View {
    @State private var images: [ImageData] = []
    let imageStore = ImageStore()
    
    var body: some View {
        List {
            ForEach(images) { imageData in
                VStack{
                    if let uiImage = UIImage(data: imageData.imageData){
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                    Text(imageData.name)
                }
            }
            .onDelete(perform: deleteImage)
        }
        .onAppear(){
            images = imageStore.fetchImages()
        }
        .navigationTitle("Saved Image")
        .navigationBarItems(trailing: EditButton())
    }
    
    private func deleteImage(at offsets: IndexSet) {
        offsets.forEach { index in
            let image = images[index]
            imageStore.deleteImage(image)
        }
        images.remove(atOffsets: offsets)
    }
}

#Preview {
    ImageListView()
}
