//
//  Tip.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 25/06/24.
//

import Foundation
import TipKit

struct cliqueEdite: Tip {
    var title: Text {
        Text("Editar Peça")
    }
    
    var message: Text? {
        Text("Clique para editar a categoria da peça e ver as roupas que você combinou com ela.")
        
    }


}
struct CombinarPecaTip: Tip {
    var title: Text {
        Text("Categorizar, combinar, desapegar e apagar")
    }
    var message: Text? {
        Text("Pressione para categorizar, combinar, desapegar ou apagar a peça do seu guarda-roupa.")
        
        
    }
}
