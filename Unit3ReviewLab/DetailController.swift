//
//  DetailController.swift
//  Unit3ReviewLab
//
//  Created by Brendon Cecilio on 12/17/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var podcastNameLabel: UILabel!
    @IBOutlet weak var podcastDetailLabel: UILabel!
    
    var podcastDetail: Podcast?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        guard let favoritePodcast = podcastDetail else {
            return
        }
        let favorite = Podcast(artistName: favoritePodcast.artistName, collectionName: favoritePodcast.collectionName, collectionId: favoritePodcast.collectionId, artworkUrl600: favoritePodcast.artworkUrl600, genres: favoritePodcast.genres, trackId: favoritePodcast.trackId, favoritedBy: "Brendon")
        
        PodcastSearchAPI.favoritePodcast(podcast: favorite) { [weak self](result) in
            DispatchQueue.main.async {
                sender.isEnabled = true
            }
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Success!", message: "\(favoritePodcast.collectionName) was favorited!")
                }
            }
        }
    }
    
    func updateUI() {
        guard let podcastInfo = podcastDetail else {
            print("could not load podcast info")
            return
        }
        podcastNameLabel.text = podcastInfo.collectionName
        podcastDetailLabel.text = podcastInfo.artistName
        podcastImageView.getImage(with: podcastInfo.artworkUrl600 ) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let image):
                self?.podcastImageView.image = image
            }
        }
    }

}
