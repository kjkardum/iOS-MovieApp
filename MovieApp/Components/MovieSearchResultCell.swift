//
//  MovieSearchResultCell.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 05.05.2022..
//

import Foundation
import UIKit
import MovieAppData

class MovieSearchResultCell: UICollectionViewCell {
    static var id = "MovieSearchResultCell"
    weak var image: UIImageView!
    weak var title: StyledUILabel!
    weak var shortDescription: StyledUILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
        setViewLayout()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func buildViews() {
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .white
        self.dropShadow(scale: false)
        
        let image = UIImageView()
        self.contentView.addSubview(image)
        self.image = image
        
        let title = StyledUILabel(bold: true, fontStyle: .callout)
        self.contentView.addSubview(title)
        self.title = title
        
        let description = StyledUILabel(fontStyle: .footnote, color: .gray)
        self.contentView.addSubview(description)
        self.shortDescription = description
    }
    
    func setViewLayout() {
        image.snp.makeConstraints{ make in
            make.left.top.bottom.equalToSuperview()
            make.height.equalTo(movieListItemSize)
            make.width.equalTo(image.snp.height).dividedBy(imageRatioConstant)
        }
        title.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(CGFloat.margin(withMultiplier: 2))
            make.left.equalTo(image.snp.right).offset(CGFloat.margin(withMultiplier: 2))
        }
        shortDescription.snp.makeConstraints{ make in
            make.top.equalTo(title.snp.bottom).offset(CGFloat.margin(withMultiplier: 2))
            make.left.equalTo(image.snp.right).offset(CGFloat.margin(withMultiplier: 2))
            make.right.equalToSuperview().inset(CGFloat.margin(withMultiplier: 2))
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    func updateData(imageUrl: String, title: String, shortDescription: String) {
        if let url = URL(string: imageUrl) {
            self.image.load(url: url)
        }
        self.title.text = title
        self.shortDescription.text = shortDescription
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.bounds.size.height = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
}
