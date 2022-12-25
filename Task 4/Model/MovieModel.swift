//
//  MovieModel.swift
//  Task 4
//
//  Created by ME-MAC on 12/19/22.
//

import Foundation
//import UIKit

// MARK: - Response
struct Response: Decodable {
    let page: Int?
    let results: [Movies]?
}

// MARK: - Result
struct Movies: Decodable {
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let voteAverage: Double?
    let voteCount: Int?
}

