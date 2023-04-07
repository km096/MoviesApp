//
//  PeopleModel.swift
//  Task 4
//
//  Created by ME-MAC on 12/25/22.


import Foundation

// MARK: - People
struct People: Codable {
    let page: Int?
    let results: [Person]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages
        case totalResults
    }
}

// MARK: - Result
struct Person: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownFor: [KnownFor]?
    let knownForDepartment: String?
    let name: String?
    let popularity: Double?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownFor
        case knownForDepartment
        case name, popularity
        case profilePath
    }
}

// MARK: - KnownFor
struct KnownFor: Codable {
    let backdropPath, firstAirDate: String?
    let genreIDS: [Int]?
    let id: Int?
    let mediaType: String?
    let name: String?
    let originCountry: [String]?
    let originalLanguage: String?
    let originalName, overview, posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    let adult: Bool?
    let originalTitle, releaseDate, title: String?
    let video: Bool?

    enum CodingKeys: String, CodingKey {
        case backdropPath
        case firstAirDate
        case genreIDS
        case id
        case mediaType
        case name
        case originCountry
        case originalLanguage
        case originalName
        case overview
        case posterPath
        case voteAverage
        case voteCount
        case adult
        case originalTitle
        case releaseDate
        case title, video
    }
}

