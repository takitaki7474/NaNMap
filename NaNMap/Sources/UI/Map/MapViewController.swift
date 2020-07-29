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
    func loadAnnotations(annotations: [AnnotationObj])
    func addAnnotation(annotation: AnnotationObj)
    func reloadMapRegion(at center: (Double, Double))
}

final class MapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    var searchBar: UISearchBar!
    var presenter: MapPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MapViewPresenter(view: self)
        mapView.delegate = self
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
    func loadAnnotations(annotations: [AnnotationObj]) {
        var points = [MKPointAnnotation]()
        for annotation in annotations {
            let point = MKPointAnnotation()
            point.title = annotation.title
            point.coordinate = CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude)
            points.append(point)
        }
        mapView.addAnnotations(points)
    }
    
    func addAnnotation(annotation: AnnotationObj) {
        let point = MKPointAnnotation()
        point.title = annotation.title
        point.coordinate = CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude)
        mapView.addAnnotation(point)
    }
    
    func reloadMapRegion(at center: (Double, Double)) {
        let center = CLLocationCoordinate2D(latitude: center.1, longitude: center.0)
        let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        mapView.region = MKCoordinateRegion(center: center, span: span)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKMarkerAnnotationView()
        pin.annotation = annotation
        pin.markerTintColor = UIColor.rgba(red: 85,green: 104,blue: 211)
        return pin
    }
}

extension MapViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let vc = MapSearchViewController.instantinate(mapPresenter: presenter)
        navigationController?.pushViewController(vc, animated: false)
        return true
    }
}
