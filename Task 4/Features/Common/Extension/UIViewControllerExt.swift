//
//  UIViewControllerExt.swift
//  Task 4
//
//  Created by ME-MAC on 2/14/23.
//

import UIKit

extension UIViewController {
    
    func presestVC(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = LocalizationManager.sharedInstance.getCurrentLang() == "en" ? .fromRight : .fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    
    func dismissVC() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = LocalizationManager.sharedInstance.getCurrentLang() == "en" ? .fromLeft : .fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
        
    }
    
    // Instantiate view controller and set the identifier as vc title
    func instantiateVC<T: UIViewController>(appStoryboard: AppStoryboard, vc: T.Type) -> T {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: vc.self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    // Set tabBar image and title 
    func configureTabBarItem(_ title: String, _ image: UIImage!, selectedImage: UIImage!) {
        self.tabBarItem.title = title
        self.tabBarItem.image = image
        self.tabBarItem.selectedImage = selectedImage
    }
}
