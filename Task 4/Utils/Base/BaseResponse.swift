//
//  BaseResponse.swift
//  Task 4
//
//  Created by ME-MAC on 4/5/23.
//

import Foundation

class BaseResponse<T: Codable>: Codable {
    let page: Int?
    let results: T?
    
    enum codingKeys: String, CodingKey {        
        case page = "page"
        case results = "results"
    }
}
