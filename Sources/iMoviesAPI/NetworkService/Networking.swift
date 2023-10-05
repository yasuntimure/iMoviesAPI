//
//  File.swift
//  
//
//  Created by Eyüp on 2023-09-28.
//

import Foundation

// MARK: - NetworkingProtocol

public protocol NetworkingProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

// MARK: - Networking Class

public final class Networking: NetworkingProtocol {

    public init() {}
    
    public func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let request = endpoint.request else {
            throw NetworkError.invalidRequest
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseUnsuccessful
        }

        switch httpResponse.statusCode {
        case 200...299:
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                return responseObject
            } catch let decodeError {
                throw decodeError
            }
        case 400...499:
            throw NetworkError.notFound
        case 500...599:
            throw NetworkError.badRequest
        default:
            throw NetworkError.unknownError
        }
    }
}
