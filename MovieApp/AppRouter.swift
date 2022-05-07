//
//  AppRouter.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation
import UIKit

class AppRouter: AppRouterProtocol {
    private let navigationController: UINavigationController!
    private let networkService: NetworkServiceProtocol!
    private let moviesRepository: MoviesRepository!
    
    init(navigationController: UINavigationController, networkService: NetworkServiceProtocol) {
        self.navigationController = navigationController
        self.networkService = networkService
        self.moviesRepository = MoviesRepository(networkService: networkService)
    }
    
    func setScreen(window: UIWindow?) {
        let tabController = TabController(router: self)
        navigationController.pushViewController(tabController, animated: true)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func popBack() {
        navigationController.popViewController(animated: true)
    }
    
    func showTabController() {
        var tabController: UIViewController?
        if let viewControllers = navigationController?.viewControllers {
            for controller in viewControllers {
                if controller is TabController {
                    tabController = controller
                    break
                }
            }
        }
        if let tabController = tabController {
            navigationController.popToViewController(tabController, animated: true)
        } else {
            navigationController.setViewControllers([TabController(router: self)], animated: true)
        }

    }
    
    func showMovieDetailsController(movieId: Int) {
        navigationController.pushViewController(MovieDetailsController(router: self, movieId: movieId), animated: true)
    }
    
    func getMoviesRepository() -> MoviesRepository {
        return moviesRepository
    }
}
