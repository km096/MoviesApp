//
//  RoundedUIButton.swift
//  MovieApp
//
//  Created by ME-MAC on 5/16/23.
//

import UIKit

class RoundedUIButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBtn()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBtn()
    }
    
    func setupBtn() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

}
