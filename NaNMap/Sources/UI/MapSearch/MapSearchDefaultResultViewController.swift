//
//  SearchResultViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/20.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

final class MapSearchDefaultResultViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var presenter: MapSearchPresenter!
    private var defaultIndex: Int!
    
    static func instantiate(mapSearchPresenter: MapSearchPresenter, defaultIndex: Int) -> MapSearchDefaultResultViewController {
        let controller = UIStoryboard(name: "MapSearch", bundle: nil).instantiateViewController(withIdentifier: "mapSearchDefaultResultViewController") as! MapSearchDefaultResultViewController
        controller.presenter = mapSearchPresenter
        controller.defaultIndex = defaultIndex
        controller.presenter.loadDefaultSearchResults(defaultIndex: defaultIndex)
        return controller
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MapSearchDefaultResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfDefaultSearchResults
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultResultCell", for: indexPath)
        cell.textLabel?.text = presenter.loadDefaultSearchResultTitle(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tapDefaultSearchResultCell(at: indexPath.row)
        navigationController?.popToRootViewController(animated: true)
    }
}


