// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let continueReading = try? newJSONDecoder().decode(ContinueReading.self, from: jsonData)

import Foundation

// MARK: - ContinueReading
struct ContinueReading: Codable {
    let paging: Paging?
    let items: [ContinueReadingItem]?
    let sortedBy: SortedBy?
    let filteredBy: FilteredBy?
}


// MARK: - Item
struct ContinueReadingItem: Codable {
    let readingProgress, lastReadAt: Int
    let summary: Summary
}


