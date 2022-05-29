//
//  MovieGroupEnum.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 28.05.2022..
//

import Foundation

@objc
enum MovieGroupEnum: Int64 {
    case unknown = 0
    case popular = 1
    case trendingDay = 2
    case trendingWeek = 3
    case topRated = 4
    case recommended = 5
}
