//
//  MovieFilterDelegate.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 16.04.2022..
//

import Foundation
import MovieAppData

protocol MovieFilterDelegate: AnyObject {
    func selectFilter(filter: Int, animationDuration: TimeInterval)
}
