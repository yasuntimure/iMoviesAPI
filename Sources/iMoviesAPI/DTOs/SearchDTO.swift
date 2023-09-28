//
//  SearchDTO.swift
//  ForeksTrader
//
//  Created by Eyüp on 25.06.2022.
//

import Foundation

public struct SearchDTO: Codable {

    public let query: String

    public init(query: String) {
        self.query = query
    }

    public enum CodingKeys: String, CodingKey {
        case query = "query"
    }

}

