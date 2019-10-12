//
//  SearchMusicTableViewController.swift
//  DJYusaku
//
//  Created by Hayato Kohara on 2019/10/12.
//  Copyright © 2019 Yusaku. All rights reserved.
//

import UIKit
import StoreKit

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var searchController: UISearchController!
    
    // 表示確認用サンプルデータ
    let results = [
        MusicDataModel(title: "Come Together", artist: "The Beatles"),
        MusicDataModel(title: "Something", artist: "The Beatles"),
        MusicDataModel(title: "Oh! Darling", artist: "The Beatles")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        // tableViewのdelegate, dataSource設定
        tableView.delegate = self
        tableView.dataSource = self
        
        // Apple Musicライブラリへのアクセス許可の確認
        SKCloudServiceController.requestAuthorization { status in
            guard status == .authorized else { return }
            // TODO: Apple Musicの契約確認処理
        }
    }
    
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
        
        let item = results[indexPath.row]
        cell.title.text = item.title
        cell.artist.text = item.artist

        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    /* 未実装 */
}
    
// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        /* 未実装 */
    }
}

// MARK: - UIBarPositioningDelegate

extension SearchViewController: UIBarPositioningDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached;
    }

}
