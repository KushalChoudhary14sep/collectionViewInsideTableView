// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recommended = try? newJSONDecoder().decode(Recommended.self, from: jsonData)

import Foundation

// MARK: - Recommended
struct Recommended: Codable {
    let paging: Paging
    let items: [Item]
    let sortedBy: SortedBy
    let title, recommendedDescription: String
    let filteredBy: FilteredBy

    enum CodingKeys: String, CodingKey {
        case paging, items, sortedBy, title
        case recommendedDescription = "description"
        case filteredBy
    }
}


