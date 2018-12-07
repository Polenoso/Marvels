//
//  Serie.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

public enum SerieType: String, Codable {
    case limited
    case collection
    case ongoing
    case undefined = ""
}

public struct Serie {
    
    let id: Int
    let title: String?
    let description: String?
    let startYear: Int?
    let endYear: Int?
    let rating: String?
    let type: SerieType?
    let modified: String?
}

extension Serie: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case startYear
        case endYear
        case rating
        case type
        case modified
    }
}

extension Serie: Hashable {
    public var hashValue: Int { return id.hashValue }
}

public struct Thumbnail {
    let path: String?
    let ext: String?
}

extension Thumbnail: Codable {
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
