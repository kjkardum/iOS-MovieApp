//
//  FavoritesStackView.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 29.05.2022..
//

import Foundation
import UIKit

class FavoritesStackView: UIStackView {
    var baseSpacing: CGFloat = 5
    var movies: [Movie] = []
    
    convenience init() {
        self.init(frame: CGRect())
        
        axis = .vertical
        alignment = .fill
        distribution = .fillEqually
        spacing = baseSpacing
    }
    
    func updateData(movies: [Movie]) {
        self.movies = movies
        fillGrid()
    }
    
    func fillGrid(){
        for view in subviews{
            view.removeFromSuperview()
        }
        for row in 0 ..< Int(ceil(Double(movies.count) / 3.0)) {
            let horizontalSv = UIStackView()
            horizontalSv.axis = .horizontal
            horizontalSv.alignment = .fill
            horizontalSv.distribution = .fillEqually
            horizontalSv.spacing = baseSpacing

            for col in 0 ..< 3 {
                if (row * 3 + col + 1) > movies.count {
                    horizontalSv.addArrangedSubview(UIView())
                    continue
                }
                let movie = movies[row * 3 + col]
                let movieCell = FavoriteCell(movie: movie)
                horizontalSv.addArrangedSubview(movieCell)
            }
            addArrangedSubview(horizontalSv)
        }
    }
}
