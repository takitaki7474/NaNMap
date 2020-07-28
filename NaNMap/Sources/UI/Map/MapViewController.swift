//
//  MapViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/07.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit
import MapKit

protocol MapView: class {
    func reloadRegion(at region: MKCoordinateRegion)
    func addPin(with pin: MKPointAnnotation)
}

final class MapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    var searchBar: UISearchBar!
    var presenter: MapPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MapViewPresenter(view: self)
        initMapRegion()
        setUpNavigationBar()
        setUpTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSearchBar()
    }
}

extension MapViewController {
    func initMapRegion() {
        //presenter.setUpMapRegion()
        let centerLatitude: CLLocationDegrees = 35.149405
        let centerLongitude: CLLocationDegrees = 136.962477
        let center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        mapView.region = MKCoordinateRegion(center: center, span: span)
    }

    func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.rgba(red: 85,green: 104,blue: 211)
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
        let vc = TimeTableViewController.instantinate()
        let nc = UINavigationController(rootViewController: vc)
        nc.tabBarItem = UITabBarItem(title: "時間割", image: nil, selectedImage: nil)
        tabBarController?.viewControllers?.append(nc)
    }
}
    
extension MapViewController: MapView {
    func reloadRegion(at region: MKCoordinateRegion) {
        mapView.region = region
    }
    
    func addPin(with pin: MKPointAnnotation) {
        mapView.addAnnotation(pin)
    }
}

extension MapViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let vc = MapSearchViewController.instantinate(mapPresenter: presenter)
        navigationController?.pushViewController(vc, animated: false)
        return true
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
