//
//  FilterButton.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 16.04.2022..
//

import Foundation
import UIKit
import MovieAppData

class FilterButton: UIButton {
    var filterValue: MovieFilter
    
    required init(value: MovieFilter) {
        // set myValue before super.init is called
        self.filterValue = value

        super.init(frame: .zero)
        
        setTitle(value.stringValue, for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
