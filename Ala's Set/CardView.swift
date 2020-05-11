//
//  CardView.swift
//  Ala's Set
//
//  Created by Amirala on 4/10/1397 AP.
//  Copyright © 1397 Amirala. All rights reserved.
//

import UIKit

//@IBDesignable
class CardView: UIView {
    
//    var cardID : [Int] = [2,0,1,1] {didSet{ setNeedsDisplay(); setNeedsLayout() }}

//    @IBInspectable var ID[0] : Int = ID[0] {didSet{ setNeedsDisplay(); setNeedsLayout() }}
//    @IBInspectable var ID[1] : Int = ID[1] {didSet{ setNeedsDisplay(); setNeedsLayout() }}
//    @IBInspectable var ID[2] : Int = ID[2] {didSet{ setNeedsDisplay(); setNeedsLayout() }}
//    @IBInspectable var ID[3] : Int = ID[3] {didSet{ setNeedsDisplay(); setNeedsLayout() }}
    
    @IBInspectable var identifier : Int = 1 {didSet{ calculateID(identifer: identifier); setNeedsDisplay(); setNeedsLayout() }}
    @IBInspectable var isVisible : Bool = true {didSet{ setNeedsDisplay(); setNeedsLayout() }}
    var isSelected : Bool = false
    var ID: [Int] = [1,1,1,1]
    
//    let tap = UITapGestureRecognizer()
//    onTableCardsView[index].addGestureRecognizer(tap)
    
    

