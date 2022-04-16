//
//  MovieListSection.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 11.04.2022..
//

import Foundation
import UIKit
import SnapKit

class MovieSectionView : UIView {
    var titleLabel: StyledUILabel!
    var filtersScrollView: UIScrollView!
    var filtersStackView: MovieSectionFilterView!
    var movieList: MovieSectionListView!
    
    init() {
        super.init(frame: CGRect())
        
        buildView()
        setViewLayout()
        filtersStackView.setFilters(filters: ["Demo", "List"])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func buildView() {
        titleLabel = StyledUILabel(text:"Demo group", bold: true, fontStyle: .title3, color: HexColorHelper.GetUIColor(hex: blueColorCode) ?? .red)
        movieList = MovieSectionListView()
        filtersScrollView = UIScrollView()
        filtersScrollView.showsHorizontalScrollIndicator = false
        filtersStackView = MovieSectionFilterView()
        filtersScrollView.addSubview(filtersStackView)
        
        addSubview(titleLabel)
        addSubview(filtersScrollView)
        addSubview(movieList)
        
    }
    
    func updateData(title: String, filters: [String]) {
        titleLabel.text = title
        filtersStackView.setFilters(filters: filters)
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
}
