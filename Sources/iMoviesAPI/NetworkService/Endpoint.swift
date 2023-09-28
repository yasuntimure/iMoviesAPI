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

    public var host: String { "api.nytimes.com" }

    public func request(_ endpoint: String) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = endpoint

        switch httpTask {
        case .requestParameters(let parameters, .url):
            if let parameters = parameters as? [String: String] {
                urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            }
        default: break
        }

        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue


        if let httpHeaders = httpHeaders {
            dump("Http Headers: \(String(describing: httpHeaders))")
            httpHeaders?.forEach { element in 
                request.setValue(
                    element.value,
                    forHTTPHeaderField: element.key
                )
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

public typealias HTTPHeaders = [String : String]?


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
