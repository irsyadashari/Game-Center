//
//  GetGameRemoteDataSource.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetGameRemoteDataSource : DataSource {
    
    public typealias Request = String
    
    public typealias Response = GameResponse
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        
        return Future<GameResponse, Error> { completion in
            
            guard let request = request else { return completion(.failure(URLError.invalidRequest) )}
            if let url = URL(string: _endpoint + request) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                            case .success(let value):
                                completion(.success(value.games[0]))
                            case .failure:
                                completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
