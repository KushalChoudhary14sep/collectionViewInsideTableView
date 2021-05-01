// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let promotion = try? newJSONDecoder().decode(Promotion.self, from: jsonData)

import Foundation

// MARK: - Promotion
struct Promotion: Codable {
    let promoName, promoType, title: String
    let coverURI: String
    let summary: Summary

    enum CodingKeys: String, CodingKey {
        case promoName, promoType, title
        case coverURI = "coverUri"
        case summary
    }
}

// MARK: - Summary
struct Summary: Codable {
    let summaryID: Int
    let title, publicationInfo: String
    let rating: Int
    let coverURI: String
    let audio: Bool

    enum CodingKeys: String, CodingKey {
        case summaryID = "summaryId"
        case title, publicationInfo, rating
        case coverURI = "coverUri"
        case audio
    }
}

