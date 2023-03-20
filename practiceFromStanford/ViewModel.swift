//
//  ViewModel.swift
//  practiceFromStanford
//
//  Created by Александра Маслова on 12.01.2023.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    
    // ObservableObject - наблюдаемый объект: он может сообщить, что что-то изменилось
    // static позволяет избегать ошибок с init делая переменную/функцию глобальной (как за телом class) но в тоже время использование ее возможно только в этом class
    typealias Card = MemoryGame<String>.Card
    //typealias - псевдоним
    private static let emojis = ["🍎", "🍍", "🍕", "🍌", "🍦", "🍩", "🍉", "🍟","🫐", "🥗", "🥝", "🌶","🥕", "🥦", "🥐", "🧀","🥑", "🍗", "🍭", "🍪","🌭", "🥨", "🥓", "🍔"]
    
    
    private static func createTheGame() -> MemoryGame<String> {
        MemoryGame<String>(amountOfPairsOfCards: 10, createCardContent: {pairInd in
            EmojiMemoryGame.emojis[pairInd]} )
    }
    
    
   @Published private var model = createTheGame()
    //  @Published она будет сообщать как только изменится, например, через static  func private let model: MemoryGame<String> = createTheGame(). Простыми словами отображаемая переменная
    
    var cards: Array<Card> {return model.cards}
    
    //MARK: - действия пользователя
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func restart() {
        model = EmojiMemoryGame.createTheGame()
    }

}

    
