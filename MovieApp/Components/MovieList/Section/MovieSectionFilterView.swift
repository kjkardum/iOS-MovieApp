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

class MovieSectionFilterView : UIStackView {
    var mySpacing: CGFloat = 22
    var filters: [MovieFilter] = []
    var selectedFilter: FilterButton?
    var delegate: MovieFilterDelegate?
    
    convenience init() {
        self.init(frame: CGRect())
        
        axis = .horizontal
        alignment = .fill
        distribution = .equalSpacing
        translatesAutoresizingMaskIntoConstraints = false
        spacing = mySpacing
    }
    
    func setFilters(filters: [MovieFilter]) {
        self.filters = filters
        fillGrid()
    }
    
    func fillGrid(){
        arrangedSubviews.forEach{ item in
            item.removeFromSuperview()
        }
        for item in 0 ..< filters.count {
            let button = FilterButton(value: filters[item])
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = StyledUILabel.getStyledFont(fontStyle: .callout, bold: false)
            button.addTarget(self, action: #selector(selectFilter), for: .touchUpInside)
            addArrangedSubview(button)
            if item == 0 {
                selectFilter(button: button)
            }
        }
    }
    
    @objc func selectFilter(button: FilterButton) {
        if let selectedFilter = selectedFilter {
            selectedFilter.titleLabel?.font = StyledUILabel.getStyledFont(fontStyle: .callout, bold: false)
            selectedFilter.addBorder(toEdge: [])
        }
        button.titleLabel?.font = StyledUILabel.getStyledFont(fontStyle: .callout, bold: true)
        button.addBorder(toEdge: .bottom, withColor: HexColorHelper.GetUIColor(hex: blueColorCode) ?? .black, thickness: 3.0)
        selectedFilter = button
        
        delegate?.selectFilter(filter: button.filterValue)
    }
}
