//
//  SplashScreenView.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 28/06/24.
//

import SwiftUI
import simple_keyframe_animations

struct SplashScreenView: View {
    @Binding var isActivated: Bool
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0.5
    
    var body: some View {
        ZStack {
            Color.principal
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    
                    Image("fonte")
                        .scaleEffect(scale)
                        .opacity(opacity)
                        .frame(width: 700, height: 300)
//                        .frame(width: geometry.size.width, height: geometry.size.height / 1)
                        .offset( x: -150,y: -200)
                        .animation(.easeIn(duration: 1.0), value: scale)
                        .animation(.easeIn(duration: 1.0), value: opacity)
                    
                    Spacer().frame(height: 80)
                    
                    
                }
                Image("splash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400)
                    .offset(y:470)
            }
        }
        .onAppear {
            withAnimation(.easeIn(duration: 1.0)) {
                scale = 0.9
                opacity = 1.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isActivated = false
            }
        }
    }
}



struct SplashScreenView_Previews: PreviewProvider {
    @State static var isActivated = false
    
    static var previews: some View {
        SplashScreenView(isActivated: $isActivated)
    }
}
