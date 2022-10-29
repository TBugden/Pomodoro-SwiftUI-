//
//  LottieView.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/27/22.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    var animationName: String
    var loopMode: LottieLoopMode
    
    func makeUIView(context: Context) -> LottieAnimationView {
        let view = LottieAnimationView(name: animationName, bundle: Bundle.main)
        
        view.loopMode = loopMode
        view.play()
        
        return view
    }
    
    func updateUIView(_ uiView: LottieAnimationView, context: Context) {
        
    }
}
