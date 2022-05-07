//
//  DetailedMovieNetworkModel.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation

struct DetailedMovieNetworkModel: Codable {
    let id: Int
    let imdb_id: String
    let backdrop_path: String
    let belongs_to_collection: MovieCollectionNetworkModel?
    let budget: Double
    let genres: [SingleMovieGenreNetworkModel]
    let homepage: String
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let production_companies: [MovieProductionCompanyNetworkModel]
    let production_countries: [CountryNetworkModel]
    let release_date: String
    let revenue: Int
    let runtime: Double
    let spoken_languages: [LanguageNetworkModel]
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}
