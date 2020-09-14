//
//  NetworkService.swift
//  SocietyFund
//
//  Created by sanish on 9/1/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation
import UIKit

enum APIError: String, Error {
    case missingData = "Content couldn't be fully downloaded."
    case responseError = ""
    case serializeError = "Serialization Error."
    case informationalError = "Informational Error!"
    case redirectionError = "Redirection Error!"
    case noInternet = "No Internet Connection!"
    case serverError = "Something went wrong. Internal Server Error!"
    case badRequest = "Bad Request. Inputs Missing. Client Error!"
}

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

struct TestResponse: Codable {
    var message: String
}

class APIService {
    static let shared = APIService()
    let defaultSession = URLSession(configuration: .default)
    
    typealias CompletionHandler<T> = (Result<T, APIError>) -> Void
    
    func request<T: Codable>(_ url: String, method: HTTPMethod, params: Dictionary<String, Any>?,
                               completion: @escaping CompletionHandler<T>) {
        let request = clientURLRequest(url: url, method: method, params: params)
        
        defaultSession.dataTask(with: request) { (data, response, error) in

            if error == nil {
                if let response = response as? HTTPURLResponse {
                    print(response.statusCode)
                    switch response.statusCode {
                    case 100...199:
                        completion(.failure(.informationalError))
                        break
                    case 200...299:
                        do {
                            let jsonObj = try JSONDecoder().decode(T.self, from: data!)
                            completion(.success(jsonObj))
                        }catch {
                            print(error)
                        }
                        break
                    case 300...399:
                        completion(.failure(.redirectionError))
                        break
                    case 400...499:
                        completion(.failure(.badRequest))
                        break
                    case 500...599:
                        completion(.failure(.serverError))
                        break
                    default:
                        break
                    }
                }
            }else {
                completion(.failure(.noInternet))
            }

        }.resume()
    }
    
    func uploadRequest<T: Codable>(_ url: String, method: HTTPMethod, params: Dictionary<String, Any>?, data: Data?,
                               completion: @escaping CompletionHandler<T>) {
        let request = clientURLRequest(url: url, method: method, params: params)
        
        defaultSession.dataTask(with: request) { (data, response, error) in

            if error == nil {
                if let response = response as? HTTPURLResponse {
                    print(response.statusCode)
                    switch response.statusCode {
                    case 100...199:
                        completion(.failure(.informationalError))
                        break
                    case 200...299:
                        do {
                            let jsonObj = try JSONDecoder().decode(T.self, from: data!)
                            completion(.success(jsonObj))
                        }catch {
                            print(error)
                        }
                        break
                    case 300...399:
                        completion(.failure(.redirectionError))
                        break
                    case 400...499:
                        completion(.failure(.badRequest))
                        break
                    case 500...599:
                        completion(.failure(.serverError))
                        break
                    default:
                        break
                    }
                }
            }else {
                completion(.failure(.noInternet))
            }

        }.resume()
    }
    
    
    func clientURLRequest(url: String, method: HTTPMethod, params: Dictionary<String, Any>? = nil) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("$2b$10$soA2vqDDIcBJJG08wCJs9uiUD7eB2eMnpARVjrB0D4LX6yKdJq07q", forHTTPHeaderField: "secret-key")
        guard let params = params else { return request}
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed)
            Log.debug(msg: "DataFormat: \(data.base64EncodedString())")
            request.httpBody = data
        }catch {
            Log.debug(msg: "httpbodyErr: \(error.localizedDescription)")
        }
        return request
    }
    
}
