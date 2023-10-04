//
//  File.swift
//  
//
//  Created by Eyüp on 2023-09-28.
//

import Foundation

// MARK: - Search Endpoint

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
            return Keys.apiKey
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

private struct Keys {
    static let apiKey: HTTPHeaders = ["api_key": "c2d9e79ed7d1ce1a1f1eb7ddac3f84b6"]
}
