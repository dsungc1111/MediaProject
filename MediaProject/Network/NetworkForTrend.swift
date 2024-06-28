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
    
    func trending<T: Decodable>(api: TMDBManager, model:T.Type ,completionHandler: @escaping (T?, GetError?) -> Void ) {
       
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString)).validate(statusCode: 200..<500) .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, .failedRequest)
            }
        }
    }
}
