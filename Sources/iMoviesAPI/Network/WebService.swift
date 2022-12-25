//
//  File.swift
//
//
//  Created by Eyüp Yasuntimur on 25.12.2022.
//

import Foundation

public protocol WebServiceProtocol {
    public func search(movie: String, completion: @escaping (SearchReponseModel?) -> Void)
}

// MARK: - URLSession Version
public class WebService {

    public init() { }

    private let apiKey: String = "B3M0Vedeti0VV9HW2cPCOqDd4evgmmtG"

    public func search(movie: String, completion: @escaping (SearchReponseModel?) -> Void) {

        let urlString = "https://api.nytimes.com/svc/movies/v2/reviews/search.json?query=\(movie)&api-key=\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }

            guard let data = data else {
                return
            }


            let result = try? JSONDecoder().decode(SearchReponseModel.self, from: data)

            if let result = result {
                completion(result)
            }

        }.resume()

    }
}
