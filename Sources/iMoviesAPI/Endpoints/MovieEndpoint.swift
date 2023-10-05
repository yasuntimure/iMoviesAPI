//
//  File.swift
//  
//
//  Created by Eyüp on 2023-09-28.
//

import Foundation

// MARK: - Movie Endpoint

public enum MovieEndpoint: Endpoint {

    case upcoming

    public var request: URLRequest? {
        switch self {
        case .upcoming:
            return request("/3/movie/upcoming")
        }
    }

    public var httpMethod: HTTPMethod {
        switch self {
        case .upcoming:
            return .GET
        }
    }

    public var httpHeaders: HTTPHeaders? {
        switch self {
        case .upcoming: 
            return nil
        }
    }

    public var httpTask: HTTPTask {
        switch self {
        case .upcoming:
            return .requestPlain
        }
    }

    public var useToken: Bool {
        switch self {
        case .upcoming:
            return false
        }
    }
}
