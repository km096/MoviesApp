//
//  MovieModel.swift
//  Task 4
//
//  Created by ME-MAC on 12/19/22.
//

import Foundation

// MARK: - Response
struct Response: Decodable {
    let page: Int?
    let results: [Movies]?
}

// MARK: - Result
struct Movies: Decodable {
    let id: Int?
//    let originalLanguage, originalTitle: String?
    let overview: String?
//    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let voteAverage: Double?
//    let voteCount: Int?
    
    init(id: Int?, overview: String?, posterPath: String?, releaseDate: String?, title: String?, voteAverage: Double?) {
        self.id = id
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
    }
}

