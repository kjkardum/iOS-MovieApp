//
//  MovieNetworkModel.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation

struct SimpleMovieNetworkModel: Codable {
    let id: Int
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: [Int]
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String?
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}
