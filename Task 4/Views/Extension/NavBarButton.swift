//
//  NavBarButton.swift
//  Task 4
//
//  Created by ME-MAC on 12/21/22.
//

import UIKit

extension UINavigationItem {
    
    func customNavBar(btntitle: String, title: String) {
        self.rightBarButtonItem = UIBarButtonItem(title: btntitle, style: .plain, target: self, action: #selector(changeLanguage))
        self.rightBarButtonItem?.tintColor = .black
        self.title = title.localized
    }
    
    @objc func changeLanguage (sender: UIBarButtonItem) {
        let currentLang = Locale.current.language.languageCode?.identifier
        let newlanguage = currentLang == "en" ? "ar" : "en"
        UserDefaults.standard.set([newlanguage], forKey: "AppleLanguages")
        exit(0)
        
    }
    
    func showAlertView() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "", style: .default))
    }
    

}
