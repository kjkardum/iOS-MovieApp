//
//  MovieCollectionNetworkModel.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation

struct MovieCollectionNetworkModel: Codable {
    let id: Int
    let name: String
    let poster_path: String?
    let backdrop_path: String?
}
