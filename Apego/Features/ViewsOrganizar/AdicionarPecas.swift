//
//  AdicionarPecas.swift
//  Apego
//
//  Created by Daniel Nobre on 20/06/24.
//

import SwiftUI

struct AdicionarPecas: View {
    @State private var isActive: Bool = false
    var body: some View {
        NavigationView{
            NavigationLink(destination: AdicionarPecasSheet()) {
                Text("oi")
            }
            
        }
    }
}


struct AdicionarPecasSheet: View {
    @State private var image: UIImage? = nil
    @State private var imageName: String = ""
    @State private var showingImagePicker = false
    let imageStore =  ImageStore()
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    CardAddPeca()
                }
                .padding(.top, 64)
                CardInfo()
                    .padding(.top, 31)
                Button("Select Image") {
                    showingImagePicker = true
                }
                .padding()
                
                TextField("Enter image name", text: $imageName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                Button("Save Image") {
                    if let image = image, !imageName.isEmpty {
                        if let imageData = image.jpegData(compressionQuality: 1.0) {
                            let newImage = ImageData(name: imageName, imageData: imageData)
                            imageStore.saveImage(newImage)
                        }
                    }
                }
//                BotaoContinuar()
////                    if let image = image, !imageName.isEmpty{
////                        if let imageData = image.jpegData(compressionQuality:1.0){
////                            let newImage = ImageData(name: imageName, imageData: imageData)
////                            imageStore.saveImage(newImage)
////                        }
////                    }
                    .buttonStyle(MySecButtonStyle(color: .cinzaClaro))
                    .padding(.top, 25)
                Spacer()
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            CustomImagePicker(image: $image)
        }
        .navigationTitle("ADICIONAR PEÇAS")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    AdicionarPecas()
}
