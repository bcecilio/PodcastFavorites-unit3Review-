//
//  FavoriteCell.swift
//  Unit3ReviewLab
//
//  Created by Brendon Cecilio on 12/18/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteNameLabel: UILabel!
    @IBOutlet weak var favoriteGenre: UILabel!
    
    func configureFavoriteCell(for podcastData: Podcast) {
        favoriteNameLabel.text = podcastData.collectionName
        favoriteGenre.text = podcastData.genres?.first
        favoriteImageView.getImage(with: podcastData.artworkUrl600 ?? "") { (result) in
            switch result {
            case .failure( _):
                DispatchQueue.main.async {
                    self.favoriteImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.favoriteImageView.image = image
                }
            }
        }
    }
}
