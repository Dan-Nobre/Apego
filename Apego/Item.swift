//
//  Item.swift
//  Apego
//
//  Created by Daniel Nobre on 17/06/24.
//

import Foundation
import SwiftData

@Model
     
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}



