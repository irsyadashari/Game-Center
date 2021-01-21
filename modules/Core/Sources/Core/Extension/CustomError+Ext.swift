//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Foundation

public enum URLError: LocalizedError {
    case invalidRequest
    case invalidResponse
    case addressUnreachable(URL)
    
    public var errorDescription: String? {
        switch self {
        case .invalidRequest: return "Request is null."
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
        }
    }
}

public enum DatabaseError: LocalizedError {
    case invalidInstance
    case requestFailed
    public var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database instance is not valid."
        case .requestFailed: return "Your request failed due to unknown error."
        }
    }
}
