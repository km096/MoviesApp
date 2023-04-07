//
//  BaseAPI.swift
//  Task 4
//
//  Created by ME-MAC on 4/3/23.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {
    
    func fetchData<M: Decodable>(target: T, pageNum: [String: Any],responseClass: M.Type, completion: @escaping (Result<M?, NSError>) -> Void) {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        var params = buildParams(task: target.task)
        
        params.0.merge(dict: pageNum)

        
        AF.request(target.baseURL + target.path, method: method, parameters: params.0 , encoding: params.1, headers: headers).responseDecodable(of: M.self) { response in
            
            print(target.baseURL + target.path)
            print(params.0)
            print(response.error)
            guard let statusCode = response.response?.statusCode else {
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.error])
                print(error)
                completion(.failure(error))
                return
            }
            
            if statusCode == 200 {
                
                switch response.result {
                case .success(_):
                    do {
                        guard let data = response.data else {
                            let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.error])
                            print(error.localizedDescription)
                            completion(.failure(error))
                            return
                        }
                        
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let responseObj = try decoder.decode(M.self, from: data)
                        completion(.success(responseObj))
                        
                    } catch {

                        let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.error])
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                case .failure(_):
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.error])
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            } else {
                //Add custom error based on status code 404 / 401
                // Error parsing for the error message from the BE
                let message = "Error message parsed from BE"
                let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: message])
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        
    }
    
    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding) {
        switch task {
            
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return(parameters, encoding)
        }
    }
    
}
