//
//  CoffeeData.swift
//  Shae_MyOrder
//
//  Created by Shae Simeoni on 2021-09-24.
//  Student #: 991625152
//

import Foundation

class Coffee {
    enum Kind: String, CaseIterable, Identifiable {
        case DarkRoast
        case OriginalBlend
        case Vanilla
        
        var id: String { self.rawValue }
    }
    
    enum Size: String, CaseIterable, Identifiable {
        case Small
        case Medium
        case Large
        
        var id: String { self.rawValue }
    }
    
    init(kind: Kind, size: Size, cups: Int) {
        self.kind = kind
        self.size = size
        self.cups = cups
    }
    
    var kind: Kind = Kind.DarkRoast
    var size: Size = Size.Medium
    var cups: Int = 0
}
