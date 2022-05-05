//
//  MovieSearchResults.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 16.04.2022..
//

import Foundation
import UIKit
import SnapKit
import MovieAppData

class MovieSearchResults: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var movieResultsCollection: UICollectionView!
    var results: [MovieAppData.MovieModel] = []
    
    init() {
        super.init(frame: CGRect())
        
        buildView()
        setViewLayout()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func buildView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        movieResultsCollection = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        movieResultsCollection.dataSource = self
        movieResultsCollection.delegate = self
        movieResultsCollection.register(MovieSearchResultCell.self, forCellWithReuseIdentifier: MovieSearchResultCell.id)
        movieResultsCollection.isScrollEnabled = true
        movieResultsCollection.contentInset = UIEdgeInsets(top: CGFloat.defaultMargin, left: 0, bottom: CGFloat.defaultMargin, right: 0)
        movieResultsCollection.showsVerticalScrollIndicator = false
        movieResultsCollection.layer.masksToBounds = false
        movieResultsCollection.backgroundColor = .white
        
        layer.masksToBounds = true
        
        addSubview(movieResultsCollection)
        
    }
    
    func setViewLayout() {
        movieResultsCollection.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(CGFloat.defaultMargin)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSearchResultCell.id, for: indexPath) as! MovieSearchResultCell
        let data = self.results[indexPath.item]
        cell.updateData(imageUrl: data.imageUrl, title: data.title, shortDescription: data.description)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 200)
    }
    
    func updateData(movies: [MovieAppData.MovieModel]) {
        results = movies
        movieResultsCollection.reloadData()
    }
}
