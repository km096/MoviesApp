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
}
