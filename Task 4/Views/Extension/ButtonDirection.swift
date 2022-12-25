//
//  ButtonDirection.swift
//  Task 4
//
//  Created by ME-MAC on 12/25/22.
//

import UIKit
extension UIButton {
    func changeDirection() {
        let currentLang = Locale.current.language.languageCode?.identifier
        if currentLang == "en" {
            self.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        } else {
            self.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        }
    }
}
