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

class MovieDetailsCoverView : UIView {
    var id: Int?
    
    var coverImage: UIImageView!
    var starButton: UIButton!
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
        
        starButton = UIButton.createIconButton(icon: .star, target: self, action: #selector(likeMovie))
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
            make.left.equalTo(coverImage.snp.left).offset(marginDefault)
            make.bottom.equalTo(coverImage.snp.bottom).offset(-marginDefault)
        }
        genreLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(starButton.snp.top).offset(-marginDefault)
            make.left.equalTo(starButton)
        }
        movieLengthLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(genreLabel)
            make.left.equalTo(genreLabel.snp.right).offset(marginSmall)
        }
        movieReleaseLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(genreLabel.snp.top).offset(-marginSmall)
            make.left.equalTo(genreLabel)
        }
        movieNameLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(movieReleaseLabel.snp.top).offset(-marginSmall)
            make.left.equalTo(movieReleaseLabel)
        }
        userScoreLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(movieNameLabel.snp.top).offset(-marginDefault)
            make.left.equalTo(movieNameLabel)
        }
        userScoreTitleLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(userScoreLabel)
            make.left.equalTo(userScoreLabel.snp.right).offset(marginSmall)
        }
    }
    
    
    func updateData(model: MovieModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateYearOnlyFormatter = DateFormatter()
        dateYearOnlyFormatter.dateFormat = "yyyy"
        
        id = model.id
        coverImage.image = UIImage(named: model.imageUrl)
        genreLabel.text = model.genres.joined(separator: ", ")
        movieLengthLabel.text = model.length.asStringInterval()
        movieReleaseLabel.text = dateFormatter.string(from: model.releaseDate)
        movieNameLabel.text = model.name + "(" + dateYearOnlyFormatter.string(from: model.releaseDate) + ")"
        userScoreLabel.text = String(model.userScorePercentage) + "%"
    }
    
    @objc func likeMovie() {
        if let id = id {
            likeMovieActionHandler(id)
        }
    }
}
