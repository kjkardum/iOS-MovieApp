//
//  UIViewExtension.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 15.04.2022..
//

import Foundation
import UIKit
import SnapKit
class BorderView: UIView {
}

extension UIView {
    private func addSidedBorder(toEdge edge: UIRectEdge, withColor color: UIColor, inset: CGFloat, thickness: CGFloat) {
        let border = BorderView(frame: .zero)
        border.backgroundColor = color
        addSubview(border)

        border.snp.makeConstraints { make in
            switch edge {
            case .top:
                make.top.equalToSuperview()
                make.height.equalTo(thickness)
                make.left.right.equalToSuperview().inset(inset)

            case .left:
                make.left.equalToSuperview()
                make.width.equalTo(thickness)
                make.top.bottom.equalToSuperview().inset(inset)

            case .bottom:
                make.bottom.equalToSuperview()
                make.height.equalTo(thickness)
                make.left.right.equalToSuperview().inset(inset)

            case .right:
                make.right.equalToSuperview()
                make.width.equalTo(thickness)
                make.top.bottom.equalToSuperview().inset(inset)

            default:
                print("Invalid sided border given in ExtendedUIView, border not added correctly")
            }
        }
    }

    func addBorder(toEdge edge: UIRectEdge, withColor color: UIColor = .black, inset: CGFloat = 0.0, thickness: CGFloat = 1.0) {
        // Remove existing borders from view and readd them
        for view in subviews {
            if view is BorderView {
                view.removeFromSuperview()
            }
        }

        if edge.contains(.all) {
            addSidedBorder(toEdge: .top, withColor: color, inset: inset, thickness: thickness)
            addSidedBorder(toEdge: .left, withColor: color, inset: inset, thickness: thickness)
            addSidedBorder(toEdge: .bottom, withColor: color, inset: inset, thickness: thickness)
            addSidedBorder(toEdge: .right, withColor: color, inset: inset, thickness: thickness)
        } else {
            if edge.contains(.top) {
                addSidedBorder(toEdge: .top, withColor: color, inset: inset, thickness: thickness)
            }

            if edge.contains(.left) {
                addSidedBorder(toEdge: .left, withColor: color, inset: inset, thickness: thickness)
            }

            if edge.contains(.bottom) {
                addSidedBorder(toEdge: .bottom, withColor: color, inset: inset, thickness: thickness)
            }

            if edge.contains(.right) {
                addSidedBorder(toEdge: .right, withColor: color, inset: inset, thickness: thickness)
            }
        }
    }
    
    func dropShadow(scale: Bool = true) {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.1//0.2
            layer.shadowOffset = .zero
            layer.shadowRadius = 20//1
            layer.shouldRasterize = true
            layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        }
}
