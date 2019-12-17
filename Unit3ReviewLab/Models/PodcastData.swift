//
//  PodcastData.swift
//  Unit3ReviewLab
//
//  Created by Brendon Cecilio on 12/17/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import Foundation

struct PodcastData: Decodable {
    let results: [Podcast]
}

struct Podcast: Decodable {
    let artistName: String?
    let collectionName: String?
    let collectionId: Int?
    let artworkUrl30: String?
    let artworkUrl600: String?
    let genres: [String]?
}
