//
//  MovieModel.swift
//  Task 4
//
//  Created by ME-MAC on 12/19/22.
//

import Foundation

// MARK: - Response
struct MoviesResponse: Codable {
    let page: Int?
    let results: [Movie]?
}

// MARK: - Result
struct Movie: Codable {
    let id: Int?
    let overview: String?
    let posterPath, releaseDate, title: String?
    let voteAverage: Double?
    
    init(id: Int?, overview: String?, posterPath: String?, releaseDate: String?, title: String?, voteAverage: Double?) {
        self.id = id
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
    }
}

