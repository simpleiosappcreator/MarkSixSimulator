//
//  Color.swift
//  MarkSixSimulator
//
//  Created by HAHA on 18/7/2021.
//

import Foundation
import SwiftUI

extension Color{
    static let theme = ColorTheme()
}

struct ColorTheme{
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let yellow = Color("YellowColor")
    let blue = Color("BlueColor")
    let red = Color("RedColor")
    let secondary = Color("SecondaryTextColor")
}
