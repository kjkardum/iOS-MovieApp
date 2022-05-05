//
//  MovieListSection.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 11.04.2022..
//

import Foundation
import UIKit
import SnapKit
import MovieAppData

class MovieSectionView: UIView, MovieFilterDelegate {
    var titleLabel: StyledUILabel!
    var filtersScrollView: UIScrollView!
    var filtersStackView: MovieSectionFilterView!
    var movieList: MovieSectionItemsCollectionView!
    var moviesInSection: [MovieAppData.MovieModel] = []
    var parentSelectFilter: ((MovieFilter) -> Void)? = nil
    
    init() {
        super.init(frame: CGRect())
        
        buildView()
        setViewLayout()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func buildView() {
        titleLabel = StyledUILabel(text:"-", bold: true, fontStyle: .title3, color: .themeBlue)
        movieList = MovieSectionItemsCollectionView()
        filtersScrollView = UIScrollView()
        filtersScrollView.showsHorizontalScrollIndicator = false
        
        filtersStackView = MovieSectionFilterView()
        filtersStackView.delegate = self
        filtersScrollView.addSubview(filtersStackView)
        
        addSubview(titleLabel)
        addSubview(filtersScrollView)
        addSubview(movieList)
        
    }
    
    func setViewLayout() {
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(CGFloat.defaultMargin)
        }
        filtersStackView.snp.makeConstraints{ make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.defaultMargin)
            make.bottom.equalToSuperview()
        }
        filtersScrollView.snp.makeConstraints{ make in
            make.left.right.equalToSuperview().inset(CGFloat.defaultMargin)
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.defaultMargin)
            make.height.equalTo(filtersStackView)
        }
        movieList.snp.makeConstraints{ make in
            make.top.equalTo(filtersScrollView.snp.bottom).offset(CGFloat.defaultMargin)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(movieListItemSize)
        }
    }
    
    func selectFilter(filter: MovieFilter, animationDuration: TimeInterval) {
        movieList.fadeOut(animationDuration, onCompletion: { [weak self] in
            guard let self = self else { return }
            self.movieList.updateData(movies: self.moviesInSection.filter{movie in
                let genre = movie.genre.stringValue
                let filter = filter.stringValue
                return genre == filter || !Genre.allStringValues.contains(filter)
            })
            self.movieList.fadeIn(animationDuration)
        }, changeHidden: false)
        if let parentSelectFilter = parentSelectFilter { parentSelectFilter(filter) }
    }
    
    func updateData(dataSection: GroupedMovieModel, selectFilter: @escaping ((MovieFilter) -> Void), filter: MovieFilter? = nil) {
        parentSelectFilter = selectFilter
        titleLabel.text = dataSection.group.stringValue
        moviesInSection = dataSection.movies
        filtersStackView.setFilters(filters: dataSection.group.filters.filter{item in
            let filter = item.stringValue
            if !Genre.allStringValues.contains(filter) {
                return true
            }
            let moviesInFilter = moviesInSection.filter{movie in
                let genre = movie.genre.stringValue
                return genre == filter
            }
            return moviesInFilter.count > 0
        }, currentFilter: filter)
    }
}
