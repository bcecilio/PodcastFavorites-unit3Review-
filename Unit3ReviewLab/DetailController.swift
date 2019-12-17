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
    
    func updateUI() {
        guard let podcastInfo = podcastDetail else {
            print("could not load podcast info")
            return
        }
        podcastNameLabel.text = podcastInfo.collectionName
        podcastDetailLabel.text = podcastInfo.artistName
        podcastImageView.getImage(with: podcastInfo.artworkUrl600 ?? "") { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let image):
                self?.podcastImageView.image = image
            }
        }
    }

}
