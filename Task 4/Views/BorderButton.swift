//
//  BorderButton.swift
//  Task 4
//
//  Created by ME-MAC on 12/24/22.
//

import UIKit

class BorderButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor
    }


}
