//
//  SaveImageView.swift
//  Apego
//
//  Created by Maria Eduarda on 23/06/24.
//

import SwiftUI

struct SaveImageView: View {
    @State private var image: UIImage? = nil
    @State private var imageName: String = ""
    @State private var showingImagePicker = false
    @State private var images: [ImageData] = []
    let imageStore = ImageStore()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter image name", text: $imageName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                
                Button("Select Image") {
                    showingImagePicker = true
                }
                .padding()
                
                Button("Save Image") {
                    if let image = image, !imageName.isEmpty {
                        if let imageData = image.jpegData(compressionQuality: 1.0) {
                            let newImage = ImageData(name: imageName, imageData: imageData)
                            imageStore.saveImage(newImage)
                            images = imageStore.fetchImages() // Refresh the image list
                            imageName = "" // Reset the image name after saving
                            self.image = nil // Reset the selected image after saving
                        }
                    }
                }
                .padding()
                
                List {
                    ForEach(images) { imageData in
                        HStack {
                            if let uiImage = UIImage(data: imageData.imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                            }
                            Text(imageData.name)
                        }
                    }
                    .onDelete(perform: deleteImage)
                }
                .onAppear {
                    images = imageStore.fetchImages() // Load saved images on appear
                }
                
                Spacer()
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $image)
            }
            .navigationTitle("Save Images")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: EditButton())
        }
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
    SaveImageView()
}
