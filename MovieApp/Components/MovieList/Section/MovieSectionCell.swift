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
    var movieId: Int?
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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickMovie))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
        
        
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
    
    @objc func clickMovie() {
        if let controller = findViewController() {
            guard let controller = controller as? MovieListViewController, let movieId = movieId else { return }
            controller.router.showMovieDetailsController(movieId: movieId)
        }
    }
    
    func updateData(movie: SimpleMovieNetworkModel) {
        if let url = URL(string: MoviesRepository.base_image_url + movie.poster_path) {
            image.load(url: url)
        }
        movieId = movie.id
    }
    
}
