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

class MovieListViewController : UIViewController, SearchBoxDelegate {
    var searchBar: SearchBarView!
    var sectionsList: MovieListSectionsListView!
    var searchResultsList: MovieSearchResults!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
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
        view.backgroundColor = .white
        
        searchBar = SearchBarView()
        sectionsList = MovieListSectionsListView()
        searchResultsList = MovieSearchResults()
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        view.addSubview(sectionsList)
        view.addSubview(searchResultsList)
        searchResultsList.isHidden = true
    }
    
    func setViewLayout() {
        searchBar.snp.makeConstraints{ make in
            make.left.right.equalToSuperview().inset(marginSmall)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(marginSmall)
        }
        sectionsList.snp.makeConstraints{ make in
            make.top.equalTo(searchBar.snp.bottom).offset(marginDefault)
            make.left.right.bottom.equalToSuperview()
        }
        searchResultsList.snp.makeConstraints{ make in
            make.top.equalTo(searchBar.snp.bottom).offset(marginDefault)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func fillViewData() {
        let movies = Movies.all()
        let groups = MovieGroup.allCases.reduce([MovieGroup : [MovieAppData.MovieModel]]()) { (dict, group) -> [MovieGroup : [MovieAppData.MovieModel]] in
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
        let movies = Movies.all().filter{ movie in input == "" || movie.title.lowercased().contains(input.lowercased()) }
        searchResultsList.updateData(movies: movies)
    }
}
