//
//  Model.swift
//  practiceFromStanford
//
//  Created by Александра Маслова on 12.01.2023.
//

import Foundation

struct MemoryGame <CardContent> where CardContent: Equatable {
   private(set) var cards: Array<Card>
    // private здесь это контроль доступа, только этот class имеет доступ к ней, а privat(set) дает доступ просмотреть, но не изменить
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly}
            //вместо 0..<cards.count можно использовать cards.indices
            // it is from extension
        
        set {cards.indices.forEach {cards[$0].isFaceUp = ($0 == newValue)}}
                 // newValue это сама indexOfTheOneAndOnlyFaceUpCard
    }
     

    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func choose (_ card: Card){
      if  let chosenInd = cards.firstIndex(where: {$0.id == card.id}),
              !cards[chosenInd].isFaceUp,
              !cards[chosenInd].isMatched
      {
          if let potentialMatchInd = indexOfTheOneAndOnlyFaceUpCard {
              if cards[chosenInd].content == cards[potentialMatchInd].content {
                  cards[chosenInd].isMatched = true
                  cards[potentialMatchInd].isMatched = true
              }
              cards[chosenInd].isFaceUp = true
           } else { indexOfTheOneAndOnlyFaceUpCard = chosenInd}
      }
    }
    // mutating func говорит, что она меняет значение чего-то, что уже имеет значение
    
    func index(of: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == of.id {return index}
        }
        return nil // фальшивая
    }
    init (amountOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // добавим пары картам
        for pairInd in 0..<amountOfPairsOfCards {
            let content = createCardContent(pairInd)
            cards.append(Card(content: content, id: pairInd*2))
            cards.append(Card(content: content, id: pairInd*2+1))
            //pairInd - типа Int, поэтому подходят под id
            // cards.append дважды тк нам нужна пара каждой карте
        }
        cards.shuffle()
    }
    
    
    struct Card: Identifiable {

        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}
 
extension Array {
    var oneAndOnly: Element? {
        if count == 1 {return first}
        else {return nil}
    }
}
