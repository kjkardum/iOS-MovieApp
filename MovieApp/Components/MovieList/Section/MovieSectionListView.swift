//
//  MovieSectionListView.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 11.04.2022..
//

import Foundation
import UIKit
import SnapKit
import MovieAppData

class MovieSectionListView : UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var movieListCollection: UICollectionView!
    var availableMovies: [MovieAppData.MovieModel] = []
    
    init() {
        super.init(frame: CGRect())
        
        buildView()
        setViewLayout()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func buildView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        movieListCollection = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        movieListCollection.dataSource = self
        movieListCollection.delegate = self
        movieListCollection.register(MovieSectionCell.self, forCellWithReuseIdentifier: MovieSectionCell.id)
        movieListCollection.isScrollEnabled = true
        movieListCollection.contentInset = UIEdgeInsets(top: 0, left: CGFloat(Float(marginDefault)), bottom: 0, right: CGFloat(Float(marginDefault)))
        movieListCollection.showsHorizontalScrollIndicator = false
        movieListCollection.backgroundColor = .clear
        
        addSubview(movieListCollection)
    }
    
    func setViewLayout() {
        movieListCollection.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.availableMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSectionCell.id, for: indexPath) as! MovieSectionCell
        let data = self.availableMovies[indexPath.item]
        cell.updateData(movie: data)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height/1.46, height: collectionView.frame.size.height)
    }
    
    func updateData(movies: [MovieAppData.MovieModel]) {
        availableMovies = movies
        movieListCollection.reloadData()
    }
    
}

class MovieSectionCell : UICollectionViewCell {
    static var id = "MovieCell"
    weak var image: UIImageView!
    weak var heartButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let image = UIImageView()
        self.contentView.addSubview(image)
        self.image = image
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        
        let heartButton = UIButton.createIconButton(
            icon: .heart,
            backgroundColor: HexColorHelper.GetUIColor(hex: blueTransparent) ?? .clear,
            borderRadius: 15,
            target: self, action: #selector(likeMovie))
        self.contentView.addSubview(heartButton)
        self.heartButton = heartButton
        
        image.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        heartButton.snp.makeConstraints{ make in
            make.top.left.equalToSuperview().inset(marginSmall)
            make.height.width.equalTo(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    @objc func likeMovie(button: UIButton) { }
    
    func updateData(movie: MovieAppData.MovieModel) {
        if let url = URL(string: movie.imageUrl) {
            image.load(url: url)
        }
    }
    
}
