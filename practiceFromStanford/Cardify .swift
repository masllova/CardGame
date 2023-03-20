//
//  Cardify .swift
//  practiceFromStanford
//
//  Created by Александра Маслова on 24.02.2023.
//

import SwiftUI

struct Cardify: Animatable, ViewModifier {
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    var animatableData: Double {
        get {rotation}
        set {rotation = newValue}
    }
    var rotation:Double // в градусах
    
    func body (content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle (cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90  {
                shape.foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                
            }
            else {shape}
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 3
        
    }
}
extension View {
    func cardify(isFaceUp: Bool) -> some View {
         self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
