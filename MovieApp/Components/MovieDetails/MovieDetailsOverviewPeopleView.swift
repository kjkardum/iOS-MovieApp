//
//  MovieDetailsOverviewPeopleView.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 10.04.2022..
//

import Foundation
import UIKit

class MovieDetailsOverviewPeopleView: UIStackView {
    var baseSpacing: CGFloat = 5
    var featured: [MovieFeaturedEntityModel] = []
    
    convenience init() {
        self.init(frame: CGRect())
        
        axis = .vertical
        alignment = .fill
        distribution = .fillEqually
        spacing = baseSpacing
    }
    
    func updateData(newFeatured: [MovieFeaturedEntityModel]) {
        featured = newFeatured
        fillGrid()
    }
    
    func fillGrid(){
        for row in 0 ..< Int(ceil(Double(featured.count) / 3.0)) {
            let horizontalSv = UIStackView()
            horizontalSv.axis = .horizontal
            horizontalSv.alignment = .fill
            horizontalSv.distribution = .fillEqually
            horizontalSv.spacing = baseSpacing

            for col in 0 ..< 3 {
                if (row * 3 + col + 1) > featured.count {
                    break
                }
                let label = StyledUILabel(color: .black)
                
                let boldText = featured[row * 3 + col].name
                let boldAttrs = [NSAttributedString.Key.font: StyledUILabel.getStyledFont(bold: true)]
                let attributedString = NSMutableAttributedString(string:boldText, attributes:boldAttrs)
                let normalText = "\n" + featured[row * 3 + col].role
                let normalAttrs = [NSAttributedString.Key.font: StyledUILabel.getStyledFont()]
                let normalString = NSMutableAttributedString(string:normalText, attributes: normalAttrs)
                attributedString.append(normalString)
                label.numberOfLines = 3
                label.attributedText = attributedString
                horizontalSv.addArrangedSubview(label)
            }
            addArrangedSubview(horizontalSv)
        }
    }
}
