//
//  MovieDetailsSocialView.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 10.04.2022..
//

import Foundation
import UIKit

class MovieDetailsSocialView : UIView {
    init() {
        super.init(frame: CGRect())
        
        buildView()
        setViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        backgroundColor = .yellow
    }
    
    func setViewLayout() {
        
    }
}

