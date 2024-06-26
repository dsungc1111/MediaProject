//
//  Network.swift
//  MediaProject
//
//  Created by 최대성 on 6/24/24.
//

import Foundation
import Alamofire

class NetworkTrend {
    
    static var shared = NetworkTrend()
    
    private init() {}
   
    typealias CompletionHandler = ([Results]?, String?) -> Void
    typealias CompletionHandlerCredit = (MovieInfo? , String?) -> Void
    
    func callTrendMovie(api: TMDBManager, completionHandler: @escaping CompletionHandler) {
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString))
            .responseDecodable(of: Content.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value.results, nil)
                case .failure(let error):
                    print(error)
                    completionHandler(nil, "다시 시도")
                }
            }
    }
    
    func callCreditRequest(api: TMDBManager, completionHanler: @escaping CompletionHandlerCredit) {
        AF.request(api.endPoint, method: .get, parameters: api.parameter, encoding: URLEncoding(destination: .queryString))
            .responseDecodable(of: MovieInfo.self) { response in
                switch response.result {
                case .success(let value):
                    completionHanler(value, nil)
                case .failure(_):
                    completionHanler(nil, "다시시도")
                }
            }
        
    }
}
