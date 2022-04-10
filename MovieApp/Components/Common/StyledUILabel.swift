//
//  StyledUILabel.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 10.04.2022..
//

import Foundation
import UIKit

class StyledUILabel : UILabel {
    convenience init(text: String = "", bold: Bool = false, fontStyle: UIFont.TextStyle = .footnote, color: UIColor = .black) {
        self.init()
        self.text = text
        self.numberOfLines = 0
        self.textColor = color
        guard let customFont = UIFont.custom(name: "Proxima Nova", style: fontStyle) else {
            fatalError("Failed to load font")
        }
        var setFont = customFont
        if bold {
            setFont = customFont.bold()
        }
        self.font = UIFontMetrics(forTextStyle: fontStyle).scaledFont(for: setFont)
        self.adjustsFontForContentSizeCategory = true
    }
    static func getStyledFont(fontStyle: UIFont.TextStyle = .footnote, bold: Bool = false) -> UIFont {
        guard let customFont = UIFont.custom(name: "Proxima Nova", style: fontStyle) else {
            fatalError("Failed to load font")
        }
        var setFont = customFont
        if bold {
            setFont = customFont.bold()
        }
        let font = UIFontMetrics(forTextStyle: fontStyle).scaledFont(for: setFont)
        return font
    }
}
