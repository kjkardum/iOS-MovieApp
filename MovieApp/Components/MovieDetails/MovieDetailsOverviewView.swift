//
//  MovieDetailsOverviewView.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 10.04.2022..
//

import Foundation
import UIKit

class MovieDetailsOverviewView : UIView {
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
            make.top.left.equalToSuperview().offset(marginDefault)
            make.left.equalToSuperview().offset(marginSmall)
        }
        overviewLabel.snp.makeConstraints{ make in
            make.top.equalTo(overviewTitleLabel.snp.bottom).offset(marginDefault)
            make.left.right.equalToSuperview().inset(marginSmall)
        }
        peopleList.snp.makeConstraints{ make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(marginDefault)
            make.left.right.equalToSuperview().inset(marginSmall)
            make.bottom.equalToSuperview().inset(marginDefault * 3)
        }
    }
    
    func updateData(model: MovieModel) {
        overviewLabel.text = model.shortDescription
        if let featuredPeople = model.featuredPeople {
            peopleList.updateData(newPeople: featuredPeople)
        }
    }
}
