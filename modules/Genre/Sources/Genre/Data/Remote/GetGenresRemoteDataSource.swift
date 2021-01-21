//
//  GetGenresRemoteDataSource.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetGenresRemoteDataSource : DataSource {
    public typealias Request = Any
    
    public typealias Response = [GenreResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Any?) -> AnyPublisher<[GenreResponse], Error> {
        return Future<[GenreResponse], Error> { completion in
            if let url = URL(string: _endpoint) {
                var urlRequest = URLRequest(url: url)
                urlRequest.timeoutInterval = 300
                AF.request(urlRequest)
                    .validate()
                    .responseDecodable(of: GenresResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.genres))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
