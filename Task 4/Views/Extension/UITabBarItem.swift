//
//  UITabBarItem.swift
//  Task 4
//
//  Created by ME-MAC on 12/23/22.
//

import Foundation
import UIKit

extension UITabBarItem {
    
    func customizeTabBar(title: String!, image: UIImage!, selectedImage: UIImage!) {
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
    }
}
