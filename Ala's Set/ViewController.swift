//
//  ViewController.swift
//  Ala's Set
//
//  Created by Amirala on 3/18/1397 AP.
//  Copyright © 1397 Amirala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var game = SetGame()

    @IBOutlet weak var cardsContainerView: TableTopCardsView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandle))
            swipe.direction = .down
            cardsContainerView.addGestureRecognizer(swipe)
            let rotation = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureHandler(_:)))
            cardsContainerView.addGestureRecognizer(rotation)
            updateViewFromModel()
        }
    }
    
    @objc func swipeGestureHandle() {
        game.dealThreeMoreCards()
        updateViewFromModel()
    }
    
    @objc func rotationGestureHandler(_ sender: UIGestureRecognizer) {
        switch sender.state {
        case .ended:
            game.tableTopCards = game.shuffleCards(cardsArray: game.tableTopCards)
            updateViewFromModel()
        default: break
        }
    }
    
    func assignTargetAction() {
        for button in cardsContainerView.tableCardsView {
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCard(_:)))
            button.addGestureRecognizer(tap)
        }
    }
    
    @objc func didTapCard(_ sender : UITapGestureRecognizer) {
        if game.currentlyMatchedCards.count == 3 {
            game.refreshCurrentlyMatchedCards()
        }
        if game.selectedCards.count == 3 {
            game.selectedCards = []
        }
        for index in cardsContainerView.tableCardsView.indices {
            if sender.view == cardsContainerView.tableCardsView[index] {
                game.selectCard(at: index)
            }
        }
        updateViewFromModel()
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!{
        didSet {
            updateViewFromModel()
        }
    }
//    @IBAction func touchCard(_ sender: UIButton) {
//        if let cardNumber = cardButtons.index(of: sender) {
//            if game.currentlyMatchedcards.count == 3 {
//                game.refreshCurrentlyMatchedcards()
//            }
//            if game.selectedCards.count == 3 {
//                game.selectedCards = []
//            }
//            game.selectCard(at: cardNumber)
//            updateViewFromModel()
//        } else {
//            print("selected card is not on the table")
//        }
//    }
//

    
    
    @IBOutlet weak var dealButton: UIButton!
    @IBAction func dealButton(_ sender: UIButton) {
//        let dealIndices = cardButtons.indices.filter{cardButtons[$0].currentTitle == ""}
//        if dealIndices.isEmpty && game.currentlyMatchedcards.isEmpty{
//            dealButton.setTitle("aaa", for: .normal)
//        }
        game.dealThreeMoreCards()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        cardsContainerView.syncTableCardViewsWithTableTopCards(cardsIdentifiers: game.tableTopCards.map {$0.identifier})
        assignTargetAction()
        for index in game.selectedCards.indices {
            if let realIndex = game.tableTopCards.index(of: game.selectedCards[index]) {
                cardsContainerView.tableCardsView[realIndex].layer.borderWidth = 4.0
                cardsContainerView.tableCardsView[realIndex].layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                cardsContainerView.tableCardsView[realIndex].layer.cornerRadius = 10
            }
        }
    }

//    func updateViewFromModel() {
//        for index in game.tableTopCards.indices {
//            if  !game.matchedCards.contains(game.tableTopCards[index]) {
//                cardButtons[index].setAttributedTitle(setButtonShape(ID: game.tableTopCards[index].ID), for: .normal)
//                cardButtons[index].backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
//                cardButtons[index].layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
//                cardButtons[index].layer.cornerRadius = 10
//            } else {
//                cardButtons[index].setTitle("", for: .normal)
//                cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
//            }
//        }
//        if game.tableTopCards.endIndex < 24 {
//            for index in game.tableTopCards.endIndex...23 {
//                cardButtons[index].setTitle("", for: .normal)
//                cardButtons[index].backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0)
//            }
//        }
//        for index in game.selectedCards.indices {
//            if let realIndex = game.tableTopCards.index(of: game.selectedCards[index]) {
//                cardButtons[realIndex].layer.borderWidth = 4.0
//                cardButtons[realIndex].layer.borderColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
//                cardButtons[realIndex].layer.cornerRadius = 10
//            }
//        }
//    }

    
    
//    func setButtonShape(ID: [Int]) -> NSAttributedString {
//        var text = String()
//        switch ID[0] {
//        case 0:
//            text = "▲"
//        case 1:
//            text = "⚫︎"
//        case 2:
//            text = "◼︎"
//        default: break
//        }
//        var tempText = text
//        for _ in 0..<ID[1] {
//            tempText += text
//        }
//
//        text = tempText
//
//        var attributes = [NSAttributedStringKey:Any]()
//
//        attributes[.font] = UIFont.init(name: "Georgia" , size: 30)
//
//        enum shade : Int {
//            case fill = 0 , shade , outline
//        }
//        enum color : Int {
//            case red = 0 , blue , black
//        }
//
//        if let shadValue = shade(rawValue: ID[2]) {
//            if let colorValue = color(rawValue: ID[3]) {
//
//                switch colorValue {
//                case .red :
//                    switch shadValue {
//                    case .fill :
//                        attributes[.strokeWidth] = -10
//                        attributes[.strokeColor] = UIColor.red
//                        attributes[.foregroundColor] = UIColor.red.withAlphaComponent(1)
//                    case .shade:
//                        attributes[.strokeWidth] = -10
//                        attributes[.strokeColor] = UIColor.red
//                        attributes[.foregroundColor] = UIColor.red.withAlphaComponent(0.25)
//
//                    case .outline:
//                        attributes[.strokeWidth] = 10
//                        attributes[.strokeColor] = UIColor.red
//                    }
//                case .blue:
//                    switch shadValue {
//                    case .fill :
//                        attributes[.strokeWidth] = -10
//                        attributes[.strokeColor] = UIColor.blue
//                        attributes[.foregroundColor] = UIColor.blue.withAlphaComponent(1)
//                    case .shade:
//                        attributes[.strokeWidth] = -10
//                        attributes[.strokeColor] = UIColor.blue
//                        attributes[.foregroundColor] = UIColor.blue.withAlphaComponent(0.25)
//
//                    case .outline:
//                        attributes[.strokeWidth] = 10
//                        attributes[.strokeColor] = UIColor.blue
//                    }
//                case .black:
//                    switch shadValue {
//                    case .fill :
//                        attributes[.strokeWidth] = -10
//                        attributes[.strokeColor] = UIColor.black
//                        attributes[.foregroundColor] = UIColor.black.withAlphaComponent(1)
//                    case .shade:
//                        attributes[.strokeWidth] = -10
//                        attributes[.strokeColor] = UIColor.black
//                        attributes[.foregroundColor] = UIColor.black.withAlphaComponent(0.25)
//
//                    case .outline:
//                        attributes[.strokeWidth] = 10
//                        attributes[.strokeColor] = UIColor.black
//                    }
//                }
//            }
//        }
//
//
//        return NSAttributedString(string: text, attributes: attributes)
//
//
//    }
    
}




