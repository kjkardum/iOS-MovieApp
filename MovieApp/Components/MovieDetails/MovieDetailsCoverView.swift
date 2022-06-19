//
//  MovieDetailsCoverView.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 10.04.2022..
//

import Foundation
import UIKit
import SnapKit

typealias LikeButtonActionHandler = (Int)  -> Void

class MovieDetailsCoverView: UIView {
    var id: Int?
    
    var coverImage: UIImageView!
    var starButton: CircularToggleButton!
    var genreLabel: StyledUILabel!
    var movieLengthLabel: StyledUILabel!
    var movieReleaseLabel: StyledUILabel!
    var movieNameLabel: StyledUILabel!
    var userScoreLabel: StyledUILabel!
    var userScoreTitleLabel: StyledUILabel!
    
    var likeMovieActionHandler: LikeButtonActionHandler!
    
    init(likeButtonAction: @escaping LikeButtonActionHandler) {
        super.init(frame: CGRect())
        
        likeMovieActionHandler = likeButtonAction
        
        buildView()
        setViewLayout()
    }
    
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func buildView() {
        backgroundColor = .white
        
        coverImage = UIImageView()
        coverImage.image = UIImage(named: "LoadingImage")
        coverImage.contentMode = .scaleAspectFill
        coverImage.clipsToBounds = true
        
        starButton = CircularToggleButton(unselectedIcon: .star, selectedIcon: .starFill, action: likeMovie)
        genreLabel = StyledUILabel(color: .white)
        movieLengthLabel = StyledUILabel(bold: true, color: .white)
        movieReleaseLabel = StyledUILabel(color: .white)
        movieNameLabel = StyledUILabel(fontStyle: .title2, color: .white)
        userScoreLabel = StyledUILabel(fontStyle: .title2, color: .green)
        userScoreTitleLabel = StyledUILabel(text: "User Score",fontStyle: .headline, color: .white)
        
        addSubview(coverImage)
        addSubview(starButton)
        addSubview(genreLabel)
        addSubview(movieLengthLabel)
        addSubview(movieReleaseLabel)
        addSubview(movieNameLabel)
        addSubview(userScoreLabel)
        addSubview(userScoreTitleLabel)
    }
    
    func setViewLayout() {
        coverImage.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
            make.height.equalTo(coverImage.snp.width)
        }
        starButton.snp.makeConstraints{ make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.left.equalTo(coverImage.snp.left).offset(CGFloat.margin(withMultiplier: 3))
            make.bottom.equalTo(coverImage.snp.bottom).offset(-CGFloat.margin(withMultiplier: 3))
        }
        genreLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(starButton.snp.top).offset(-CGFloat.margin(withMultiplier: 3))
            make.left.equalTo(starButton).offset(500)
        } // THIRD
        movieLengthLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(genreLabel)
            make.left.equalTo(genreLabel.snp.right).offset(CGFloat.defaultMargin)
        }
        movieReleaseLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(genreLabel.snp.top).offset(-CGFloat.defaultMargin)
            make.left.equalTo(starButton).offset(500)
        } // SECOND
        movieNameLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(movieReleaseLabel.snp.top).offset(-CGFloat.defaultMargin)
            make.left.equalTo(starButton).offset(500)
        } // FIRST
        userScoreLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(movieNameLabel.snp.top).offset(-CGFloat.margin(withMultiplier: 3))
            make.left.equalTo(starButton)
        }
        userScoreTitleLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(userScoreLabel)
            make.left.equalTo(userScoreLabel.snp.right).offset(CGFloat.defaultMargin)
        }
    }
    
    
    func updateData(model: DetailedMovieNetworkModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateYearOnlyFormatter = DateFormatter()
        dateYearOnlyFormatter.dateFormat = "yyyy"
        
        let modelDateFormatter = DateFormatter()
        modelDateFormatter.dateFormat = "yyyy-MM-dd"
        let date = modelDateFormatter.date(from: model.release_date)!
        
        id = model.id
        coverImage.image = UIImage()
        if let url = URL(string: MoviesRepository.base_image_url + model.poster_path) {
            coverImage.load(url: url)
        }
        genreLabel.text = model.genres.map{genre in genre.name}.joined(separator: ", ")
        movieLengthLabel.text = (model.runtime * 60).asStringInterval()
        movieReleaseLabel.text = dateFormatter.string(from: date)
        movieNameLabel.text = model.title + "(" + dateYearOnlyFormatter.string(from: date) + ")"
        userScoreLabel.text = String(Int(model.vote_average * 10)) + "%"
        if let controller = findViewController() {
            guard let controller = controller as? MovieDetailsController else { return }
            starButton.setState(selected: controller.moviesRepository.getLiked(Int64(model.id)))
        }
    }
    override func didMoveToSuperview() {
        layoutIfNeeded()
        animate()
    }
    
    func animate() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
            self.movieNameLabel.snp.updateConstraints{ make in
                make.left.equalTo(self.starButton).offset(0)
            }
            self.layoutIfNeeded()
         }
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveLinear) {
            self.movieReleaseLabel.snp.updateConstraints{ make in
                make.left.equalTo(self.starButton).offset(0)
            }
            self.layoutIfNeeded()
         }
        UIView.animate(withDuration: 1, delay: 1, options: .curveLinear) {
            self.genreLabel.snp.updateConstraints{ make in
                make.left.equalTo(self.starButton).offset(0)
            }
            self.layoutIfNeeded()
         }
        
    }
    
    @objc func likeMovie(liked: Bool) {
        guard let id = id else { return }
        if let controller = findViewController() {
            guard let controller = controller as? MovieDetailsController else { return }
            controller.moviesRepository.likeMovie(Int64(id), like: liked)
        }
    }
}
