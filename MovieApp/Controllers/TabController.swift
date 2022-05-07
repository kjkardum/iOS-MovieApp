//
//  TabController.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation
import UIKit
import SFSafeSymbols

class TabController: UITabBarController {
    private var router: AppRouterProtocol
    
    init (router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
        setTabs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let titleImage =  UIImageView(image: UIImage(named: "HeaderLogo"))
        navigationItem.titleView = titleImage
    }
    
    
    private func setTabs() {
        let fontAttributes = [NSAttributedString.Key.font: UIFont.custom(name: themeFont, style: .caption2) ?? UIFont.systemFont(ofSize: 12)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
        tabBar.dropShadow()
        
        let movieListController = MovieListViewController(router: router)
        let favoritesController = FavoritesViewController(router: router)
        
        movieListController.tabBarItem = UITabBarItem(title: "Home",
                                                      image: UIImage(systemSymbol: .house),
                                                      selectedImage: UIImage(systemSymbol: .houseFill))
        
        favoritesController.tabBarItem = UITabBarItem(title: "Favorites",
                                                      image: UIImage(systemSymbol: .heart),
                                                      selectedImage: UIImage(systemSymbol: .heartFill))
        
        viewControllers = [movieListController, favoritesController]
    }
}
