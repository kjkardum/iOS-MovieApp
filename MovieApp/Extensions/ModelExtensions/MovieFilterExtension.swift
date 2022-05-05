//
//  MovieFilterExtension.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 30.04.2022..
//

import Foundation
import MovieAppData

extension MovieFilter {
    var stringValue: String {
        switch self {
        case .streaming:
            return "Streaming"
        case .onTv:
            return "On TV"
        case .forRent:
            return "For Rent"
        case .inTheaters:
            return "In Theaters"
        case .thriller:
            return "Thriller"
        case .horror:
            return "Horror"
        case .comedy:
            return "Comedy"
        case .romanticComedy:
            return "Romantic Comedy"
        case .sport:
            return "Sport"
        case .action:
            return "Action"
        case .sciFi:
            return "Sci-Fi"
        case .war:
            return "War"
        case .drama:
            return "Drama"
        case .day:
            return "Day"
        case .week:
            return "Week"
        case .month:
            return "Month"
        case .allTime:
            return "All Time"
        }
    }
}
