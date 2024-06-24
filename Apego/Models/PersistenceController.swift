//
//  PersistenceController.swift
//  Apego
//
//  Created by Maria Eduarda on 22/06/24.
//

import Foundation
import SwiftData

class ImageStore {
    private let storageKey = "savedImages"
    
    func saveImage(_ image: ImageData) {
        var images = fetchImages()
        images.append(image)
        if let encoded = try? JSONEncoder().encode(images) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    func deleteImage(_ image: ImageData) {
        var images = fetchImages()
        images.removeAll{ $0.id == image.id}
        if let encoded = try? JSONEncoder().encode(images) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    func fetchImages() -> [ImageData]{
        if let savedData = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([ImageData].self, from: savedData){
            return decoded
        }
        return []
    }
}
