//
//  TableTopCardsView.swift
//  Ala's Set
//
//  Created by Amirala on 4/11/1397 AP.
//  Copyright © 1397 Amirala. All rights reserved.
//

import UIKit

//@IBDesignable
class TableTopCardsView: UIView {
    
    @IBInspectable var numberOfCells: Int = 100  {didSet{ setNeedsLayout() ; setNeedsDisplay() }}

    var tableCardsView = [CardView]()
    
    
    func syncTableCardViewsWithTableTopCards(cardsIdentifiers identifiers : [Int]) {
        clearTable()
        let cardButtons = (0..<identifiers.count).map {createCardView(withID: identifiers[$0], visibility: true)}
        tableCardsView = cardButtons
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    func clearTable() {
        for index in tableCardsView.indices {
            tableCardsView[index].removeFromSuperview()
        }
    }
    
    func createCardView(withID identifier: Int ,visibility: Bool) -> CardView {
        let cardV = CardView()
        cardV.identifier = identifier
        cardV.isHidden = !visibility
        cardV.backgroundColor = UIColor.clear
        addSubview(cardV)
        return cardV
    }
    

//    @objc func touchCard(_ sender: UITapGestureRecognizer) {
//        switch sender.state {
//        case .ended:
//            for index in onTableCardsView.indices {
//                if sender.view == onTableCardsView[index] {
//                    if onTableCardsView[index].isSelected == true {
//                        onTableCardsView[index].isSelected = false
//                    } else {
//                        onTableCardsView[index].isSelected = true
//                    }
//                }
//            }
//            setNeedsDisplay()
//        default : break
//        }
//    }
    
        
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 10)
        roundedRect.addClip()
        UIColor.orange.setFill()
        roundedRect.fill()
//        for index in tableCardsView.indices {
//            if tableCardsView[index].isSelected == true {
//                tableCardsView[index].layer.borderWidth = selectedCardBorderWidth
//                tableCardsView[index].layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
//                tableCardsView[index].layer.cornerRadius = tableCardsView[index].cornerRadius
//            } else {
//                tableCardsView[index].layer.borderWidth = selectedCardBorderWidth
//                tableCardsView[index].layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
//                tableCardsView[index].layer.cornerRadius = tableCardsView[index].cornerRadius
//            }
//        }
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        var grid = Grid(layout: .aspectRatio(5/8), frame: bounds.insetBy(dx: 0 , dy: 0))
        grid.cellCount = tableCardsView.count
        for index in tableCardsView.indices {
            tableCardsView[index].frame.size = (grid[index]?.size)!
            tableCardsView[index].frame.origin = (grid[index]?.origin)!
        }
        
//        if numberOfCells > 0 {
//            for index in 0...numberOfCells-1 {
//                tableCardsView += [createCardView(withID: index, visibility: true)]
//                tableCardsView[index].frame.size = (grid[index]?.size)!
//                tableCardsView[index].frame.origin = (grid[index]?.origin)!
////                let tap = UITapGestureRecognizer(target: self , action: #selector(TableTopCardsView.touchCard(_:)))
////                onTableCardsView[index].addGestureRecognizer(tap)
//            }
//        }
    }
    
}




extension CGPoint {
    func offsetBy(dx : CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx , y: y+dy)
    }
}

extension TableTopCardsView {
    private struct SizeRatio {
        static let selectedCardBorderWidthToCardHeight : CGFloat = 0.009
        
    }
    var selectedCardBorderWidth : CGFloat {
        return bounds.size.height * SizeRatio.selectedCardBorderWidthToCardHeight
    }
}




