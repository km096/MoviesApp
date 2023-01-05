//
//  MovieListSegment.swift
//  Task 4
//
//  Created by ME-MAC on 12/24/22.
//

import UIKit

extension UISegmentedControl {

    // Set segmentedControl title
    func addTitle (titles: [String]) {
        for i in 0 ..< titles.count {
            self.setTitle(titles[i], forSegmentAt: i)
                
            }
        }
        


}
