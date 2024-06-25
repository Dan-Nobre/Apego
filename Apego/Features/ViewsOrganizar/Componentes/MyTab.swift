//
//  TabView.swift
//  Apego
//
//  Created by Daniel Nobre on 21/06/24.
//

import Foundation
import SwiftUI

struct Tab: View {
    @State private var pressed = 0
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .terroso
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.terroso], for: .normal)
    }
    var body: some View {
        Picker("Informações de peças", selection: $pressed) {
                        Text("Geral")
                            .tag(0)
                        Text("Combinações")
                            .tag(1)
                    }
                    .pickerStyle(.segmented)
        HStack(alignment:.top){
            if pressed == 0{
                EdicaoGeralPecas()
            }else if pressed == 1{
                CombinacoesNaPeca()
            }
        }
    }
}

#Preview{
    Tab()
}
