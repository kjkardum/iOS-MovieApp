//
// Created by Karlo Josip Kardum on 27.03.2022..
//

import Foundation
import UIKit
import SFSafeSymbols
import SnapKit
import SwiftUI

class InitialViewController: UIViewController, UIScrollViewDelegate {
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let textContainer = UIView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @objc func likeMovie(e: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        
        let demoInfoText = UILabel()
        imageView.image = UIImage(named: "DemoCover.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        demoInfoText.textColor = .white
        demoInfoText.numberOfLines = 0
        let text =  """
                    Lorem ipsum dolor sit amet, in alia adhuc aperiri nam. Movet scripta tractatos cu eum, sale commodo meliore ea eam, per commodo atomorum ea. Unum graeci iriure nec an, ea sit habeo movet electram. Id eius assum persius pro, id cum falli accusam. Has eu fierent partiendo, doming expetenda interesset cu mel, tempor possit vocent in nam. Iusto tollit ad duo, est at vidit vivendo liberavisse, vide munere nonumy sed ex.
                            
                    Quod possit expetendis id qui, consequat vituperata ad eam. Per cu elit latine vivendum. Ei sit nullam aliquam, an ferri epicuri quo. Ex vim tibique accumsan erroribus. In per libris verear adipiscing. Purto aliquid lobortis ea quo, ea utinam oportere qui.
                    """
        demoInfoText.text = text + text + text
        
        let imageContainer = UIView()
        imageContainer.backgroundColor = .darkGray
        
        textContainer.backgroundColor = .clear
        
        let textBacking = UIView()
        textBacking.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(imageContainer)
        scrollView.addSubview(textBacking)
        scrollView.addSubview(textContainer)
        scrollView.addSubview(imageView)
        
        textContainer.addSubview(demoInfoText)
        
        let button = UIButton.systemButton(with: .cCircle, target: self, action: #selector(likeMovie))
        button.setImage(UIImage(systemSymbol: .star), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        
        let movieType = UILabel()
        movieType.text = "Action, Science Fiction, Adventure"
        movieType.textColor = .white
        movieType.font = UIFont.systemFont(ofSize: 12)
        
        let movieLength = UILabel()
        movieLength.text = "2h 6m"
        movieLength.textColor = .white
        movieLength.font = UIFont.boldSystemFont(ofSize: 12)
        
        let movieRelease = UILabel()
        movieRelease.text = "05/02/2008 (US)"
        movieRelease.textColor = .white
        movieRelease.font = UIFont.systemFont(ofSize: 12)
        
        let movieTitle = UILabel()
        movieTitle.text = "Iron man (2008)"
        movieTitle.textColor = .white
        movieTitle.font = UIFont.systemFont(ofSize: 24)
        
        let movieUserScoreValue = UILabel()
        movieUserScoreValue.text = "76%"
        movieUserScoreValue.textColor = .white
        let movieUserScore = UILabel()
        movieUserScore.text = "User Score"
        movieUserScore.textColor = .white;
        imageView.addSubview(button)
        imageView.addSubview(movieType)
        imageView.addSubview(movieLength)
        imageView.addSubview(movieRelease)
        imageView.addSubview(movieTitle)
        imageView.addSubview(movieUserScoreValue)
        imageView.addSubview(movieUserScore)
        scrollView.snp.makeConstraints {
            make in
            
            make.edges.equalTo(view)
        }
        
        imageContainer.snp.makeConstraints {
            make in
            
            make.top.equalTo(scrollView)
            make.left.right.equalTo(view)
            make.height.equalTo(imageContainer.snp.width).multipliedBy(0.9)
        }
        
        imageView.snp.makeConstraints {
            make in
            
            make.left.right.equalTo(imageContainer)

            //** Note the priorities
            make.top.equalTo(view).priority(.high)
            
            //** We add a height constraint too
            make.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
            
            //** And keep the bottom constraint
            make.bottom.equalTo(imageContainer.snp.bottom)
        }
    
        textContainer.snp.makeConstraints {
            make in
            
            make.top.equalTo(imageContainer.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(scrollView)
        }
        
        textBacking.snp.makeConstraints {
            make in
            
            make.left.right.equalTo(view)
            make.top.equalTo(textContainer)
            make.bottom.equalTo(view)
        }
        
        demoInfoText.snp.makeConstraints {
            make in
            
            make.edges.equalTo(textContainer).inset(14)
        }
        button.snp.makeConstraints{
            make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.left.equalTo(imageView.snp.left).offset(24)
            make.bottom.equalTo(imageView.snp.bottom).offset(-24)
        }
        
        movieType.snp.makeConstraints{
            make in
            make.bottom.equalTo(button.snp.top).offset(-24)
            make.left.equalTo(button.snp.left)
        }
        movieLength.snp.makeConstraints{
            make in
            make.bottom.equalTo(movieType.snp.bottom)
            make.left.equalTo(movieType.snp.right).offset(5)
        }
        movieRelease.snp.makeConstraints{
            make in
            make.bottom.equalTo(movieType.snp.top).offset(-5)
            make.left.equalTo(movieType.snp.left)
        }
        movieTitle.snp.makeConstraints {
            make in
            make.bottom.equalTo(movieRelease.snp.top).offset(-10)
            make.left.equalTo(movieRelease.snp.left)
        }
        movieUserScoreValue.snp.makeConstraints {
            make in
            make.bottom.equalTo(movieTitle.snp.top).offset(-8)
            make.left.equalTo(movieTitle.snp.left)
        }
        movieUserScore.snp.makeConstraints {
            make in
            make.bottom.equalTo(movieUserScoreValue.snp.bottom)
            make.left.equalTo(movieUserScoreValue.snp.right).offset(24)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    }
    
    //MARK: - Scroll View Delegate
    
    private var previousStatusBarHidden = false
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if previousStatusBarHidden != shouldHideStatusBar {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
            })
            
            previousStatusBarHidden = shouldHideStatusBar
        }
    }
    
    //MARK: - Status Bar Appearance
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    private var shouldHideStatusBar: Bool {
        let frame = textContainer.convert(textContainer.bounds, to: nil)
        return frame.minY < view.safeAreaInsets.top
    }
}
