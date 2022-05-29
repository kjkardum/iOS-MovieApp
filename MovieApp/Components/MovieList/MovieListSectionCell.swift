//
//  MovieListSectionCell.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 05.05.2022..
//

import Foundation
import UIKit

class MovieListSectionCell: UICollectionViewCell {
    static var id = "MovieListSectionCell"
    weak var section: MovieSectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let section = MovieSectionView()
        self.contentView.addSubview(section)
        self.section = section
        
        addSubview(section)
        
        section.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
    func updateData(category: MoviesCategoryModel, selectFilter: @escaping ((Int) -> Void), filter: Int? = nil) {
        section.updateData(category: category, selectFilter: selectFilter, filter: filter)
    }
}
