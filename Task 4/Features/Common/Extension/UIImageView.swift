//
//  MoviePoster.swift
//  Task 4
//
//  Created by ME-MAC on 12/19/22.
//

import UIKit

extension UIImageView {
    // MARK: - Add round corner
    func roundCorner(cornerRadius : CGFloat) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
    
    // MARK: - Add shadow
    func addShadow(containerView: UIView, color : CGColor, shadowOpacity: Float, shadowRadius: Double, cornerRadius: CGFloat) {
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = color
        containerView.layer.shadowOpacity = shadowOpacity
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = shadowRadius
        containerView.backgroundColor = .clear
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadius).cgPath
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        contentMode = .scaleAspectFill
        
        
        
    }
}

