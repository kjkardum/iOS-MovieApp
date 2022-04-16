//
//  SearchBarView.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 10.04.2022..
//

import Foundation
import UIKit
import SnapKit

class SearchBarView : UIView, UITextFieldDelegate {
    var searchIcon: UIImageView!
    var searchBox: UITextField!
    var clearButton: UIButton!
    var cancelButton: UIButton!
    
    init() {
        super.init(frame: CGRect())
        
        buildView()
        setViewLayout()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func buildView() {
        searchBox = UITextField()
        searchBox.placeholder = "Search"
        searchBox.backgroundColor = HexColorHelper.GetUIColor(hex: lightGrayColorCode)
        searchBox.layer.cornerRadius = 10
        searchBox.delegate = self
        
        searchIcon = UIImageView(image: UIImage(systemSymbol: .magnifyingglass))
        searchIcon.tintColor = .black
        let searchIconWrapper = UIView()
        searchIconWrapper.addSubview(searchIcon)
        
        searchBox.leftView = searchIconWrapper
        searchBox.leftViewMode = .always
        
        clearButton = UIButton.createIconButton(icon: .xmark, backgroundColor: UIColor(white: 1, alpha: 0), color: .black, iconSize: 10, target: self, action: #selector(clearSearchBox))
        let clearButtonWrapper = UIView()
        clearButtonWrapper.addSubview(clearButton)
        
        searchBox.rightView = clearButtonWrapper
        searchBox.rightViewMode = .whileEditing
        
        cancelButton = UIButton()
        cancelButton.addTarget(self, action: #selector(cancelSearchBox), for: .touchUpInside)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = StyledUILabel.getStyledFont(fontStyle: .subheadline)
        addSubview(searchBox)
        addSubview(cancelButton)
        
    }
    
    func changeCancelButtonVisibility(visible: Bool) {
        if visible {
            cancelButton.isHidden = false
            searchBox.snp.remakeConstraints{ make in
                make.left.top.bottom.equalToSuperview()
                make.right.equalTo(cancelButton.snp.left).offset(-10)
                make.height.equalTo(40)
            }
        } else {
            cancelButton.isHidden = true
            searchBox.snp.remakeConstraints{ make in
                make.left.top.bottom.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(40)
            }
        }
    }
    
    func setViewLayout() {
        changeCancelButtonVisibility(visible: false)
        searchIcon.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(10)
        }
        clearButton.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(10)
        }
        cancelButton.snp.makeConstraints{ make in
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(searchBox)
        }
    }
    
    @objc func clearSearchBox() {
        searchBox.text = ""
    }
    
    @objc func cancelSearchBox() {
        clearSearchBox()
        changeCancelButtonVisibility(visible: false)
        searchBox.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changeCancelButtonVisibility(visible: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        changeCancelButtonVisibility(visible: false)
    }
}
