//
//  MovieGenreExtension.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 30.04.2022..
//

import Foundation
import MovieAppData

extension Genre {
    var stringValue: String {
        switch self {
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
    
    private static let allValues: [Genre] = [
        .action,
        .comedy,
        .drama,
        .horror,
        .romanticComedy,
        .sciFi,
        .sport,
        .thriller,
        .war]
    static let allStringValues = allValues.map { $0.stringValue }

}
