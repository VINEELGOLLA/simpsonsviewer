//
//  CharacterDataModel.swift
//  simpsonsviewer
//
//  Created by naga vineel golla on 5/16/21.
//

import Foundation

// MARK: - CharacterDataModel
struct CharacterDataModel: Codable {
    let heading: String?
    let relatedTopics: [RelatedTopic]?

    enum CodingKeys: String, CodingKey {
        case relatedTopics = "RelatedTopics"
        case heading = "Heading"
    }
}

// MARK: - RelatedTopic
struct RelatedTopic: Codable {
    let firstURL: String?
    let icon: Icon?
    let result, text: String?

    enum CodingKeys: String, CodingKey {
        case firstURL = "FirstURL"
        case icon = "Icon"
        case result = "Result"
        case text = "Text"
    }
}

// MARK: - Icon
struct Icon: Codable {
    let height, url, width: String?

    enum CodingKeys: String, CodingKey {
        case height = "Height"
        case url = "URL"
        case width = "Width"
    }
}
