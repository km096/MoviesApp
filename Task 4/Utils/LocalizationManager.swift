//
//  LocalizationManager.swift
//  Task 4
//
//  Created by ME-MAC on 12/28/22.
//

import UIKit
import MOLH

class LocalizationManager{
    
    static let sharedInstance = LocalizationManager()
    private init() {}
    
    func getCurrentLang() -> String {
        return MOLHLanguage.currentAppleLanguage()
    }
    
    
    func switchLanguage(viewController : UIViewController){
        MOLH.setLanguageTo(getCurrentLang() == "en" ? "ar" : "en")
        MOLH.reset()
    }
    
}

extension String {
    var  localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
