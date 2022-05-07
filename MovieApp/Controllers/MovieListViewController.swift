//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 10.04.2022..
//

import Foundation
import UIKit
import SnapKit
import MovieAppData

class MovieListViewController: UIViewController, SearchBoxDelegate {
    var router: AppRouterProtocol!
    
    var innerView: UIView!
    var searchBar: SearchBarView!
    var sectionsList: MovieAllSectionsCollectionView!
    var searchResultsList: MovieSearchResults!
    

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
        Task {
            //DB or Network ACCESS WILL BE ADDED LATER, SIMULATED WITH awaiting Sleep
            try await Task.sleep(nanoseconds: 700_000_000)
            self.fillViewData()
        }
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
        let movies = Movies.all()
        let groups = MovieGroup.allCases.reduce([MovieGroup: [MovieAppData.MovieModel]]()) { (dict, group) -> [MovieGroup: [MovieAppData.MovieModel]] in
            var dict = dict
            dict[group] = movies.filter{ $0.group.contains(group) }
            return dict
        }
        sectionsList.updateData(groups: groups)
        searchResultsList.updateData(movies: movies)
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
        let movies = Movies.all().filter{ movie in input.isEmpty || movie.title.lowercased().contains(input.lowercased()) }
        searchResultsList.updateData(movies: movies)
    }
}
