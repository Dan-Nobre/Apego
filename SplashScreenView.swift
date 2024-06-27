//
//  SplashScreenView.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 27/06/24.
//

import SwiftUI
import simple_keyframe_animations

struct SplashScreenView: View {
    @Binding var isActivated: Bool
    @State private var scale: CGFloat = 0.8
    @State private var opacity = 0.5

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()

                Image("fonte2")
                    .frame(width: geometry.size.width, height: geometry.size.height / 2)
                    .offset(y: 150)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .boingEffect(duration: .constant(10), startAnimation: .constant(true))
//                    .blooming(duration: .constant(1), startAnimation: .constant(true))

                Spacer().frame(height: 80)

                Image("splash")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(y: 30)
            }
            .background(Color.principal)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                withAnimation {
                    scale = 0.9
                    opacity = 1.0
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    isActivated = true
                }
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
