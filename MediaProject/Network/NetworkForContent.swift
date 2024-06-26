//
//  Network.swift
//  MediaProject
//
//  Created by 최대성 on 6/26/24.
//

import Foundation
import Alamofire

class NetworkContent {
    
    static var shared = NetworkContent()
    
    private init() {}
    
    typealias CompletionHandler = ([MovieResults]?, String?) -> Void
    typealias CompletionHandlerPoster = ([FilePath]?, String?) -> Void
    
    func callMovie(api: TMDBManager, completionHandler: @escaping CompletionHandler) {
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString))
            .responseDecodable(of: Similar.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value.results, nil)
                case .failure(let error):
                    print(error)
                    completionHandler(nil, "다시 시도")
                }
            }
    }
    
    func callPoster(api: TMDBManager, completionHandler: @escaping CompletionHandlerPoster) {
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString))
            .responseDecodable(of: Poster.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value.posters, nil)
                case .failure(let error):
                    print(error)
                    completionHandler(nil, "다시 시도")
                }
            }
    }
    
    
}
