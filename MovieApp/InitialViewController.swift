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
        
        imageView.image = UIImage(named: "DemoCover.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        
        let detailsOverviewTitle = UILabel()
        detailsOverviewTitle.font = UIFont.boldSystemFont(ofSize: 24)
        detailsOverviewTitle.text = "Overview"
        
        let detailsOverviewContent = UILabel()
        detailsOverviewContent.font = UIFont.systemFont(ofSize: 12)
        detailsOverviewContent.text = "After being held captive in an Afghan cave, billionare engineer Tony Stark creates a unique weaponized suit of armor to fight evil."
        detailsOverviewContent.numberOfLines = 0
        
        let imageContainer = UIView()
        imageContainer.backgroundColor = .darkGray
        
        textContainer.backgroundColor = .clear
        
        let textBacking = UIView()
        textBacking.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(imageContainer)
        scrollView.addSubview(textBacking)
        scrollView.addSubview(textContainer)
        scrollView.addSubview(imageView)
        
        textContainer.addSubview(detailsOverviewTitle)
        textContainer.addSubview(detailsOverviewContent)
        let peopleWorkingOnMovie = [
            (name: "Don Heck", role: "Characters", nameComponent: UILabel(), roleComponent: UILabel()),
            (name: "Jack Kirby", role: "Characters", nameComponent: UILabel(), roleComponent: UILabel()),
            (name: "Jon Favreau", role: "Director", nameComponent: UILabel(), roleComponent: UILabel()),
            (name: "Don Heck", role: "Screenplay", nameComponent: UILabel(), roleComponent: UILabel()),
            (name: "Jack Marcum", role: "Screenplay", nameComponent: UILabel(), roleComponent: UILabel()),
            (name: "Matt Holloway", role: "Screenplay", nameComponent: UILabel(), roleComponent: UILabel())
        ]
        for person in peopleWorkingOnMovie {
            let personName = person.nameComponent
            personName.font = UIFont.boldSystemFont(ofSize: 12)
            personName.text = person.name
            let personRole = person.roleComponent
            personRole.font = UIFont.systemFont(ofSize: 12)
            personRole.text = person.role
            textContainer.addSubview(personName)
            textContainer.addSubview(personRole)
        }
        
        let movieLikeButton = UIButton.systemButton(with: .cCircle, target: self, action: #selector(likeMovie))
        movieLikeButton.setImage(
            UIImage(
                systemSymbol: .star,
                withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 12))
            ),
            for: .normal)
        movieLikeButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        movieLikeButton.tintColor = .white
        movieLikeButton.layer.cornerRadius = 20
        
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
        imageView.addSubview(movieLikeButton)
        imageView.addSubview(movieType)
        imageView.addSubview(movieLength)
        imageView.addSubview(movieRelease)
        imageView.addSubview(movieTitle)
        imageView.addSubview(movieUserScoreValue)
        imageView.addSubview(movieUserScore)
        scrollView.snp.makeConstraints {
            make in
            
            make.edges.equalTo(view)
            make.bottom.equalTo(textContainer.snp.bottom)
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
            make.bottom.equalTo(peopleWorkingOnMovie[3].roleComponent.snp.bottom).offset(90)
        }
        
        textBacking.snp.makeConstraints {
            make in
            make.left.right.equalTo(view)
            make.top.equalTo(textContainer)
            make.bottom.equalTo(view)
        }
        
        movieLikeButton.snp.makeConstraints{
            make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.left.equalTo(imageView.snp.left).offset(24)
            make.bottom.equalTo(imageView.snp.bottom).offset(-24)
        }
        
        movieType.snp.makeConstraints{
            make in
            make.bottom.equalTo(movieLikeButton.snp.top).offset(-24)
            make.left.equalTo(movieLikeButton.snp.left)
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
        detailsOverviewTitle.snp.makeConstraints{
            make in
            make.top.equalTo(textContainer.snp.top).offset(24)
            make.left.equalTo(textContainer.snp.left).offset(24)
        }
        detailsOverviewContent.snp.makeConstraints{
            make in
            make.top.equalTo(detailsOverviewTitle.snp.bottom).offset(24)
            make.left.equalTo(detailsOverviewTitle.snp.left)
            make.right.equalTo(textContainer.snp.right).offset(-24)
        }
        peopleWorkingOnMovie[0].nameComponent.snp.makeConstraints{
            make in
            make.top.equalTo(detailsOverviewContent.snp.bottom).offset(24)
            make.left.equalTo(detailsOverviewContent.snp.left)
            make.width.equalTo(view.snp.width).dividedBy(3).offset(-20)
        }
        peopleWorkingOnMovie[3].nameComponent.snp.makeConstraints{
            make in
            make.top.equalTo(peopleWorkingOnMovie[0].roleComponent.snp.bottom).offset(10)
            make.left.equalTo(peopleWorkingOnMovie[0].roleComponent.snp.left)
            make.width.equalTo(view.snp.width).dividedBy(3).offset(-20)
        }
        for (index, person) in peopleWorkingOnMovie.enumerated() {
            person.roleComponent.snp.makeConstraints{
                make in
                make.top.equalTo(person.nameComponent.snp.bottom).offset(5)
                make.left.equalTo(person.nameComponent.snp.left)
            }
            if (index != 0 && index != 3) {
                person.nameComponent.snp.makeConstraints{
                    make in
                    make.top.equalTo(peopleWorkingOnMovie[index-1].nameComponent.snp.top)
                    make.left.equalTo(peopleWorkingOnMovie[index-1].nameComponent.snp.right).offset(10)
                    make.width.equalTo(view.snp.width).dividedBy(3).offset(-20)
                }
            }
        }
        /*demoText.snp.makeConstraints{
            make in
            make.top.equalTo(peopleWorkingOnMovie[3].nameComponent.snp.top).offset(10)
            make.left.equalTo(textContainer.snp.left)
            make.right.equalTo(textContainer.snp.right)
            make.bottom.equalTo(textContainer.snp.bottom).offset(-10)
        }*/
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
