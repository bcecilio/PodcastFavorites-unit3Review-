//
//  PodcastData.swift
//  Unit3ReviewLab
//
//  Created by Brendon Cecilio on 12/17/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import Foundation

struct PodcastData: Codable {
    let results: [Podcast]
}

struct Podcast: Codable {
    let artistName: String?
    let collectionName: String
    let collectionId: Int?
    let artworkUrl600: String
    let genres: [String]?
    let trackId: Int
    let favoritedBy: String?
}
