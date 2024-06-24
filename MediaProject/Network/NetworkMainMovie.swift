//
//  Network.swift
//  MediaProject
//
//  Created by 최대성 on 6/24/24.
//

import Foundation
import Alamofire

class Network {
    
    static var shared = Network()
    
    private init() {}
    
    func callCreditRequest(id: Int, completionHanler: @escaping (Result<MovieInfo, Error>) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits?language=en-US&api_key=\(APIKey.movieKey)"
        AF.request(url, method: .get)
            .responseDecodable(of: MovieInfo.self) { response in
                switch response.result {
                case .success(let value):
                    completionHanler(.success(value))
                case .failure(let error):
                    completionHanler(.failure(error))
                }
            }
        
    }
}
