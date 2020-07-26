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
    var defaultCellList = [String]()
    private var mapPresenter: MapPresenter!
    private var MapSearchPresenter: MapSearchPresenter!
    
    static func instantinate(mapPresenter: MapPresenter) -> MapSearchViewController {
        let controller = UIStoryboard(name: "MapSearch", bundle: nil).instantiateInitialViewController() as! MapSearchViewController
        controller.mapPresenter = mapPresenter
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        MapSearchPresenter = MapSearchViewPresenter(mapPresenter: mapPresenter)
        setUpDefaultTableView()
        setUpNavigationBar()
    }
}

extension MapSearchViewController {
    func setUpDefaultTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        MapSearchPresenter.setUpDefaultSearchInfo()
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

extension MapSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MapSearchPresenter.numberOfDefaultSearchTitleList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = MapSearchPresenter.loadDefaultSearchTitleList(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MapSearchPresenter.setUpDefaultSearchResult(at: indexPath.row)
        let vc = MapSearchDefaultResultViewController.instantinate(MapSearchPresenter: MapSearchPresenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}
