//
//  File.swift
//  
//
//  Created by Eyüp Yasuntimur on 24.12.2022.
//

import Foundation



// MARK: - SearchReponseModel
public struct SearchReponseModel: Codable {
    public let status, copyright: String?
    public let hasMore: Bool?
    public let numResults: Int?
    public let results: [Movie]?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case hasMore = "has_more"
        case numResults = "num_results"
        case results
    }
}

// MARK: - Result
public struct Movie: Codable {
    public let displayTitle, mpaaRating: String?
    public let criticsPick: Int?
    public let byline, headline, summaryShort, publicationDate: String?
    public let openingDate: String?
    public let dateUpdated: String?
    public let link: Link?
    public let multimedia: Multimedia?

    public enum CodingKeys: String, CodingKey {
        case displayTitle = "display_title"
        case mpaaRating = "mpaa_rating"
        case criticsPick = "critics_pick"
        case byline, headline
        case summaryShort = "summary_short"
        case publicationDate = "publication_date"
        case openingDate = "opening_date"
        case dateUpdated = "date_updated"
        case link, multimedia
    }
}

// MARK: - Link
public struct Link: Codable {
    public let type: TypeEnum?
    public let url: String?
    public let suggestedLinkText: String?

    public enum CodingKeys: String, CodingKey {
        case type, url
        case suggestedLinkText = "suggested_link_text"
    }
}

public enum TypeEnum: String, Codable {
    case article = "article"
}

// MARK: - Multimedia
public struct Multimedia: Codable {
    public let type: String?
    public let src: String?
    public let height, width: Int?
}

