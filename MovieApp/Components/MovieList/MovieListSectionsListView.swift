//
//  MovieListSectionsListView.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 16.04.2022..
//

import Foundation
import UIKit
import SnapKit
import MovieAppData

class MovieListSectionsListView : UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var movieSectionsCollection: UICollectionView!
    var sectionsData: [(MovieGroup,[MovieAppData.MovieModel])] = []
    var selectedFilters: [MovieGroup : MovieFilter] = [:]
    
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

        movieSectionsCollection = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        movieSectionsCollection.dataSource = self
        movieSectionsCollection.delegate = self
        movieSectionsCollection.register(MovieListSectionCell.self, forCellWithReuseIdentifier: MovieListSectionCell.id)
        movieSectionsCollection.isScrollEnabled = true
        movieSectionsCollection.contentInset = UIEdgeInsets(top: CGFloat(Float(marginSmall)), left: 0, bottom: CGFloat(Float(marginSmall)), right: 0)
        movieSectionsCollection.showsVerticalScrollIndicator = false
        movieSectionsCollection.backgroundColor = .white
        
        addSubview(movieSectionsCollection)
        
    }
    
    func setViewLayout() {
        movieSectionsCollection.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateData(groups: [MovieGroup : [MovieAppData.MovieModel]]) {
        sectionsData = groups.map { (key, value) in (key, value)}
        movieSectionsCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListSectionCell.id, for: indexPath) as! MovieListSectionCell
        let data = self.sectionsData[indexPath.item]
        cell.updateData(
            dataSection: data,
            selectFilter: { [self] filter in
                selectedFilters[data.0] = filter
            },
            filter: selectedFilters[data.0])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 200)
    }
}


class MovieListSectionCell : UICollectionViewCell {
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
    
    func updateData(dataSection: (MovieGroup, [MovieAppData.MovieModel]), selectFilter: @escaping ((MovieFilter) -> Void), filter: MovieFilter? = nil) {
        section.updateData(dataSection: dataSection, selectFilter: selectFilter, filter: filter)
    }
}
