//
//  PeopleCVC.swift
//  Task 4
//
//  Created by ME-MAC on 12/25/22.
//

import UIKit

class PeopleCV: UICollectionViewCell {
    
    @IBOutlet weak var imgPersonPhoto: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var selectedIndex: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    
    
}
