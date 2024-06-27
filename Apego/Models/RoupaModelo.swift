//
//  ImageEntity.swift
//  Apego
//
//  Created by Maria Eduarda on 22/06/24.
//
//
import SwiftData
import SwiftUI


//categoria
//cor

@Model
final class RoupaModelo: ObservableObject {
    
    var id: UUID
    var categoria: String
    let foto: Data?
    
    init(categoria: String, foto: Data? = nil) {
        self.id = UUID()
        self.categoria = categoria
        self.foto = foto
    }
}


