//
//  Tip.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 25/06/24.
//

import Foundation
import TipKit

struct EditarPecaTip: Tip {
    var title: Text {
        Text("Editar Peça")
    }
    
    var message: Text? {
        Text("Clique para editar a categoria da peça e ver as roupas que você combinou com ela.")
    }
    
}

