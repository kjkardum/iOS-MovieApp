//
//  SearchBoxDelegate.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 16.04.2022..
//

import Foundation
protocol SearchBoxDelegate: AnyObject {
    func onSearchBoxFocus()
    func onSearchBoxUnfocus()
    func onSearchBoxChange(input: String)
}
