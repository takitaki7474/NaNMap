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
    var defaultSearchCandidates: DefaultSearchCandidates?
    private var presenter: SearchViewPresenter!
    
    static func instantinate() -> SearchViewController {
        return UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController() as! SearchViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPresenter()
        setUpDefaultCellList()
        setUpNavigationBar()
    }
}

private extension SearchViewController {
    
    func setUpPresenter() {
        presenter = SearchViewPresenter(view: self, JSONParser: DefaultSearchJSONParser())
        presenter.loadDefaultSearchCandidates()
    }
    
    func setUpDefaultCellList() {
        let sectionIndex = 0
        for row in defaultSearchCandidates!.section[sectionIndex].row {
            defaultCellList.append(row.title)
            print(defaultCellList)
        }
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
        let searchResultViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchResultViewController") as! SearchResultViewController
        searchResultViewController.defaultSearchCandidates = defaultSearchCandidates?.section[indexPath.section].row[indexPath.row] as Any?
        navigationController?.pushViewController(searchResultViewController, animated: true)
        
    }
}

extension SearchViewController: SearchView {
    
    func fetchDefaultSearchCandidates(fetchResult: DefaultSearchCandidates) {
        defaultSearchCandidates = fetchResult
        print(fetchResult.section[0].row[0])
    }
}
