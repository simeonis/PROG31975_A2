//
//  CoffeeData.swift
//  Shae_MyOrder
//
//  Created by Shae Simeoni on 2021-09-24.
//  Student #: 991625152
//

import Foundation

enum CoffeeType: String, CaseIterable, Identifiable {
    case DarkRoast = "Dark Roast"
    case OriginalBlend = "Original Blend"
    case Vanilla = "Vanilla"
    
    var id: String { self.rawValue }
}

enum CoffeeSize: String, CaseIterable, Identifiable {
    case Small = "Small"
    case Medium = "Medium"
    case Large = "Large"
    
    var id: String { self.rawValue }
}

class Coffee {
    
    var id = UUID()
    var cType: CoffeeType = CoffeeType.DarkRoast
    var cSize: CoffeeSize = CoffeeSize.Medium
    var cCups: Int = 0
    
    init() {
    }
    
    init(cType: CoffeeType, cSize: CoffeeSize, cCups: Int) {
        self.cType = cType
        self.cSize = cSize
        self.cCups = cCups
    }
    
    init(cID: UUID, cType: CoffeeType, cSize: CoffeeSize, cCups: Int) {
        self.id = cID
        self.cType = cType
        self.cSize = cSize
        self.cCups = cCups
    }
}
