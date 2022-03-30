//
// Created by Karlo Josip Kardum on 27.03.2022..
//

import Foundation
import UIKit
import SFSafeSymbols
import SnapKit

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
        /* Find correct font name
         for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
         }
         */
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        
        imageView.image = UIImage(named: "DemoCover.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let detailsOverviewTitle = UILabel(text: "Overview", fontFamily: "Proxima Nova", fontStyle: .headline, bold: true, color: .black)
        
        let detailsOverviewContent = UILabel(text: "After being held captive in an Afghan cave, billionare engineer Tony Stark creates a unique weaponized suit of armor to fight evil.", fontFamily: "Proxima Nova", fontStyle: .footnote, numberOfLines: 0, color: .black)
        
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
            personName.font = UIFont.custom(name: "Proxima Nova", style: .footnote)?.bold()
            personName.text = person.name
            personName.textColor = .black
            let personRole = person.roleComponent
            personRole.font = UIFont.custom(name: "Proxima Nova", style: .footnote)
            personRole.text = person.role
            personRole.textColor = .black
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
        
        let movieType = UILabel(text: "Action, Science Fiction, Adventure", color: .white)
        let movieLength = UILabel(text: "2h 6m", color: .white)
        let movieRelease = UILabel(text: "05/02/2008 (US)", color: .white)
        let movieTitle = UILabel(text: "Iron man (2008)", fontStyle: .title2, color: .white)
        let movieUserScoreValue = UILabel(text: "76%", fontStyle: .title2, color: .systemPink)
        let movieUserScore = UILabel(text: "User Score", fontStyle: .title2, color: .white)
        
        imageView.addSubview(movieLikeButton)
        imageView.addSubview(movieType)
        imageView.addSubview(movieLength)
        imageView.addSubview(movieRelease)
        imageView.addSubview(movieTitle)
        imageView.addSubview(movieUserScoreValue)
        imageView.addSubview(movieUserScore)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view)
            $0.bottom.equalTo(textContainer.snp.bottom)
        }
        
        imageContainer.snp.makeConstraints {
            $0.top.equalTo(scrollView)
            $0.left.right.equalTo(view)
            $0.height.equalTo(imageContainer.snp.width).multipliedBy(0.9)
        }
        
        imageView.snp.makeConstraints {
            $0.left.right.equalTo(imageContainer)
            
            $0.top.equalTo(view).priority(.high)
            $0.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
            $0.bottom.equalTo(imageContainer.snp.bottom)
        }
    
        textContainer.snp.makeConstraints {
            $0.top.equalTo(imageContainer.snp.bottom)
            $0.left.right.equalTo(view)
            $0.bottom.equalTo(peopleWorkingOnMovie[3].roleComponent.snp.bottom).offset(390)
        }
        
        textBacking.snp.makeConstraints {
            $0.left.right.equalTo(view)
            $0.top.equalTo(textContainer)
            $0.bottom.equalTo(view)
        }
        
        movieLikeButton.snp.makeConstraints{
            $0.size.equalTo(CGSize(width: 40, height: 40))
            $0.left.equalTo(imageView.snp.left).offset(24)
            $0.bottom.equalTo(imageView.snp.bottom).offset(-24)
        }
        
        movieType.snp.makeConstraints{
            $0.bottom.equalTo(movieLikeButton.snp.top).offset(-24)
            $0.left.equalTo(movieLikeButton.snp.left)
        }
        movieLength.snp.makeConstraints{
            $0.bottom.equalTo(movieType.snp.bottom)
            $0.left.equalTo(movieType.snp.right).offset(5)
        }
        movieRelease.snp.makeConstraints{
            $0.bottom.equalTo(movieType.snp.top).offset(-5)
            $0.left.equalTo(movieType.snp.left)
        }
        movieTitle.snp.makeConstraints {
            $0.bottom.equalTo(movieRelease.snp.top).offset(-10)
            $0.left.equalTo(movieRelease.snp.left)
        }
        movieUserScoreValue.snp.makeConstraints {
            $0.bottom.equalTo(movieTitle.snp.top).offset(-8)
            $0.left.equalTo(movieTitle.snp.left)
        }
        movieUserScore.snp.makeConstraints {
            $0.bottom.equalTo(movieUserScoreValue.snp.bottom)
            $0.left.equalTo(movieUserScoreValue.snp.right).offset(24)
        }
        detailsOverviewTitle.snp.makeConstraints{
            $0.top.equalTo(textContainer.snp.top).offset(24)
            $0.left.equalTo(textContainer.snp.left).offset(24)
        }
        detailsOverviewContent.snp.makeConstraints{
            $0.top.equalTo(detailsOverviewTitle.snp.bottom).offset(24)
            $0.left.equalTo(detailsOverviewTitle.snp.left)
            $0.right.equalTo(textContainer.snp.right).offset(-24)
        }
        peopleWorkingOnMovie[0].nameComponent.snp.makeConstraints{
            $0.top.equalTo(detailsOverviewContent.snp.bottom).offset(24)
            $0.left.equalTo(detailsOverviewContent.snp.left)
            $0.width.equalTo(view.snp.width).dividedBy(3).offset(-20)
        }
        peopleWorkingOnMovie[3].nameComponent.snp.makeConstraints{
            $0.top.equalTo(peopleWorkingOnMovie[0].roleComponent.snp.bottom).offset(10)
            $0.left.equalTo(peopleWorkingOnMovie[0].roleComponent.snp.left)
            $0.width.equalTo(view.snp.width).dividedBy(3).offset(-20)
        }
        for (index, person) in peopleWorkingOnMovie.enumerated() {
            person.roleComponent.snp.makeConstraints{
                $0.top.equalTo(person.nameComponent.snp.bottom).offset(5)
                $0.left.equalTo(person.nameComponent.snp.left)
            }
            if (index != 0 && index != 3) {
                person.nameComponent.snp.makeConstraints{
                    $0.top.equalTo(peopleWorkingOnMovie[index-1].nameComponent.snp.top)
                    $0.left.equalTo(peopleWorkingOnMovie[index-1].nameComponent.snp.right).offset(10)
                    $0.width.equalTo(view.snp.width).dividedBy(3).offset(-20)
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
