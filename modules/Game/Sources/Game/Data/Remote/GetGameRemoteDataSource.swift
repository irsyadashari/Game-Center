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
            print("urlna game: \(_endpoint + request.lowercased())")
            if let url = URL(string: _endpoint + request) {
                var urlRequest = URLRequest(url: url)
                urlRequest.timeoutInterval = 300
                AF.request(urlRequest)
                    .validate()
                    .responseDecodable(of: GameResponse.self) { response in
//                        print("responna: \(response.value?.games[0])")
                        switch response.result {
                            case .success(let game):
                               
                                let gameResponse = GameResponse(
                                    id: Int(game.id ?? 0),
                                    name: game.name,
                                    image: game.image,
                                    released: game.released,
                                    rating: game.rating,
                                    desc: game.desc,
                                    tags: game.tags,
                                    genres: game.genres)
                                completion(.success(gameResponse))
                            case .failure:
                                completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
