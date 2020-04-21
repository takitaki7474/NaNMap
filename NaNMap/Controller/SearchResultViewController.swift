//
//  SearchResultViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/20.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var buildingList: [BuildingInfo]?
    var cellList = [String]()

    override func viewDidLoad() {
        createCellList()
        super.viewDidLoad()
    }
}

extension SearchResultViewController {
    
    func createCellList() {
        for buildingInfo in buildingList! {
            cellList.append(buildingInfo.building)
        }
    }
}


extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultResultCell", for: indexPath)
        cell.textLabel?.text = cellList[indexPath.row]
        return cell
    }
}


