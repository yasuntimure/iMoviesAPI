//
//  File.swift
//  
//
//  Created by Eyüp Yasuntimur on 24.12.2022.
//

import Foundation

// MARK: - SearchReponseModel
public struct SearchReponseModel: Codable {
    let status, copyright: String?
    let hasMore: Bool?
    let numResults: Int?
    let results: [Result]?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case hasMore = "has_more"
        case numResults = "num_results"
        case results
    }
}

// MARK: - Result
public struct Result: Codable {
    let displayTitle, mpaaRating: String?
    let criticsPick: Int?
    let byline, headline, summaryShort, publicationDate: String?
    let openingDate: String?
    let dateUpdated: String?
    let link: Link?
    let multimedia: Multimedia?

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
    let type: TypeEnum?
    let url: String?
    let suggestedLinkText: String?

    enum CodingKeys: String, CodingKey {
        case type, url
        case suggestedLinkText = "suggested_link_text"
    }
}

public enum TypeEnum: String, Codable {
    case article = "article"
}

// MARK: - Multimedia
public struct Multimedia: Codable {
    let type: String?
    let src: String?
    let height, width: Int?
}

