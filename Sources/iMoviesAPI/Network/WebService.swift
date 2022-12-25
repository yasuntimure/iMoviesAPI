//
//  File.swift
//
//
//  Created by Eyüp Yasuntimur on 25.12.2022.
//

import Foundation

// MARK: - URLSession Version
final class WebService {

    static let shared = WebService()

    private let apiKey: String = "B3M0Vedeti0VV9HW2cPCOqDd4evgmmtG"

    func search(movie: String, completion: @escaping (SearchReponseModel?) -> Void) {

        let urlString = "https://api.nytimes.com/svc/movies/v2/reviews/search.json?query=\(movie)&api-key=\(apiKey)"

        let url = URL(string: urlString)

        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in

            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }

            let result = try? JSONDecoder().decode(SearchReponseModel.self, from: data)

            if let result = result {
                completion(result)
            }

        }.resume()

    }
}
