//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 10.04.2022..
//

import Foundation
import UIKit
import SnapKit

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
        //demoSection.updateData(title: "What's popular", filters: ["Streaming", "ON TV", "For Rent", "In theaters", "Something"])
    }
    
    func onSearchBoxFocus() {
        sectionsList.isHidden = true
        searchResultsList.isHidden = false
    }
    func onSearchBoxUnfocus() {
        sectionsList.isHidden = false
        searchResultsList.isHidden = true
    }
}