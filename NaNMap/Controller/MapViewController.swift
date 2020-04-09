//
//  MapViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/07.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        initMapView()
    }
    
}

private extension MapViewController {
    /*
    @IBAction func didTapSearchButton(_ sender: Any){
        nextScreen()
    }
    
    func nextScreen(){
        let searchViewController = SearchViewController.instantinate()
        navigationController?.pushViewController(searchViewController, animated: false)
    }
    */
    func setUpNavigationBar(){
        navigationController?.navigationBar.barTintColor = UIColor.rgba(red: 85,green: 104,blue: 211)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        setUpSearchBar()
    }
    
    func setUpSearchBar() {
        if let navigationBarFrame = navigationController?.navigationBar.bounds {
            let searchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.placeholder = "建物や教室を検索"
            searchBar.searchTextField.backgroundColor = UIColor.white
            searchBar.tintColor = UIColor.gray
            searchBar.keyboardType = UIKeyboardType.default
            navigationItem.titleView = searchBar
            self.searchBar = searchBar
        }
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

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
