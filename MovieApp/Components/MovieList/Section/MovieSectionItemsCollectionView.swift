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

class MovieSectionItemsCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var movieListCollection: UICollectionView!
    var availableMovies: [SimpleMovieNetworkModel] = []
    
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
        movieListCollection.contentInset = UIEdgeInsets(top: 0, left: CGFloat.margin(withMultiplier: 3), bottom: 0, right: CGFloat.margin(withMultiplier: 3))
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSectionCell.id, for: indexPath) as? MovieSectionCell
        guard let cell = cell, indexPath.item < self.availableMovies.count else {
            return MovieSectionCell(frame: .zero)
        }
        let data = self.availableMovies[indexPath.item]
        cell.updateData(movie: data)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height/imageRatioConstant, height: collectionView.frame.size.height)
    }
    
    func updateData(group: GroupedMovieModel) {
        availableMovies = group.movies
        movieListCollection.reloadData()
    }
    
}
