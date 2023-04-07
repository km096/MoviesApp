//
//  Networking.swift
//  Task 4
//
//  Created by ME-MAC on 4/3/23.
//

import Foundation
import Alamofire

enum Networking {
    case getPopularMovies
    case getUpcomingMovies
    case getNowPlayingMovies
    case getActors
}


extension Networking: TargetType {
    
    var baseURL: String {
        switch self {
            
        default:
            return "https://api.themoviedb.org/3"
        }
    }
    
    var baseImageURL: String {
        switch self {
            
        default:
            return "https://image.tmdb.org/t/p/w500"
        }
    }
    
    var path: String {
        switch self {

        case .getPopularMovies:
            return "/movie/popular"
        case .getUpcomingMovies:
            return "/movie/upcoming"
        case .getNowPlayingMovies:
            return "/movie/now_playing"
        case .getActors:
            return "/person/popular"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
            
        default:
            return .requestParameters(parameters: ["api_key": "32c6fcb48eb9f8aba840a7e9dbe4188c", "language": LocalizationManager.sharedInstance.getCurrentLang()], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
            
        default:
            return [:]
        }
    }
    
    
}
