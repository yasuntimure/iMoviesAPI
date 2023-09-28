//
//  File.swift
//  
//
//  Created by Eyüp on 2023-09-28.
//

import Foundation

// MARK: - NetworkError

public enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonDecodingError
    case notFound
    case badRequest
    case unknownError
    case invalidRequest
}
