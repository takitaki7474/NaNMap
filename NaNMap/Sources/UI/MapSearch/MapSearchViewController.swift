//
//  MapSearchViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/09.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

protocol MapSearchView: class {
    func reloadData()
}

final class MapSearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!
    private var isSearchActive: Bool = false
    private var titles: [String] = ["教室棟", "食堂", "コンビニ", "書店"]
    private var mapPresenter: MapPresenter!
    private var mapSearchPresenter: MapSearchPresenter!
    
    static func instantiate(mapPresenter: MapPresenter) -> MapSearchViewController {
        let controller = UIStoryboard(name: "MapSearch", bundle: nil).instantiateInitialViewController() as! MapSearchViewController
        controller.mapPresenter = mapPresenter
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapSearchPresenter = MapSearchViewPresenter(view: self, mapPresenter: mapPresenter)
        setUpDefaultTableView()
        setUpNavigationBar()
    }
}

private extension MapSearchViewController {
    func setUpDefaultTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setUpNavigationBar() {
        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = "建物や施設を検索"
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationItem.hidesBackButton = false
        setUpSearchBar()
    }
    
    func setUpSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "建物や施設を検索"
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.tintColor = UIColor.gray
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
}

extension MapSearchViewController: MapSearchView {
    func reloadData() {
        tableView.reloadData()
    }
}

extension MapSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchActive == false {
            return titles.count
        } else {
            return mapSearchPresenter.numberOfLocationSearchResults
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! MapSearchViewCell
        if isSearchActive == false {
            cell.accessoryType = .disclosureIndicator
            cell.locationNameLabel.font = UIFont.systemFont(ofSize: 17.0)
            cell.display(locationName: titles[indexPath.row])
            cell.display(subInfo: "")
        } else {
            let mapSearchLocationObj = mapSearchPresenter.loadLocationSearchResult(at: indexPath.row)
            cell.accessoryType = .none
            cell.display(locationName: mapSearchLocationObj.locationName)
            cell.display(subInfo: mapSearchLocationObj.subInfo)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isSearchActive == false {
            return 43.5
        } else {
            return 60.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearchActive == false {
            let vc = MapSearchDefaultResultViewController.instantiate(mapSearchPresenter: mapSearchPresenter, defaultIndex: indexPath.row)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let mapSearchLocationObj = mapSearchPresenter.loadLocationSearchResult(at: indexPath.row)
            mapPresenter.addAnnotation(with: mapSearchLocationObj)
            navigationController?.popViewController(animated: true)
        }
    }
}

extension MapSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearchActive = true
            mapSearchPresenter.searchLocation(with: searchText)
        } else {
            isSearchActive = false
            reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
