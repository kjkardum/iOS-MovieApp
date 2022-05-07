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
    var router: AppRouterProtocol!
    let movieId: Int
    
    var scrollView: UIScrollView!
    var scrollContentView: UIView!
    var coverView: MovieDetailsCoverView!
    var overviewView: MovieDetailsOverviewView!
    var castView: MovieDetailsCastView!
    var socialView: MovieDetailsSocialView!
    var recommendationsView: MovieDetailsRecommendationsView!
    
    var movie: MovieModel?
    
    init (router: AppRouterProtocol, movieId: Int) {
        self.router = router
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        setViewLayout()
        fillViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let titleImage =  UIImageView(image: UIImage(named: "HeaderLogo"))
        navigationItem.titleView = titleImage
    }
    
    func buildView() {
        view.backgroundColor = .themeBlue
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = .white
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
            make.bottom.left.right.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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
        let moviesRepository = router.getMoviesRepository()
        DispatchQueue.global(qos: .background).async {
            moviesRepository.getMovieDetails(movieId: self.movieId, page: 1) { result in
                DispatchQueue.main.async {
                    switch (result) {
                    case .failure(let value):
                        print(value, self.movieId)
                        self.router.popBack()
                        return
                    case .success(let value):
                        self.coverView.updateData(model: value)
                        self.overviewView.updateData(model: value)
                        return
                    }
                }
            }
        }
    }
}
