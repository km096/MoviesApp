//
//  MoviePoster.swift
//  Task 4
//
//  Created by ME-MAC on 12/19/22.
//

import UIKit

extension UIImageView {
    
    // Add round corner
    func roundCorner(cornerRadius : CGFloat) {
        
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
    
    // Add shadow
    func addShadow(view: UIView, shadowOpacity: Float, shadowRadius: Double, cornerRadius: CGFloat) {
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = shadowRadius
        view.backgroundColor = .clear
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        
        layer.cornerRadius = cornerRadius
        contentMode = .scaleAspectFill
    }
}

