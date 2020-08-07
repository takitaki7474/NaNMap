//
//  MapSearchViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/09.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

final class MapSearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!
    var isSearchActive: Bool = false
    private var titles: [String] = ["棟の検索"]
    private var mapPresenter: MapPresenter!
    private var mapSearchPresenter: MapSearchPresenter!
    
    static func instantiate(mapPresenter: MapPresenter) -> MapSearchViewController {
        let controller = UIStoryboard(name: "MapSearch", bundle: nil).instantiateInitialViewController() as! MapSearchViewController
        controller.mapPresenter = mapPresenter
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapSearchPresenter = MapSearchViewPresenter(mapPresenter: mapPresenter)
        setUpDefaultTableView()
        setUpNavigationBar()
    }
}

extension MapSearchViewController {
    func setUpDefaultTableView() {
        tableView.dataSource = self
        tableView.delegate = self
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
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
}

extension MapSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchActive == false {
            return titles.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MapSearchDefaultResultViewController.instantiate(mapSearchPresenter: mapSearchPresenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MapSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearchActive = true
            print(searchText)
        } else {
            isSearchActive = false
        }
    }
}
