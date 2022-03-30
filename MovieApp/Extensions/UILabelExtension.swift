//
//  UILabelExtension.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 30.03.2022..
//

import Foundation
import UIKit

extension UILabel {
    convenience init(text: String, fontFamily: String? = "Proxima Nova", fontSize: CGFloat? = nil, fontStyle: UIFont.TextStyle = .footnote, bold: Bool = false, numberOfLines: Int? = nil, bgColor: UIColor? = nil, color: UIColor? = nil) {
        self.init()
        if numberOfLines != nil {
            self.numberOfLines = numberOfLines!
        }
        if bgColor != nil {
            self.backgroundColor = bgColor!
        }
        if color != nil {
            self.textColor = color!
        }
        self.text = text
        if fontFamily == nil {
            if bold {
                self.font = UIFont.preferredFont(forTextStyle: fontStyle).bold()
            } else {
                self.font = UIFont.preferredFont(forTextStyle: fontStyle)
            }
        } else {
            guard let customFont = fontSize != nil
                    ? UIFont(name: fontFamily!, size: fontSize!)
                    : UIFont.custom(name: fontFamily!, style: fontStyle) else {
                fatalError("Failed to load font")
            }
            var setFont = customFont
            if bold {
                setFont = customFont.bold()
            }
            self.font = UIFontMetrics(forTextStyle: fontStyle).scaledFont(for: setFont)
            self.adjustsFontForContentSizeCategory = true
        }
    }
}
