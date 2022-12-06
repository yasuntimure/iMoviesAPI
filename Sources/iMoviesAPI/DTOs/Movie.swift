//
//  Movie.swift
//  iMoviesAlamofireAPI
//
//  Created by Eyüp Yasuntimur on 6.12.2022.
//

import Foundation

public struct Movie: Decodable, Equatable {

    public enum CodingKeys: String, CodingKey {
        case artistName
        case releaseDate
        case name
        case copyright
        case image = "artworkUrl100"
        case genres
    }

    public let artistName: String
    public let releaseDate: String
    public let name: String
    public let copyright: String?
    public let image: URL
    public let genres: [Genre]
}

public struct Genre: Decodable, Equatable {
    public let name: String
}
