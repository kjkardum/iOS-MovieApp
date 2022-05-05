//
//  CGFloatExtension.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 01.05.2022..
//

import Foundation
import UIKit

extension CGFloat {
    static let defaultMargin: CGFloat = 8

    static func margin(_ baseMargin: CGFloat = defaultMargin, withMultiplier multiplier: CGFloat ) -> CGFloat {
        return baseMargin * multiplier
    }
}
