//
//  gradientView.swift
//  Task 4
//
//  Created by ME-MAC on 12/19/22.
//

import UIKit

extension UIView {
     func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
         gradientLayer.colors = [UIColor.systemGray6.cgColor, UIColor.white.cgColor]
         gradientLayer.opacity = 0.7
        gradientLayer.cornerRadius = 20
        self.layer.addSublayer(gradientLayer)
    }
    
}
