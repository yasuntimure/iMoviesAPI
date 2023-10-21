//
//  File.swift
//  
//
//  Created by Eyüp on 2023-09-28.
//

import Foundation

// MARK: - Endpoint

public protocol Endpoint {
    var request: URLRequest? { get }
    var httpMethod: HTTPMethod { get }
    var httpHeaders: HTTPHeaders? { get }
    var httpTask: HTTPTask { get }
    var useToken: Bool { get }
    var scheme: String { get }
    var host: String { get }
}

extension Endpoint {

    public var scheme: String { "https" }

    public var host: String { "api.themoviedb.org" }

    public func request(_ endpoint: String) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = endpoint

        var queryItems: [URLQueryItem] = []

        // Always add api_key to the request
        let apiKeyItem = URLQueryItem(name: "api_key", value: "c2d9e79ed7d1ce1a1f1eb7ddac3f84b6")
        queryItems.append(apiKeyItem)

        switch httpTask {
        case .requestParameters(let parameters, .url):
            if let parameters = parameters as? [String: String] {
                let parameterItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
                queryItems.append(contentsOf: parameterItems)
            }
        default: break
        }

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        if let headers = httpHeaders {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        return request
    }

}



// MARK: - HTTPMethod

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}


// MARK: - HTTPHeaders

public typealias HTTPHeaders = [String : String]


// MARK: - HTTPTask

public enum HTTPTask {
    case requestPlain
    case requestParameters(parameters: Parameters?, encoding: ParameterEncoding)
    // Other tasks
}

/// A dictionary of parameters to apply to a `URLRequest`.
public typealias Parameters = [String: Any]

public enum ParameterEncoding {
    case url
    // Other encodings
}
