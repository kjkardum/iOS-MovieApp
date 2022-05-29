//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 10.04.2022..
//

import Foundation
import UIKit
import SnapKit

class MovieListViewController: UIViewController, SearchBoxDelegate {
    var router: AppRouterProtocol!
    
    var innerView: UIView!
    var searchBar: SearchBarView!
    var sectionsList: MovieAllSectionsCollectionView!
    var searchResultsList: MovieSearchResults!
    
    var moviesRepository: MoviesRepository!
    var errorMessageShown = false
    var movieGenres: [Genre]?
    var popularMovies: [Movie]?
    var trendingMoviesDay: [Movie]?
    var trendingMoviesWeek: [Movie]?
    var topRatedMovies: [Movie]?
    var recommendedMovies: [Movie]?
    
    init (router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildView()
        setViewLayout()
        moviesRepository = router.getMoviesRepository()
        loadData()
    }
    
    func buildView() {
        view.backgroundColor = .themeBlue
        
        let titleImage =  UIImageView(image: UIImage(named: "HeaderLogo"))
        navigationController?.navigationBar.topItem?.titleView = titleImage
        
        innerView = UIView()
        innerView.backgroundColor = .white
        searchBar = SearchBarView()
        sectionsList = MovieAllSectionsCollectionView()
        searchResultsList = MovieSearchResults()
        searchBar.delegate = self
        
        innerView.addSubview(searchBar)
        innerView.addSubview(sectionsList)
        innerView.addSubview(searchResultsList)
        view.addSubview(innerView)
        searchResultsList.isHidden = true
    }
    
    func setViewLayout() {
        innerView.snp.makeConstraints{ make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        searchBar.snp.makeConstraints{ make in
            make.left.right.equalToSuperview().inset(CGFloat.margin(withMultiplier: 2))
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(CGFloat.margin(withMultiplier: 2))
        }
        sectionsList.snp.makeConstraints{ make in
            make.top.equalTo(searchBar.snp.bottom).offset(CGFloat.margin(withMultiplier: 3))
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        searchResultsList.snp.makeConstraints{ make in
            make.top.equalTo(searchBar.snp.bottom).offset(CGFloat.margin(withMultiplier: 3))
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func fillViewData() {
        if errorMessageShown { return }
        guard
            let movieGenres = movieGenres
        else { return }
        
        let popularMovies = popularMovies ?? []
        let trendingMoviesDay = trendingMoviesDay ?? []
        let trendingMoviesWeek = trendingMoviesWeek ?? []
        let topRatedMovies = topRatedMovies ?? []
        let recommendedMovies = recommendedMovies ?? []
        
        let categories: [MoviesCategoryModel] = [
            MoviesCategoryModel(categoryName: "Popular", categoryGroups: createMovieGroups(popularMovies)),
            MoviesCategoryModel(categoryName: "Trending", categoryGroups: [
                GroupedMovieModel(groupId: 0, groupName: "Day", movies: trendingMoviesDay),
                GroupedMovieModel(groupId: 1, groupName: "Week", movies: trendingMoviesWeek)
            ]),
            MoviesCategoryModel(categoryName: "Top Rated", categoryGroups: createMovieGroups(topRatedMovies)),
            MoviesCategoryModel(categoryName: "Recommended", categoryGroups: createMovieGroups(recommendedMovies))
        ]
        searchResultsList.updateData(movies: popularMovies)
        sectionsList.updateData(categories: categories)
    }
    
    func createMovieGroups(_ movies: [Movie]) -> [GroupedMovieModel] {
        guard let movieGenres = movieGenres else { return [] }
        let groupedItems = movieGenres.map{ genre in GroupedMovieModel(
            groupId: Int(truncatingIfNeeded: genre.id),
            groupName: genre.name,
            movies: movies.filter{movie in movie.genres.contains(where: { $0.id == Int64(genre.id) })})}
        return groupedItems.filter{ group in group.movies.count > 0 }
    }
    
    func onSearchBoxFocus() {
        sectionsList.fadeOut()
        searchResultsList.fadeIn()
    }
    func onSearchBoxUnfocus() {
        sectionsList.fadeIn(0)
        searchResultsList.fadeOut()
    }
    
    func onSearchBoxChange(input: String) {
        searchResultsList.filterData(filter: input)
    }
    
    func showErrorMessage() {
        guard errorMessageShown == false else { return }
        errorMessageShown = true
        innerView.removeFromSuperview()
        innerView = UIView()
        innerView.backgroundColor = .themeLightGray
        let errorImage = UIImageView(image: UIImage(systemSymbol: .airplane))
        errorImage.tintColor = .black
        innerView.addSubview(errorImage)
        view.addSubview(innerView)
        innerView.snp.makeConstraints{ make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        errorImage.snp.makeConstraints{ make in make.center.equalToSuperview()}
    }
    
    func loadData() {
        loadGenres()
        loadTrendingMoviesDay()
        loadTrendingMoviesWeek()
    }
    func loadGenres() {
        self.moviesRepository.getMovieGenres{ result in
            DispatchQueue.main.async {
                switch (result) {
                case .failure(_):
                    self.showErrorMessage()
                    return
                case .success(let value):
                    if (self.movieGenres != nil && self.movieGenres!.count > 0) {
                        return
                    }
                    self.movieGenres = value
                    self.loadPopularMovies()
                    self.loadTopRatedMovies()
                    self.loadRecommendedMovies()
                    return
                }
            }
        }
    }
    
    func loadPopularMovies() {
        self.moviesRepository.getPopularMovies(page: 1, genre: nil) { result in
            DispatchQueue.main.async {
                switch (result) {
                case .failure(_):
                    return
                case .success(let value):
                    self.popularMovies = value
                    self.fillViewData()
                    return
                }
            }
        }
    }
    
    func loadTrendingMoviesDay() {
        self.moviesRepository.getDayTrendingMovies(page: 1) { result in
            DispatchQueue.main.async {
                switch (result) {
                case .failure(_):
                    return
                case .success(let value):
                    self.trendingMoviesDay = value
                    self.fillViewData()
                    return
                }
            }
        }
    }
    
    func loadTrendingMoviesWeek() {
        self.moviesRepository.getWeekTrendingMovies(page: 1) { result in
            DispatchQueue.main.async {
                switch (result) {
                case .failure(_):
                    return
                case .success(let value):
                    self.trendingMoviesWeek = value
                    self.fillViewData()
                    return
                }
            }
        }
    }
    
    func loadTopRatedMovies() {
        self.moviesRepository.getTopRatedMovies(page: 1, genre: nil) { result in
            DispatchQueue.main.async {
                switch (result) {
                case .failure(_):
                    return
                case .success(let value):
                    self.topRatedMovies = value
                    self.fillViewData()
                    return
                }
            }
        }
    }
    
    func loadRecommendedMovies() {
        self.moviesRepository.getRecommendedMovies(movieId: 103, genre: nil, page: 1) { result in
            DispatchQueue.main.async {
                switch (result) {
                case .failure(_):
                    return
                case .success(let value):
                    self.recommendedMovies = value
                    self.fillViewData()
                    return
                }
            }
        }
    }
    
}
