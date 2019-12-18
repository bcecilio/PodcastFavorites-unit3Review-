//
//  FavoritesController.swift
//  Unit3ReviewLab
//
//  Created by Brendon Cecilio on 12/17/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    
    var favoritePodcasts = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRefreshControl()
        tableView.delegate = self
        tableView.dataSource = self
        loadFavorites()
    }
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
    }
    
    @objc private func loadFavorites() {
        PodcastSearchAPI.getFavoritePodcast { [weak self] (result) in
            
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
            
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let favorites):
                self?.favoritePodcasts = favorites.filter{$0.favoritedBy == "Brendon"}
            }
        }
    }
}

extension FavoritesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePodcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteCell else {
            fatalError("could not dequeue")
        }
        let favoriteCell = favoritePodcasts[indexPath.row]
        cell.configureFavoriteCell(for: favoriteCell)
        return cell
    }
}

extension FavoritesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
