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
    func addShadow(containerView: UIView, color : CGColor, shadowOpacity: Float, shadowRadius: Double, cornerRadius: CGFloat) {
        
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = color
        containerView.layer.shadowOpacity = shadowOpacity
        containerView.layer.shadowOffset = CGSize(width: 20, height: 0)
        containerView.layer.shadowRadius = shadowRadius
        containerView.backgroundColor = .clear
        containerView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath
        
        layer.cornerRadius = cornerRadius
        contentMode = .scaleAspectFill
    }
}

