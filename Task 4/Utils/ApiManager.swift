//
//  ApiManager.swift
//  Task 4
//
//  Created by ME-MAC on 12/24/22.
//

import UIKit
import Alamofire

class ApiManager {
    
    static let sharedInstance = ApiManager()
    private init() {}

     func fetchApiData<T: Decodable>(url: String, parameters: Parameters , responseModel: T.Type, completion: @escaping (Result<T?, NSError>) -> Void ) {
        AF.request(url, method: .get, parameters: parameters, encoding:URLEncoding.default)
            .validate().responseData { response in
            switch response.result {
            case .success(_):
                guard let data = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let responseData = try decoder.decode(T.self, from: data)
                    completion(.success(responseData))
                } catch {
                    print(error)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