    @objc func touchCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            if self.isSelected == true {
                self.isSelected = false
            } else {
                self.isSelected = true
            }
        default : break
        }
    }
    
    
    func calculateID(identifer: Int) {
        var someNumber = identifier
        ID[0] = someNumber % 3
        someNumber /= 3
        ID[1] = someNumber % 3
        someNumber /= 3
        ID[2] = someNumber % 3
        someNumber /= 3
        ID[3] = someNumber % 3
    }
    
    override func draw(_ rect: CGRect) {
        
        let roundedRect = UIBezierPath(roundedRect: bounds.insetBy(dx: cardBorderOffset, dy: cardBorderOffset), cornerRadius: cornerRadius)
        roundedRect.addClip()
        
//        self.addGestureRecognizer(tap)
        
        if isVisible == true {
            UIColor.white.setFill()
            roundedRect.fill()
            
            switch ID[0] {
            case 0:
                drawPip(in: CGRect(x: bounds.minX, y: bounds.height/3, width: bounds.width, height: bounds.height/3).insetBy(dx: pipOffset, dy: pipOffset))
            case 1:
                drawPip(in: CGRect(x: bounds.minX, y: bounds.height/9, width: bounds.width, height: bounds.height/3).insetBy(dx: pipOffset, dy: pipOffset))
                drawPip(in: CGRect(x: bounds.minX, y: 5*bounds.height/9, width: bounds.width, height: bounds.height/3).insetBy(dx: pipOffset, dy: pipOffset))
            case 2:
                drawPip(in: CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height/3).insetBy(dx: pipOffset, dy: pipOffset))
                drawPip(in: CGRect(x: bounds.minX, y: bounds.height/3, width: bounds.width, height: bounds.height/3).insetBy(dx: pipOffset, dy: pipOffset))
                drawPip(in: CGRect(x: bounds.minX, y: 2*bounds.height/3, width: bounds.width, height: bounds.height/3).insetBy(dx: pipOffset, dy: pipOffset))
            default: break
            }
        } else {
            UIColor.clear.setFill()
            roundedRect.fill()
        }
    }
    
    
    
    private func drawPip(in rect: CGRect) {
        
        let contex = UIGraphicsGetCurrentContext()!
        contex.saveGState()
        
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        
        switch ID[1] {
            
        case 0: //squiggles
            path.move(to: CGPoint(x: rect.minX + rect.width*0.05, y: rect.minY + rect.size.height*0.4))
            
            path.addCurve(to: CGPoint(x: rect.minX + rect.width*0.35, y: rect.origin.y + rect.size.height*0.25) ,
                          controlPoint1: CGPoint(x: rect.minX + rect.width*0.09, y: rect.origin.y + rect.size.height*0.15),
                          controlPoint2: CGPoint(x: rect.minX + rect.width*0.18, y: rect.origin.y + rect.size.height*0.10))
            
            path.addCurve(to: CGPoint(x: rect.minX + rect.width*0.75, y: rect.origin.y + rect.size.height*0.30) ,
                          controlPoint1: CGPoint(x: rect.minX + rect.width*0.40, y: rect.origin.y + rect.size.height*0.30),
                          controlPoint2: CGPoint(x: rect.minX + rect.width*0.6, y: rect.origin.y + rect.size.height*0.45))
            
            path.addCurve(to: CGPoint(x: rect.minX + rect.width*0.97, y: rect.origin.y + rect.size.height*0.35) ,
                          controlPoint1: CGPoint(x: rect.minX + rect.width*0.87, y: rect.origin.y + rect.size.height*0.15),
                          controlPoint2: CGPoint(x: rect.minX + rect.width*0.98, y: rect.origin.y + rect.size.height*0.00))
            
            path.addCurve(to: CGPoint(x: rect.minX + rect.width*0.45, y: rect.origin.y + rect.size.height*0.85) ,
                          controlPoint1: CGPoint(x: rect.minX + rect.width*0.95, y: rect.origin.y + rect.size.height*1.10),
                          controlPoint2: CGPoint(x: rect.minX + rect.width*0.50, y: rect.origin.y + rect.size.height*0.95))
            
            path.addCurve(to: CGPoint(x: rect.minX + rect.width*0.25, y: rect.origin.y + rect.size.height*0.85) ,
                          controlPoint1: CGPoint(x: rect.minX + rect.width*0.40, y: rect.origin.y + rect.size.height*0.80),
                          controlPoint2: CGPoint(x: rect.minX + rect.width*0.35, y: rect.origin.y + rect.size.height*0.75))
            
            path.addCurve(to: CGPoint(x: rect.minX + rect.width*0.05, y: rect.origin.y + rect.size.height*0.40) ,
                          controlPoint1: CGPoint(x: rect.minX + rect.width*0.00, y: rect.origin.y + rect.size.height*1.10),
                          controlPoint2: CGPoint(x: rect.minX + rect.width*0.005, y: rect.origin.y + rect.size.height*0.60))
            path.close()
        case 1: //diamond
            path.move(to: CGPoint(x: rect.minX , y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX , y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX , y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX , y: rect.maxY))
            path.close()
        case 2: //oval
            path.move(to: CGPoint(x: rect.minX + rect.width * 0.20 , y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.80 , y: rect.minY))
            path.addArc(withCenter: CGPoint(x: rect.minX + rect.width * 0.80 , y: rect.midY), radius: rect.height/2, startAngle: 3*CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: true)
            path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.20 , y: rect.maxY))
            path.addArc(withCenter: CGPoint(x: rect.minX + rect.width * 0.20 , y: rect.midY), radius: rect.height/2, startAngle: CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: true)
            
        default: break
        }
        
        switch ID[2] {
        case 0:
            UIColor.purple.setFill()
            UIColor.purple.setStroke()
        case 1:
            UIColor.red.setFill()
            UIColor.red.setStroke()
        case 2:
            UIColor.green.setFill()
            UIColor.green.setStroke()
        default: break
        }
        
        switch ID[3] {
        case 0:
            path.stroke()
        case 1:
            path.addClip()
            for pointX in stride(from: rect.minX, through: rect.maxX, by: strideStep) {
                path.move(to: CGPoint(x: pointX, y: rect.minY))
                path.addLine(to: CGPoint(x: pointX, y: rect.maxY))
            }
            path.stroke()

        case 2:
            path.fill()
        default: break
        }
        
        
        contex.restoreGState()
        
    }
}

extension CardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight : CGFloat = 0.06
        static let cornerOffsetToCornerRadius : CGFloat = 0.33
        static let pipOffsetToBoundsHeight : CGFloat = 0.06
        static let lineWidthToBoundsHeight : CGFloat = 0.017
        static let stideStepToBoundsHeight : CGFloat = 0.03
        static let cardBorderOffsetToBoundsHeight : CGFloat = 0.03
    }
     var cornerRadius : CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset : CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    private var pipOffset : CGFloat {
        return bounds.size.height * SizeRatio.pipOffsetToBoundsHeight
    }
    private var lineWidth : CGFloat {
        return bounds.size.height * SizeRatio.lineWidthToBoundsHeight
    }
    private var strideStep : CGFloat {
        return bounds.size.height * SizeRatio.stideStepToBoundsHeight
    }
    private var cardBorderOffset : CGFloat {
        return bounds.size.height * SizeRatio.cardBorderOffsetToBoundsHeight
    }
}










