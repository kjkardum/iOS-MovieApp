//
//  MovieDetailsOverviewView.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 10.04.2022..
//

import Foundation
import UIKit

class MovieDetailsOverviewView: UIView {
    var overviewTitleLabel: StyledUILabel!
    var overviewLabel: StyledUILabel!
    var peopleList: MovieDetailsOverviewPeopleView!
    
    init() {
        super.init(frame: CGRect())
        
        buildView()
        setViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        backgroundColor = .white
        overviewTitleLabel = StyledUILabel(text: "Overview", bold: true, fontStyle: .headline)
        overviewLabel = StyledUILabel(text: "")
        peopleList = MovieDetailsOverviewPeopleView()
        
        addSubview(overviewTitleLabel)
        addSubview(overviewLabel)
        addSubview(peopleList)
    }
    
    func setViewLayout() {
        overviewTitleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(CGFloat.margin(withMultiplier: 3))
            make.left.equalToSuperview().offset(CGFloat.defaultMargin)
        }
        overviewLabel.snp.makeConstraints{ make in
            make.top.equalTo(overviewTitleLabel.snp.bottom).offset(CGFloat.margin(withMultiplier: 3))
            make.left.right.equalToSuperview().inset(CGFloat.defaultMargin)
        }
        peopleList.snp.makeConstraints{ make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(CGFloat.margin(withMultiplier: 3))
            make.left.right.equalToSuperview().inset(CGFloat.defaultMargin)
            make.bottom.equalToSuperview().inset(CGFloat.margin(withMultiplier: 3) * 3)
        }
    }
    
    func updateData(model: DetailedMovieNetworkModel) {
        overviewLabel.text = model.overview
        var featured: [MovieFeaturedEntityModel] = model.production_companies.map{ MovieFeaturedEntityModel(id: 0, name: $0.name, role: "Producer")}
        featured.append(contentsOf: model.production_countries.map { MovieFeaturedEntityModel(id: 0, name: $0.name, role: "Country") })
        peopleList.updateData(newFeatured: featured)
    }
}
