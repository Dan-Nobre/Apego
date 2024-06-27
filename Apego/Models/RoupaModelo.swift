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
final class RoupaModelo {
    
    var id: UUID
    var categoria: String
    let foto: Data?
    
    init(categoria: String, foto: Data) {
        self.id = UUID()
        self.categoria = categoria
        self.foto = foto
    }
}


