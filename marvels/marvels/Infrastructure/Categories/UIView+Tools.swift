//
//  UIView+Tools.swift
//  marvels
//
//  Created by Aitor Pagán on 08/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyShadow(with color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
    }
    
    func applyRadius(with radius: CGFloat, border: CGFloat, color: UIColor) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = border
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
    }
}
