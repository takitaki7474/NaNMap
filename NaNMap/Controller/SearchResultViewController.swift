//
//  SearchResultViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/20.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var presenter: SearchResultViewPresenter!
    var buildingList: [BuildingInfo]?
    var cellList = [String]()
    
    static func instantinate() -> SearchResultViewController {
         return UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "searchResultViewController") as! SearchResultViewController
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchResultViewPresenter()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfDefaultSearchBuildingList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultResultCell", for: indexPath)
        cell.textLabel?.text = presenter.defaultSearchBuildingList(at: indexPath.row)
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapViewController = navigationController?.viewControllers[0] as! MapViewController
        let title = buildingList![indexPath.row].building
        let longitude = buildingList![indexPath.row].coordinate.longitude
        let latitude = buildingList![indexPath.row].coordinate.latitude
        let annotation = Annotation(title: title, coordinate: (longitude: longitude, latitude: latitude))
        mapViewController.annotation = annotation
        navigationController?.popToRootViewController(animated: true)
    }
 */
    
 /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.popToRootViewController(animated: true)
    }
 */
}


