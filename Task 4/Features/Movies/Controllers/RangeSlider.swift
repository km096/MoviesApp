//
//  RangeSlider.swift
//  Task 4
//
//  Created by ME-MAC on 1/1/23.
//

import UIKit
import TTRangeSlider

protocol RateValueDelegate {
    func rateValueDidChange(minValue: Float, maxValue: Float)
}

class RangeSlider: UIViewController {

    @IBOutlet weak var rangeSlider: TTRangeSlider!
    
    var delegate: RateValueDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnApplyTapped(_ sender: UIButton) {
        delegate?.rateValueDidChange(minValue: rangeSlider.selectedMinimum, maxValue: rangeSlider.selectedMaximum)
        dismiss(animated: true)
    }
   

    
}
