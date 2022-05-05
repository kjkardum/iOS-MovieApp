//
//  MovieDetailsController.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 10.04.2022..
//

import Foundation
import UIKit
import SnapKit

class MovieDetailsController: UIViewController {
    var scrollView: UIScrollView!
    var scrollContentView: UIView!
    var coverView: MovieDetailsCoverView!
    var overviewView: MovieDetailsOverviewView!
    var castView: MovieDetailsCastView!
    var socialView: MovieDetailsSocialView!
    var recommendationsView: MovieDetailsRecommendationsView!
    
    var movie: MovieModel?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        setViewLayout()
        Task {
            movie = await MovieModel.getPlaceholderMovie()
            self.fillViewData()
        }
    }
    
    func buildView() {
        navigationItem.title = "Movie Details"
        
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollContentView = UIView()
        scrollView.addSubview(scrollContentView)
        
        coverView = MovieDetailsCoverView(likeButtonAction: {id in print(id)})
        overviewView = MovieDetailsOverviewView()
        castView = MovieDetailsCastView()
        socialView = MovieDetailsSocialView()
        recommendationsView = MovieDetailsRecommendationsView()
        scrollContentView.addSubview(coverView)
        scrollContentView.addSubview(overviewView)
        scrollContentView.addSubview(castView)
        scrollContentView.addSubview(socialView)
        scrollContentView.addSubview(recommendationsView)
    }
    
    func setViewLayout() {
        scrollView.snp.makeConstraints{ make in
            make.edges.equalTo(view)
        }
        scrollContentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
        }
        coverView.snp.makeConstraints{ make in
            make.top.left.right.equalToSuperview()
        }
        overviewView.snp.makeConstraints{ make in
            make.top.equalTo(coverView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        castView.snp.makeConstraints{ make in
            make.top.equalTo(overviewView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        socialView.snp.makeConstraints{ make in
            make.top.equalTo(castView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        recommendationsView.snp.makeConstraints{ make in
            make.top.equalTo(socialView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(scrollContentView)
        }
    }
    
    func fillViewData() {
        if let movie = movie {
            coverView.updateData(model: movie)
            overviewView.updateData(model: movie)
        }
    }
}
