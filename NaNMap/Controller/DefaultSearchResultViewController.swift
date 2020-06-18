//
//  SearchResultViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/20.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

class DefaultSearchResultViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var presenter: SearchPresenter!
    var buildingList: [BuildingInfo]?
    var cellList = [String]()
    
    static func instantinate(searchPresenter: SearchPresenter) -> DefaultSearchResultViewController {
        let controller = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "defaultSearchResultViewController") as! DefaultSearchResultViewController
        controller.presenter = searchPresenter
        return controller
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension DefaultSearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfDefaultBuildingList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultResultCell", for: indexPath)
        cell.textLabel?.text = presenter.loadDefaultBuildingList(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tapDefaultBuildingCell(at: indexPath.row)
        navigationController?.popToRootViewController(animated: true)
    }
}


