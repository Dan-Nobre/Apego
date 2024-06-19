//
//  OrganizarView.swift
//  Apego
//
//  Created by Daniel Nobre on 18/06/24.
//

import SwiftUI

struct OrganizarView: View {
    @State private var selectedImages = [Image]()
    
    var body: some View {
        NavigationView{
            BotaoVariasImagens(selectedImages: $selectedImages)
                .navigationTitle("Organizar")
                .navigationBarTitleDisplayMode(.automatic)
        }
    }
}


#Preview {
    OrganizarView()
}
