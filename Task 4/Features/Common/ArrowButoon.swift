//
//  stackViewDirection.swift
//  Task 4
//
//  Created by ME-MAC on 12/27/22.
//

import UIKit

class ArrowButoon: UIButton {
    
    // MARK: - change button image when change language

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()        
            let currentLang = Locale.current.language.languageCode?.identifier
            if currentLang == "ar" {
                self.setImage(UIImage(systemName: "chevron.left"), for: .normal)
            }
        

    }


}
