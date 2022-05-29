//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation
import UIKit
import SnapKit

class FavoritesViewController: UIViewController {
    var router: AppRouterProtocol!
    var innerView: UIView!
    var titleLabel: StyledUILabel!
    var scrollView: UIScrollView!
    var favoritesStack: FavoritesStackView!
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    func buildView() {
        let titleImage =  UIImageView(image: UIImage(named: "HeaderLogo"))
        navigationController?.navigationBar.topItem?.titleView = titleImage
        
        innerView = UIView()
        innerView.backgroundColor = .white
        
        titleLabel = StyledUILabel(text:"Favorites", bold: true, fontStyle: .title3, color: .themeBlue)
        
        scrollView = UIScrollView()
        favoritesStack = FavoritesStackView()
        innerView.addSubview(titleLabel)
        scrollView.addSubview(favoritesStack)
        innerView.addSubview(scrollView)
        view.addSubview(innerView)
        view.backgroundColor = .themeBlue
    }
    
    func setViewLayout() {
        innerView.snp.makeConstraints{ make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(CGFloat.margin(withMultiplier: 3))
            make.left.right.equalToSuperview().inset(CGFloat.defaultMargin)
        }
        scrollView.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.defaultMargin)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(CGFloat.margin(withMultiplier: 3))
        }
        favoritesStack.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(titleLabel)
        }
    }
    
    func loadData() {
        let movies = router.getMoviesRepository().getLikedMovies()
        favoritesStack.updateData(movies: movies)
    }
}
