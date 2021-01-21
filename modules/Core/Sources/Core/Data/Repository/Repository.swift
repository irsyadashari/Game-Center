//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Combine

public protocol Repository {
    associatedtype Request
    associatedtype Response
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
