//
//  File.swift
//  
//
//  Created by Eyüp on 2023-09-28.
//

import Foundation
import Combine

// MARK: - NetworkingProtocol

public protocol HTTPClient {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
    func request<T: Codable>(_ endpoint: Endpoint, for type: T.Type) -> AnyPublisher<T, Error>
}

// MARK: - Networking Class

public final class Networking: HTTPClient {

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

    public func request<T: Decodable>(_ endpoint: Endpoint, for type: T.Type, qos: DispatchQoS.QoSClass = .userInitiated) -> AnyPublisher<T, Error> {

        guard let request = endpoint.request else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .user))
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.responseUnsuccessful
                }

                switch httpResponse.statusCode {
                case 200...299:
                    return data
                case 400...499:
                    throw NetworkError.notFound
                case 500...599:
                    throw NetworkError.badRequest
                default:
                    throw NetworkError.unknownError
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
