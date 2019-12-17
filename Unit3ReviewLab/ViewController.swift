//
//  ViewController.swift
//  Unit3ReviewLab
//
//  Created by Brendon Cecilio on 12/17/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var refreshControl: UIRefreshControl!
    
    var podcasts = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPodcasts(searchQuery: searchQuery)
        configureRefreshControl()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
    }
    
    func loadPodcasts(searchQuery: String) {
        PodcastSearchAPI.fetchPodcasts(for: searchQuery) { (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let podcasts):
                self.podcasts = [podcasts]
            }
        }
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
            fatalError("could not dequeue PodcastCell")
        }
        let podcastCell = podcasts[indexPath.row]
        cell.configurePodcastCell(for: podcastCell)
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            print("search bar is empty")
            return
        }
        loadPodcasts(searchQuery: searchText)
    }
}
