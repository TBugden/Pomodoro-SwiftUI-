//
//  Extensions.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/26/22.
//

import SwiftUI

extension Color {
    static let customMutedGreenLight = Color("customMutedGreenLight")
    static let customMutedGreenDark = Color("customMutedGreenDark")
    static let customVibrantGreenLight = Color("customVibrantGreenLight")
    static let customVibrantGreenDark = Color("customVibrantGreenDark")
    static let customDirtBrownDark = Color("customDirtBrownDark")
    
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension View {
    @ViewBuilder
    private func onTapBackgroundContent(enabled: Bool, _ action: @escaping () -> Void) -> some View {
        if enabled {
            Color.clear
                .frame(width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.height * 2)
                .contentShape(Rectangle())
                .onTapGesture(perform: action)
        }
    }
    
    func onTapBackground(enabled: Bool, _ action: @escaping () -> Void) -> some View {
        background(
            onTapBackgroundContent(enabled: enabled, action)
        )
    }
}

struct DraggableModifier : ViewModifier {
    
    enum Direction {
        case vertical
        case horizontal
    }
    
    let endAction: () -> Void
    
    let direction: Direction
    let size: CGFloat
    let screenSize = UIScreen.main.bounds.width
    
    @State private var draggedOffset: CGSize = .zero
    
    func body(content: Content) -> some View {
        content
            .offset(
                CGSize(width: direction == .vertical ? 0 : draggedOffset.width,
                       height: direction == .horizontal ? 0 : draggedOffset.height)
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let endLocation = size - ((screenSize - size) / 2)
                        if value.location.x >= value.startLocation.x && value.location.x < endLocation {
                            self.draggedOffset = value.translation
                        }
                    }
                    .onEnded { value in
                        if value.location.x > (size - ((screenSize - size) / 2)) - 25 {
                            endAction()
                        } else {
                            self.draggedOffset = .zero
                        }
                        
                    }
            )
    }
}
