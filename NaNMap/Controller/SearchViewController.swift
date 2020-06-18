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
    private var mapViewPresenter: MapViewPresenter!
    private var searchViewPresenter: SearchViewPresenter!
    
    static func instantinate(mapViewPresenter: MapViewPresenter) -> SearchViewController {
        let controller = UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController() as! SearchViewController
        controller.mapViewPresenter = mapViewPresenter
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchViewPresenter = SearchViewPresenter()
        setUpDefaultTableView()
        setUpNavigationBar()
    }
}


extension SearchViewController {
    
    func setUpDefaultTableView() {
        searchViewPresenter.setUpDefaultSearchInfo()
    }
    
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
        return searchViewPresenter.numberOfDefaultSearchTitleList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = searchViewPresenter.loadDefaultSearchTitleList(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchViewPresenter.setUpDefaultSearchResult(at: indexPath.row)
        let vc = DefaultSearchResultViewController.instantinate(searchViewPresenter: searchViewPresenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}

/*
extension SearchViewController: SearchView {
    
    func fetchDefaultSearchCandidates(fetchResult: DefaultSearchCandidates) {
        defaultSearchCandidates = fetchResult
    }
}
 */
