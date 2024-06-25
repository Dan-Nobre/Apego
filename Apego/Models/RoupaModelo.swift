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

@Model

final class RoupaModelo {
    var id: UUID
    var categoria: String
    var imageData: Data
    
    
    init(name: String, imageData: Data) {
        self.id = UUID()
        self.categoria = name
        self.imageData = imageData
    }
}
