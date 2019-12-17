//
//  PodcastSearchAPI.swift
//  Unit3ReviewLab
//
//  Created by Brendon Cecilio on 12/17/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import Foundation

struct PodcastSearchAPI{
    static func fetchPodcasts(for searchQuery: String, completion: @escaping (Result<Podcast, AppError>) -> ()) {
        
        let podcastEnpointURL = "https://itunes.apple.com/search?media=podcast&limit=200&term=swift"
        
        guard let url = URL(string: podcastEnpointURL) else {
            completion(.failure(.badURL(podcastEnpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let podcasts = try JSONDecoder().decode(Podcast.self, from: data)
                    completion(.success(podcasts))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
