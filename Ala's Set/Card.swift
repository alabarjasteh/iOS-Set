//
//  Card.swift
//  Ala's Set
//
//  Created by Amirala on 3/18/1397 AP.
//  Copyright © 1397 Amirala. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hashValue: Int { return identifier}
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var identifier : Int
    var ID = [Int]()
    
    static var identifierFactory = -1
    static func getUniqueIdentifier()-> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
        var someNumber = identifier
        ID += [someNumber % 3]
        someNumber /= 3
        ID += [someNumber % 3]
        someNumber /= 3
        ID += [someNumber % 3]
        someNumber /= 3
        ID += [someNumber % 3]
    }

}








