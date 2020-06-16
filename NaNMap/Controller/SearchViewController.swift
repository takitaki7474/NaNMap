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
    var defaultCellList = [String]()
    private var presenter: SearchViewPresenter!
    
    static func instantinate() -> SearchViewController {
        return UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController() as! SearchViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchViewPresenter()
        tableView.dataSource = self
        tableView.delegate = self
        setUpDefaultTableView()
        setUpNavigationBar()
    }
}

extension SearchViewController {
    
    func setUpDefaultTableView() {
        presenter.loadDefaultSearchInfo()
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
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultCellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = defaultCellList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchResultViewController = SearchResultViewController.instantinate()
        searchResultViewController.buildingList = createResultPageInfo()
        navigationController?.pushViewController(searchResultViewController, animated: true)
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfDefaultSearchTitleList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = presenter.defaultSearchTitleList(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.loadDefaultSearchResult(at: indexPath.row)
        let searchResultViewController = SearchResultViewController.instantinate()
        navigationController?.pushViewController(searchResultViewController, animated: true)
    }
}

/*
extension SearchViewController: SearchView {
    
    func fetchDefaultSearchCandidates(fetchResult: DefaultSearchCandidates) {
        defaultSearchCandidates = fetchResult
    }
}
 */
