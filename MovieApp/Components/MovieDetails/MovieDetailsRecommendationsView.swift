//
//  MovieDetailsRecommendationsView.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 10.04.2022..
//

import Foundation
import UIKit

class MovieDetailsRecommendationsView: UIView {
    init() {
        super.init(frame: CGRect())
        
        buildView()
        setViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        backgroundColor = .white
    }
    
    func setViewLayout() {
        
    }
    
}
