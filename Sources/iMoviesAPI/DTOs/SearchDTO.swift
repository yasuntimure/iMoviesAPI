//
//  SearchDTO.swift
//  ForeksTrader
//
//  Created by Eyüp on 25.06.2022.
//

import Foundation

public struct SearchDTO: Codable {

    let movieName: String

    enum CodingKeys: String, CodingKey {
        case movieName = "query"
    }

}

