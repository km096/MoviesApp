//
//  UITabBarControllerExt.swift
//  Task 4
//
//  Created by ME-MAC on 2/13/23.
//

import UIKit

extension UIViewController {
    
    func instantiateVC<T: UIViewController>(appStoryboard: AppStoryboard, vc: T.Type) -> T {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: vc.self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
