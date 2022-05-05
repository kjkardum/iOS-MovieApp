//
//  MovieSectionFilterView.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 15.04.2022..
//

import Foundation
import UIKit
import SnapKit
import MovieAppData

class MovieSectionFilterView: UIStackView {
    var mySpacing: CGFloat = 22
    var filters: [MovieFilter] = []
    var selectedFilter: FilterButton?
    weak var delegate: MovieFilterDelegate?
    
    convenience init() {
        self.init(frame: CGRect())
        
        axis = .horizontal
        alignment = .fill
        distribution = .equalSpacing
        translatesAutoresizingMaskIntoConstraints = false
        spacing = mySpacing
    }
    
    func setFilters(filters: [MovieFilter], currentFilter: MovieFilter? = nil) {
        self.filters = filters
        fillGrid(currentFilter: currentFilter)
    }
    
    func fillGrid(currentFilter: MovieFilter? = nil){
        arrangedSubviews.forEach{ item in
            item.removeFromSuperview()
        }
        for item in 0 ..< filters.count {
            let button = FilterButton(value: filters[item])
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = StyledUILabel.getStyledFont(fontStyle: .callout, bold: false)
            button.addTarget(self, action: #selector(selectFilter), for: .touchUpInside)
            addArrangedSubview(button)
            if item == 0 && currentFilter == nil || filters[item] == currentFilter {
                selectFilter(button: button, onLoad: true)
            }
        }
    }
    
    @objc func selectFilter(button: FilterButton, onLoad: Bool = false) {
        if let selectedFilter = selectedFilter {
            selectedFilter.titleLabel?.font = StyledUILabel.getStyledFont(fontStyle: .callout, bold: false)
            selectedFilter.removeBorders()
        }
        button.titleLabel?.font = StyledUILabel.getStyledFont(fontStyle: .callout, bold: true)
        button.addBorder(toEdge: .bottom, withColor: .themeBlue, thickness: 3.0)
        selectedFilter = button
        
        if onLoad {
            delegate?.selectFilter(filter: button.filterValue, animationDuration: 0)
        } else {
            delegate?.selectFilter(filter: button.filterValue, animationDuration: 0.2)
        }
    }
}
