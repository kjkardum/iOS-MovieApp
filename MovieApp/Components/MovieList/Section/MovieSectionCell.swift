//
//  MovieSectionCell.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 05.05.2022..
//

import Foundation
import UIKit
import MovieAppData

class MovieSectionCell: UICollectionViewCell {
    static var id = "MovieCell"
    weak var image: UIImageView!
    weak var heartButton: CircularToggleButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let image = UIImageView()
        self.contentView.addSubview(image)
        self.image = image
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        
        let heartButton = CircularToggleButton(unselectedIcon: .heart,
                                               selectedIcon: .heartFill,
                                               backgroundColor: .themeBlueTransparrent,
                                               action: likeMovie)
        
        self.contentView.addSubview(heartButton)
        self.heartButton = heartButton
        
        image.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        heartButton.snp.makeConstraints{ make in
            make.top.left.equalToSuperview().inset(CGFloat.defaultMargin)
            make.height.width.equalTo(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    @objc func likeMovie(liked: Bool) { }
    
    func updateData(movie: MovieAppData.MovieModel) {
        if let url = URL(string: movie.imageUrl) {
            image.load(url: url)
        }
    }
    
}
