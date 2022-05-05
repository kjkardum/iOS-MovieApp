//
//  MovieGroupExtension.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 30.04.2022..
//

import Foundation
import MovieAppData

extension MovieGroup {
    var stringValue: String {
        switch self {
        case .popular:
            return "Popular"
        case .freeToWatch:
            return "Free to watch"
        case .trending:
            return "Trending"
        case .topRated:
            return "Top rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}
