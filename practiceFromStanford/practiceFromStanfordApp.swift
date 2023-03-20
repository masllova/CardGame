//
//  practiceFromStanfordApp.swift
//  practiceFromStanford
//
//  Created by Александра Маслова on 10.01.2023.
//

import SwiftUI


@main

struct MemorizeApp: App { 
    
   private let game = EmojiMemoryGame ()
    var body: some Scene {
        WindowGroup {
            GameView(game: game)
        }
    }
}
