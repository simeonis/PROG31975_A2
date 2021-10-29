//
//  CustomStyle.swift
//  Shae_MyOrder
//
//  Created by Shae Simeoni on 2021-09-24.
//  Student #: 991625152
//

import SwiftUI

struct FormButtomStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Group {
                if configuration.isPressed {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 3, y: 3)
                        .background(Color(red: 49/255, green: 122/255, blue: 246/255))
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 49/255, green: 122/255, blue: 246/255, opacity: 0.9))
                }
            })
    }
}
