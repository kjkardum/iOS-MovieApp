//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation
import UIKit
import SnapKit

class FavoritesViewController: UIViewController {
    var router: AppRouterProtocol!

    init (router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        setViewLayout()
    }
    
    func buildView() {
        
        let titleImage =  UIImageView(image: UIImage(named: "HeaderLogo"))
        navigationController?.navigationBar.topItem?.titleView = titleImage
        
        view.addSubview(UIView())
        view.backgroundColor = .themeBlue
    }
    
    func setViewLayout() {
        
    }
}
