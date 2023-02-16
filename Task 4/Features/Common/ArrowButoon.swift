//
//  stackViewDirection.swift
//  Task 4
//
//  Created by ME-MAC on 12/27/22.
//

import UIKit
import MOLH

class ArrowButoon: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Change button image when change language
        if LocalizationManager.sharedInstance.getCurrentLang() == "ar" {
                self.setImage(UIImage(systemName: "chevron.left"), for: .normal)
            }
    }
}
