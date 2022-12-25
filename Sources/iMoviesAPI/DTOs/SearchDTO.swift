//
//  SearchDTO.swift
//  ForeksTrader
//
//  Created by Eyüp on 25.06.2022.
//

import Foundation

struct SearchDTO: Decodable {

    let movieName: String

    enum SearchDTO: String, CodingKey {
        case movieName = "query"
    }

}

