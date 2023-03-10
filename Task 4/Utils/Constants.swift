//
//  Constants.swift
//  Task 4
//
//  Created by ME-MAC on 12/20/22.
//
import Foundation
import Alamofire

struct Api {
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    static let baseParameters: Parameters = ["api_key": "32c6fcb48eb9f8aba840a7e9dbe4188c"]    

}

struct EndPoint {
    static let popular = "movie/popular"
    static let upcoming = "movie/upcoming"
    static let nowPlaying = "movie/now_playing"
    
    static let person = "person/popular"

}
