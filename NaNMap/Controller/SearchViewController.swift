//
//  SearchViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/09.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!
    var defaultCell: [String] = ["棟の検索"]
    var defaultSearchCandidates: DefaultSearchCandidates?
    private var presenter: SearchViewPresenter!
    
    static func instantinate() -> SearchViewController {

        return UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController() as! SearchViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchViewPresenter(view: self, JSONParser: DefaultSearchJSONParser())
        setUpNavigationBar()
    }
}

private extension SearchViewController {
    
    func setUpNavigationBar() {
        navigationItem.hidesBackButton = true
        setUpSearchBar()
    }
    
    func setUpSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "建物や教室を検索"
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.tintColor = UIColor.gray
        searchBar.becomeFirstResponder()
        navigationItem.titleView = searchBar
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = defaultCell[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchResultViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchResultViewController") as! SearchResultViewController
        presenter.loadDefaultSearchCandidates()
        searchResultViewController.defaultSearchCandidates = defaultSearchCandidates?.section[indexPath.section].row[indexPath.row] as Any
        navigationController?.pushViewController(searchResultViewController, animated: true)
        
    }
}

extension SearchViewController: SearchView {
    
    func fetchDefaultSearchCandidates(fetchResult: DefaultSearchCandidates) {
        defaultSearchCandidates = fetchResult
    }
}
