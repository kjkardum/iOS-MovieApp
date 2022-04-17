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

class MovieSectionView : UIView, MovieFilterDelegate {
    var titleLabel: StyledUILabel!
    var filtersScrollView: UIScrollView!
    var filtersStackView: MovieSectionFilterView!
    var movieList: MovieSectionListView!
    var moviesInSection: [MovieAppData.MovieModel] = []
    
    init() {
        super.init(frame: CGRect())
        
        buildView()
        setViewLayout()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func buildView() {
        titleLabel = StyledUILabel(text:"-", bold: true, fontStyle: .title3, color: HexColorHelper.GetUIColor(hex: blueColorCode) ?? .red)
        movieList = MovieSectionListView()
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
            make.left.right.equalToSuperview().inset(marginSmall)
        }
        filtersStackView.snp.makeConstraints{ make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(marginSmall)
            make.bottom.equalToSuperview()
        }
        filtersScrollView.snp.makeConstraints{ make in
            make.left.right.equalToSuperview().inset(marginSmall)
            make.top.equalTo(titleLabel.snp.bottom).offset(marginSmall)
            make.height.equalTo(filtersStackView)
        }
        movieList.snp.makeConstraints{ make in
            make.top.equalTo(filtersScrollView.snp.bottom).offset(marginSmall)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(movieListItemSize)
        }
    }
    
    func selectFilter(filter: MovieFilter) {
        movieList.updateData(movies: moviesInSection.filter{movie in
            let genre = MovieEnumsStringConverter.convert(movie.genre)
            let filter = MovieEnumsStringConverter.convert(filter)
            return genre == filter || !MovieEnumsStringConverter.genreFilterStrings.contains(filter)
        })
    }
    
    func updateData(dataSection: (MovieGroup, [MovieAppData.MovieModel])) {
        titleLabel.text = MovieEnumsStringConverter.convert(dataSection.0)
        moviesInSection = dataSection.1
        filtersStackView.setFilters(filters: dataSection.0.filters.filter{item in
            let filter = MovieEnumsStringConverter.convert(item)
            if !MovieEnumsStringConverter.genreFilterStrings.contains(filter) {
                return true
            }
            let moviesInFilter = moviesInSection.filter{movie in
                let genre = MovieEnumsStringConverter.convert(movie.genre)
                return genre == filter
            }
            return moviesInFilter.count > 0
        })
    }
}
