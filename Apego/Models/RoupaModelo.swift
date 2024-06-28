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
    
    var id: UUID?
    var nome: String
    var categoria: String
    let foto: Data?
    var cor: String
    var pecasCombinadas: [RoupaModelo]
    
    init(categoria: String, foto: Data? = nil, cor: String, pecasCombinadas: [RoupaModelo]) {

        self.id = UUID()
        self.nome = nome
        self.categoria = categoria
        self.foto = foto
        self.cor = cor
        self.pecasCombinadas = pecasCombinadas
    }
}


