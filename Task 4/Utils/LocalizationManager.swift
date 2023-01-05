//
//  LocalizationManager.swift
//  Task 4
//
//  Created by ME-MAC on 12/28/22.
//

import UIKit

class LocalizationManager{
    
    static let sharedInstance = LocalizationManager()
    private init() {}
    
    func getCurrentLang() -> String? {
        return Locale.current.language.languageCode!.identifier
    }
    
    
    func switchLanguage(viewController : UIViewController){
        let newlanguage = getCurrentLang() == "en" ? "ar" : "en"
        let alert = UIAlertController(title: "changeLanguage".localized, message: "changeLangMsg".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok".localized, style: .default, handler: { action in
            UserDefaults.standard.set([newlanguage], forKey: "AppleLanguages")
            exit(0)
        }))
        alert.addAction(UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil))
        viewController.present(alert, animated: true)
    }
    
}

extension String {
    var  localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
