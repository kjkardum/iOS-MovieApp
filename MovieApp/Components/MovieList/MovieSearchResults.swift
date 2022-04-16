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

class MovieSearchResults : UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var movieResultsCollection: UICollectionView!
    var results: [String] = ["Demo", "Test", "Third", "Fourth"]
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
        movieResultsCollection.contentInset = UIEdgeInsets(top: CGFloat(Float(marginSmall)), left: 0, bottom: CGFloat(Float(marginSmall)), right: 0)
        movieResultsCollection.showsVerticalScrollIndicator = false
        movieResultsCollection.layer.masksToBounds = false
        layer.masksToBounds = true
        
        addSubview(movieResultsCollection)
        
    }
    
    func setViewLayout() {
        movieResultsCollection.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(marginSmall)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSearchResultCell.id, for: indexPath) as! MovieSearchResultCell
        let data = self.results[indexPath.item]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 200)
    }
}

class MovieSearchResultCell : UICollectionViewCell {
    static var id = "MovieSearchResultCell"
    weak var image: UIImageView!
    weak var title: StyledUILabel!
    weak var shortDescription: StyledUILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
        setViewLayout()
        let movie = Movies.all()[0]
        updateData(imageUrl: movie.imageUrl, title: movie.title, shortDescription: movie.description)
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
            make.width.equalTo(image.snp.height).dividedBy(1.4)
        }
        title.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(marginMedium)
            make.left.equalTo(image.snp.right).offset(marginMedium)
        }
        shortDescription.snp.makeConstraints{ make in
            make.top.equalTo(title.snp.bottom).offset(marginMedium)
            make.left.equalTo(image.snp.right).offset(marginMedium)
            make.right.equalToSuperview().inset(marginMedium)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    func updateData(imageUrl: String, title: String, shortDescription: String) {
        self.image.load(url: URL(string: imageUrl)!)
        self.title.text = title
        self.shortDescription.text = shortDescription
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
}
