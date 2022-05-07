//
//  PaginatedNetworkModel.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation

struct PaginatedNetworkModel<T: Codable>: Codable {
    let page: Int
    let total_pages: Int
    let total_results: Int
    let results: [T]
}
