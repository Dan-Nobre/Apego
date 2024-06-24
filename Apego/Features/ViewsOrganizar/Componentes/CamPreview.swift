//
//  CamPreview.swift
//  Apego
//
//  Created by Daniel Nobre on 24/06/24.
//

import SwiftUI

struct CamPreview: View {
    var body: some View {
        VStack {
            HostedViewController()
                .frame(width: 343, height: 277)
                .cornerRadius(20)
                .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.accentColor, lineWidth: 2)
                )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    CamPreview()
}
