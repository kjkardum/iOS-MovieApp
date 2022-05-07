//
//  MovieProductionCompanyNetworkModel.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation
struct MovieProductionCompanyNetworkModel: Codable {
    let id: Int
    let logo_path: String?
    let name: String
    let origin_country: String
}
