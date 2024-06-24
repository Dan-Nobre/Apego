//
//  ImageEntity.swift
//  Apego
//
//  Created by Maria Eduarda on 22/06/24.
//
//
import Foundation
import SwiftData


//categoria
//cor



class ImageData: Identifiable, Codable{
    var id: UUID
    var name: String
    var imageData: Data
    
    
    init(name: String, imageData: Data) {
        self.id = UUID()
        self.name = name
        self.imageData = imageData
    }
}