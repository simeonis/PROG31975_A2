//
//  String+CamelCase.swift
//  Shae_MyOrder
//
//  Created by Shae Simeoni on 2021-09-24.
//  Student #: 991625152
//  Reference: https://newbedev.com/separating-camelcase-string-into-space-separated-words-in-swift
//

import SwiftUI

extension String {
    func camelCaseToWord() -> String {
        return unicodeScalars.reduce("") {
            if (CharacterSet.uppercaseLetters.contains($1)) {
                return ($0 + " " + String($1))
            }
            else {
                return ($0 + String($1))
            }
        }
    }
}
