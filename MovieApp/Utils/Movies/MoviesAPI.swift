//
//  MoviesAPI.swift
//  Task 4
//
//  Created by ME-MAC on 4/5/23.

//

import Foundation

protocol MoviesAPIProtocol {
    func getMovies(target: Networking, pageNum: [String : Any], completion: @escaping (Result<BaseResponse<[Movie]>?, NSError>) -> Void)
}

protocol ActorsAPIProtocol {
    func getActors(target: Networking, pageNum: [String : Any], completion: @escaping (Result<BaseResponse<[Person]>?, NSError>) -> Void)
}

class MoviesAPI: BaseAPI<Networking>, MoviesAPIProtocol, ActorsAPIProtocol {
    
    func getMovies(target: Networking, pageNum : [String : Any],completion: @escaping (Result<BaseResponse<[Movie]>?, NSError>) -> Void) {
        self.fetchData(target: target, pageNum: pageNum, responseClass: BaseResponse<[Movie]>.self) { result in
            completion(result)
        }
    }
    
    func getActors(target: Networking, pageNum : [String : Any],completion: @escaping (Result<BaseResponse<[Person]>?, NSError>) -> Void) {
        self.fetchData(target: target, pageNum: pageNum, responseClass: BaseResponse<[Person]>.self) { result in
            completion(result)
        }
    }
    
}
