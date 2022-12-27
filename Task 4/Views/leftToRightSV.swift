//
//  stackViewDirection.swift
//  Task 4
//
//  Created by ME-MAC on 12/27/22.
//

import UIKit

class leftToRightSV: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.semanticContentAttribute = .forceLeftToRight

    }


}
