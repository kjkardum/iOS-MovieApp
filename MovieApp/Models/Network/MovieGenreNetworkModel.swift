//
//  MovieGenreDto.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation

struct MovieGenreNetworkModel: Codable {
    let genres: [SingleMovieGenreNetworkModel]
}

struct SingleMovieGenreNetworkModel: Codable {
    let id: Int
    let name: String
}
