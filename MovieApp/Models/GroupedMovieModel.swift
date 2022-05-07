//
//  GroupedMovieModel.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 05.05.2022..
//

import Foundation

struct GroupedMovieModel {
    let groupId: Int
    let groupName: String
    let movies: [SimpleMovieNetworkModel]
}
