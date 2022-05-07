//
//  UINavigationControllerExtension.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation
import UIKit

extension UINavigationController {
    static func createAppNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.backgroundColor = .themeBlue
        navigationController.navigationBar.isTranslucent = true
        return navigationController
    }
}
