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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
    
    func showMovieDetailsController(movieId: UUID) {
        navigationController.pushViewController(MovieDetailsController(router: self, movieId: movieId), animated: true)
    }
}
