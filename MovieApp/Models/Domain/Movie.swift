//
//  Movie.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 29.05.2022..
//

import Foundation

struct Movie {
    public var tmdbId: Int64
    public var adult: Bool
    public var backdrop_path: String?
    public var original_language: String
    public var original_title: String
    public var overview: String
    public var popularity: Double
    public var poster_path: Data?
    public var release_date: String?
    public var title: String
    public var video: Bool
    public var vote_average: Double
    public var vote_count: Int64
    public var genres: [Genre]
    public var groups: [Group]
    public var liked: Bool
}
