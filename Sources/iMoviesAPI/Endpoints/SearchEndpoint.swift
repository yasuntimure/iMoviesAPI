//
//  File.swift
//  
//
//  Created by Eyüp on 2023-09-28.
//

import Foundation

// MARK: - Search Endpoint

public enum SearchEndpoint: Endpoint {

    case search(dto: SearchDTO)

    public var request: URLRequest? {
        switch self {
        case .search:
            return request("/svc/movies/v2/reviews/search.json")
        }
    }

    public var httpMethod: HTTPMethod {
        switch self {
        case .search:
            return .GET
        }
    }

    public var httpHeaders: HTTPHeaders? {
        switch self {
        case .search: 
            return Keys.apiKey
        }
    }

    public var httpTask: HTTPTask {
        switch self {
        case .search(let dto):
            return .requestParameters(parameters: try? dto.asDictionary(), encoding: .url)
        }
    }

    public var useToken: Bool {
        switch self {
        case .search:
            return false
        }
    }
}

private struct Keys {
    static let apiKey: HTTPHeaders = ["api-key": "9WqZwhNwMGsU8GWuO5RWq8N6Z68EmRZv"]
}
