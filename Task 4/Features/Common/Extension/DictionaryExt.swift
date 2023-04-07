//
//  DictionaryExt.swift
//  Task 4
//
//  Created by ME-MAC on 4/7/23.
//

import Foundation

extension Dictionary {
    mutating func merge(dict: [Key: Value]) {
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
        
    }
}
