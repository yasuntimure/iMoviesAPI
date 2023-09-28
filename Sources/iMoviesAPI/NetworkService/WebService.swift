//
//  WebService.swift
//
//
//  Created by Eyüp Yasuntimur on 25.12.2022.
//

import Foundation

public protocol WebServiceProtocol {
    func search(movie: String, completion: @escaping ([Movie]?) -> Void)
}

// MARK: - URLSession Version
public class WebService: WebServiceProtocol {

    public init() { }

    private let apiKey: String = "B3M0Vedeti0VV9HW2cPCOqDd4evgmmtG"

    public func search(movie: String, completion: @escaping ([Movie]?) -> Void) {

        let urlString = "https://api.nytimes.com/svc/movies/v2/reviews/search.json?query=\(movie)&api-key=\(apiKey)"

        guard let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }

            guard let data = data else {
                return
            }

            let decodedData = try? Decoders.plainDateDecoder.decode(SearchReponseModel.self, from: data)

            if let results = decodedData?.results {
                print(results)
                completion(results)
            }

        }.resume()
    }

}

// MARK: - NetworkingProtocol

public protocol NetworkingProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

// MARK: - Networking Class

public final class Networking: NetworkingProtocol {
    public func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let request = endpoint.request else { throw NetworkError.invalidRequest }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.responseUnsuccessful }

        switch httpResponse.statusCode {
        case 200...299:
            let responseObject = try JSONDecoder().decode(T.self, from: data)
            return responseObject
        case 400...499:
            throw NetworkError.notFound
        case 500...599:
            throw NetworkError.badRequest
        default:
            throw NetworkError.unknownError
        }
    }
}
