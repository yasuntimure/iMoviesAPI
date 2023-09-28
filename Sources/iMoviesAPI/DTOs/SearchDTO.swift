//
//  SearchDTO.swift
//  ForeksTrader
//
//  Created by Eyüp on 25.06.2022.
//

import Foundation

public struct SearchDTO: Codable {

    public let movieName: String

    public enum CodingKeys: String, CodingKey {
        case movieName = "query"
    }

}

