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
    
    var id: UUID?
    var nome: String
    var categoria: String
    let foto: Data?
    var cor: String
    
    init(nome: String, categoria: String, foto: Data?, cor: String) {
        self.id = UUID()
        self.nome = nome
        self.categoria = categoria
        self.foto = foto
        self.cor = cor
    }
}


