//
//  UIColorExtension.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 30.04.2022..
//

import Foundation
import UIKit

extension UIColor {
    static let themeLightGray = UIColor.init(hex: lightGrayColorCode) ?? .red
    static let themeBlue = UIColor.init(hex: blueColorCode) ?? .red
    static let themeBlueTransparrent = UIColor.init(hex: blueTransparent) ?? .red
    
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}
