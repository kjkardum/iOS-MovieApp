//
//  FilterButton.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 16.04.2022..
//

import Foundation
import UIKit

class FilterButton: UIButton {
    var filterValue: Int
    
    required init(group: GroupedMovieModel) {
        // set myValue before super.init is called
        self.filterValue = group.groupId

        super.init(frame: .zero)
        
        setTitle(group.groupName, for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
