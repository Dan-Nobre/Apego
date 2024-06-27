//
//  SplashScreenView.swift
//  Apego
//
//  Created by Taissa Vitoria Rodrigues de Paula on 27/06/24.
//

import SwiftUI
import simple_keyframe_animations


struct SplashScreenView: View {
    @State private var isAtivado = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        if isAtivado {
            TabBar()
        } else {
            GeometryReader { geometry in
                VStack {
                    Spacer()

                    Image("fonte2")
                        .frame(width: geometry.size.width, height: geometry.size.height / 2)
                        .background(Color.clear)
                        .offset(y: 150)
//                        .scaleEffect(size)
                        .
                       
                

//                        .onAppear {
//                            withAnimation(.easeInOut(duration: 3.0)) {
//                                self.size = 0.9
//                                self.opacity = 1.0
//                            }
//                            
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                                self.isAtivado = true
//                            }
//                        }
                    
                    Spacer()
                        .frame(height: 80)
                    
                    Image("splash")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(y:25)
                }
                .background(Color.principal)
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}


#Preview {
    SplashScreenView()
}
