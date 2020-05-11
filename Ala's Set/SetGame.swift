//
//  SetGame.swift
//  Ala's Set
//
//  Created by Amirala on 3/18/1397 AP.
//  Copyright © 1397 Amirala. All rights reserved.
//

import Foundation

struct SetGame {
    
    var totalCards = [Card]()
    var deckCards = [Card]()
    var matchedCards = [Card]()
    var tableTopCards = [Card]()
    var selectedCards = [Card]()
    var currentlyMatchedCards = [Card]()
    var gameEndStatus = false
        
    mutating func selectCard(at index: Int) {
        if tableTopCards.indices.contains(index) { //&& !matchedCards.contains(tableTopCards[index]) {
            if selectedCards.contains(tableTopCards[index]) , selectedCards.count < 3 {
                selectedCards.remove(at: selectedCards.index(of: tableTopCards[index])!)
            } else {
                selectedCards += [tableTopCards[index]]
            }
        }
        //        if selectedCards.count == 3  {
        //            if checkIfMatch(cards: selectedCards) {
        //                if deckCards.isEmpty {
        //                    checkIfGameEnds()
        //                }
        //            }
        //        }
        if selectedCards.count == 3 {
            let matchStatus = checkIfMatch(cards: selectedCards)
            if matchStatus {
                matchedCards += selectedCards
                currentlyMatchedCards = selectedCards
                if deckCards.isEmpty {
                    checkIfGameEnds()
                }
            }
        }
    }
    
    
//    var IDCheck = [Bool]()
    mutating func checkIfMatch(cards : [Card]) -> Bool {
        var IDCheck : [Bool] = []
        for index in 0...3 {
            let IDCheck1 = cards[0].ID[index] == cards[1].ID[index] && cards[0].ID[index] == cards[2].ID[index] ? true : false
            let IDCheck2 = cards[0].ID[index] != cards[1].ID[index] && cards[0].ID[index] != cards[2].ID[index] && cards[1].ID[index] != cards[2].ID[index] ? true : false
            
            IDCheck += [(IDCheck1 || IDCheck2)]
        }
        let matchStatus = IDCheck[0] && IDCheck[1] && IDCheck[2] && IDCheck[3]
//        IDCheck = []
//        if matchStatus == true {
//            matchedCards += cards
//            currentlyMatchedcards = cards
//        }
//        print("card matched? \(matchStatus)")
        return matchStatus
    }
    
//
//    mutating func dealThreeMoreCards(at indices: [Int]) {
////        if !deckCards.isEmpty , tableTopCards.count < 24 {
////            for index in 0...2 {
////                tableTopCards += [deckCards.remove(at: index)]
////            }
////        }
//        if !deckCards.isEmpty , !indices.isEmpty{
//            for index in 0...2 {
//                tableTopCards += [deckCards.remove(at: indices[index])]
//            }
//        }
//        refreshCurrentlyMatchedcards()
//    }
    
    mutating func dealThreeMoreCards() {
        refreshCurrentlyMatchedCards()
        if !deckCards.isEmpty {
            for _ in 0...2 {
                tableTopCards += [deckCards.remove(at: deckCards.startIndex)]
            }
        }
    }
    
    mutating func refreshCurrentlyMatchedCards() {
        var indexOfMatchedCards = [Int]()
        var reverseSorted = [Int]()
        for index in tableTopCards.indices {
            if currentlyMatchedCards.contains(tableTopCards[index]) {
                indexOfMatchedCards += [index]
                reverseSorted = indexOfMatchedCards.sorted(by: { $1 < $0})
            }
        }
        
        if !deckCards.isEmpty {
            for index in reverseSorted {
                tableTopCards[index] = deckCards.remove(at: deckCards.startIndex)
            }
        } else {
            for index in reverseSorted {
                tableTopCards.remove(at: index)
            }
        }
        
        currentlyMatchedCards = []
    }

    mutating func checkIfGameEnds() {
        outerLoop: for index1 in tableTopCards.indices {
            for index2 in tableTopCards.startIndex+1..<tableTopCards.endIndex {
                if index2 == index1 {continue}
                for index3 in tableTopCards.startIndex+2..<tableTopCards.endIndex {
                    if index3 == index2 || index3 == index1 {continue}
                    gameEndStatus = !checkIfMatch(cards: [tableTopCards[index1], tableTopCards[index2], tableTopCards[index3]])
                    if !gameEndStatus {
                        print("gameEnd? NOOOOPE!")
                        break outerLoop
                    }
                }
            }
        }
    }
    
    
    func shuffleCards(cardsArray: [Card]) -> [Card] {
        var temporaryValue = cardsArray
        var shuffleCards = [Card]()
        while temporaryValue.count > 0 {
            shuffleCards += [temporaryValue.remove(at: temporaryValue.count.arc4random)]
        }
        return shuffleCards
    }
    
    init() {
        for _ in 0...80 {
            let card = Card()
            totalCards += [card]
        }
        
        
        var shuffleCards = [Card]()
        while totalCards.count > 0 {
            shuffleCards += [totalCards.remove(at: totalCards.count.arc4random)]
        }
        totalCards = shuffleCards
        deckCards = totalCards
        
        for index in 0...11 {
            tableTopCards += [deckCards.remove(at: index)]
        }
        
    }
}


extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}



















