//
//  CircularToggleButton.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 01.05.2022..
//

import Foundation
import UIKit
import SFSafeSymbols

class CircularToggleButton: UIButton {
    let unselectedIcon: SFSymbol;
    let selectedIcon: SFSymbol;
    let action: (Bool) -> Void;
    let iconSize: CGFloat;
    var checked = false;
    init(unselectedIcon: SFSymbol, selectedIcon: SFSymbol, backgroundColor: UIColor = .gray, color: UIColor = .white, iconSize: CGFloat = 12, action: @escaping (Bool) -> Void) {
        self.unselectedIcon = unselectedIcon
        self.selectedIcon = selectedIcon
        self.action = action
        self.iconSize = iconSize
        super.init(frame: .zero)
        addTarget(self, action: #selector(click), for: .touchUpInside)
        self.backgroundColor = backgroundColor
        self.tintColor = color
        setUnselectedIcon()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.size.height / 2.0
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelectedIcon() {
        setImage(
            UIImage(
                systemSymbol: selectedIcon,
                withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: self.iconSize))
            ),
            for: .normal)
    }
    func setUnselectedIcon() {
        setImage(
            UIImage(
                systemSymbol: unselectedIcon,
                withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: self.iconSize))
            ),
            for: .normal)
    }
    
    func setState(selected: Bool) {
        if (selected) {
            setSelectedIcon()
        } else {
            setUnselectedIcon()
        }
        checked = selected
    }
    
    @objc func click() {
        let newCheck = !checked
        setState(selected: newCheck)
        action(newCheck)
    }
}
