//
//  ApegoView.swift
//  Apego
//
//  Created by Daniel Nobre on 18/06/24.
//

import SwiftUI

struct ApegoView: View {
    var body: some View {
        NavigationView{
            Text("Hello Word")
                .navigationTitle("Apego")
                .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    ApegoView()
}

