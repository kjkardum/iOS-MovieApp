//
//  MovieGroupStringConverter.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 16.04.2022..
//

import Foundation
import MovieAppData

class MovieEnumsStringConverter{
    static func convert(_ group: MovieGroup) -> String {
        switch group {
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
    static func convert(_ filter: MovieFilter) -> String {
        switch filter {
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
    
    static func convert(_ genre: Genre) -> String {
        switch genre {
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
        }
    }
    
    static let genreFilterStrings = [Genre.action, Genre.comedy, Genre.drama, Genre.horror, Genre.romanticComedy, Genre.sciFi, Genre.sport, Genre.thriller, Genre.war]
        .map{i in MovieEnumsStringConverter.convert(i)}
}
