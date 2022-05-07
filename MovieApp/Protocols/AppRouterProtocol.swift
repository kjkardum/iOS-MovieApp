//
//  AppRouterProtocol.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation
import UIKit

protocol AppRouterProtocol {
    func setScreen(window: UIWindow?)
    
    func popToRoot()
    func popBack()
    
    func showTabController()
    func showMovieDetailsController(movieId: Int)
    
    func getMoviesRepository() -> MoviesRepository
}
