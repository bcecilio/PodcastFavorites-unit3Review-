//
//  PodcastCell.swift
//  Unit3ReviewLab
//
//  Created by Brendon Cecilio on 12/17/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {

    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var podcastName: UILabel!
    @IBOutlet weak var podcastGenre: UILabel!
    
    func configurePodcastCell(for podcastData: Podcast) {
        podcastName.text = podcastData.collectionName
        podcastGenre.text = podcastData.genres?.description
        podcastImageView.getImage(with: podcastData.artworkUrl100 ?? "") { (result) in
            switch result {
            case .failure( _):
                DispatchQueue.main.async {
                    self.podcastImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.podcastImageView.image = image
                }
            }
        }
    }
}
