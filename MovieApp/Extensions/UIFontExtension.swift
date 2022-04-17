//
//  UIFontExtension.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 30.03.2022..
//

import Foundation
import UIKit

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //0 = keep the size
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
    static func custom(name: String, style: UIFont.TextStyle) -> UIFont? {
        let size: CGFloat = {
            switch style {
            case .largeTitle: return 34
            case .title1: return 28
            case .title2: return 22
            case .title3: return 20
            case .headline: return 17
            case .body: return 17
            case .callout: return 16
            case .subheadline: return 15
            case .footnote: return 13
            case .caption1: return 12
            case .caption2: return 11
            default:
                return 11
            }
        }()
        return UIFont(name: name, size: size)
    }
}
