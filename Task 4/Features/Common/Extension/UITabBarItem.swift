//
//  UITabBarItem.swift
//  Task 4
//
//  Created by ME-MAC on 12/23/22.
//

import UIKit

extension UITabBarItem {
    
    // MARK: - Set tabBar image and title 
    func customizeTabBar(title: String!, image: UIImage!, selectedImage: UIImage!) {
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
    }
}
