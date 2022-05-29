//
//  FavoriteCell.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 29.05.2022..
//

import Foundation
import UIKit
import SnapKit

class FavoriteCell: UIView {
    var movie: Movie!
    var image: UIImageView!
    var heartButton: CircularToggleButton!
    
    required init(movie: Movie) {
        super.init(frame: .zero)
        self.movie = movie
        
        buildView()
        setViewLayout()
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func buildView() {
        backgroundColor = .white
        image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickMovie))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
        
        heartButton = CircularToggleButton(unselectedIcon: .heart,
                                               selectedIcon: .heartFill,
                                               backgroundColor: .themeBlueTransparrent,
                                               action: likeMovie)
        
        addSubview(image)
        addSubview(heartButton)
        
    }
    
    func setViewLayout() {
        image.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        heartButton.snp.makeConstraints{ make in
            make.top.left.equalToSuperview().inset(CGFloat.defaultMargin)
            make.height.width.equalTo(30)
        }
        snp.makeConstraints{ make in
            make.height.equalTo(image.snp.width).multipliedBy(imageRatioConstant)
        }
    }
    
    func setData() {
        if let data = movie.poster_path {
            image.image = UIImage(data: data)
        } else {
            image.image = UIImage(named: "UnknownPoster")
        }
        heartButton.setState(selected: movie.liked)
    }
    
    @objc func likeMovie(liked: Bool) {
        if let controller = findViewController() {
            guard let controller = controller as? FavoritesViewController else { return }
            controller.router.getMoviesRepository().likeMovie(movie.tmdbId, like: liked)
        }
    }
    
    @objc func clickMovie() {
        if let controller = findViewController() {
            guard let controller = controller as? FavoritesViewController else { return }
            controller.router.showMovieDetailsController(movieId: Int(truncatingIfNeeded: movie.tmdbId))
        }
    }
    
}
