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

class MovieAllSectionsCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var movieSectionsCollection: UICollectionView!
    var sectionsData: [MoviesCategoryModel] = []
    var selectedFilters: [String: Int] = [:]
    
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
        movieSectionsCollection.contentInset = UIEdgeInsets(top: CGFloat.defaultMargin, left: 0, bottom: CGFloat.defaultMargin, right: 0)
        movieSectionsCollection.showsVerticalScrollIndicator = false
        movieSectionsCollection.backgroundColor = .white
        
        addSubview(movieSectionsCollection)
        
    }
    
    func setViewLayout() {
        movieSectionsCollection.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateData(categories: [MoviesCategoryModel]) {
        sectionsData = categories
        movieSectionsCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListSectionCell.id, for: indexPath) as! MovieListSectionCell
        let data = self.sectionsData[indexPath.item]
        cell.updateData(
            category: data,
            selectFilter: { [weak self] filter in
                guard let self = self else { return }
                self.selectedFilters[data.categoryName] = filter
            },
            filter: selectedFilters[data.categoryName])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 200)
    }
}
