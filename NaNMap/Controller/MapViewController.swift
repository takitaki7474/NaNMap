//
//  MapViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/07.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit
import MapKit


struct Annotation {
    let title: String?
    let coordinate: (longitude: Double, latitude: Double)?
}


final class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    var searchBar: UISearchBar!
    var annotation: Annotation? {
        didSet {
            addPin(with: annotation!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpTabBar()
        initMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSearchBar()
    }
}


private extension MapViewController {

    func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.rgba(red: 85,green: 104,blue: 211)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func setUpSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "建物や教室を検索"
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.tintColor = UIColor.gray
        navigationItem.titleView = searchBar
    }
    
    func setUpTabBar() {
        let timeTableViewController = TimeTableViewController.instantinate()
        timeTableViewController.tabBarItem = UITabBarItem(title: "時間割", image: nil, selectedImage: nil)
        tabBarController?.viewControllers?.append(timeTableViewController)
    }
    
    func initMapView(){
        let centerLatitude: CLLocationDegrees = 35.149405
        let centerLongitude: CLLocationDegrees = 136.962477
        let center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.region = region
    }
}


private extension MapViewController {
    
    func addPin(with annotation: Annotation) {
        let point = MKPointAnnotation()
        let longitude = annotation.coordinate?.0
        let latitude = annotation.coordinate?.1
        point.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        point.title = annotation.title
        mapView.addAnnotation(point)
    }
}


extension MapViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let searchViewController = SearchViewController.instantinate()
        navigationController?.pushViewController(searchViewController, animated: false)
        return true
    }
}


extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
