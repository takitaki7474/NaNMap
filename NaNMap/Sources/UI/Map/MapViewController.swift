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
        initTrackingButton()
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
        let center = CLLocationCoordinate2D(latitude: 35.149405, longitude: 136.962477)
        let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        mapView.region = MKCoordinateRegion(center: center, span: span)
    }
    
    func initTrackingButton() {
        let trackingBtn = MKUserTrackingButton(mapView: mapView)
        trackingBtn.layer.backgroundColor = UIColor.rgba(red: 255, green: 255, blue: 255, alpha: 0.7).cgColor
        let screenSize: CGSize = UIScreen.main.bounds.size
        let tabBarHeight: CGFloat = tabBarController?.tabBar.frame.height ?? 49.0
        trackingBtn.frame = CGRect(x: screenSize.width-55.0, y: screenSize.height-tabBarHeight-80.0, width: 40.0, height: 40.0)
        view.addSubview(trackingBtn)
    }

    func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.rgba(red: 85, green: 104, blue: 211)
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
        let vc = TimeTableViewController.instantiate()
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
            point.subtitle = annotation.subtitle
            point.coordinate = CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude)
            points.append(point)
        }
        mapView.addAnnotations(points)
    }
    
    func addAnnotation(annotation: AnnotationObj) {
        let point = MKPointAnnotation()
        point.title = annotation.title
        point.subtitle = annotation.subtitle
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
        if let subtitle = annotation.subtitle! {
            if subtitle == "" {
                pin.markerTintColor = UIColor.rgba(red: 85, green: 104, blue: 211)
            } else {
                pin.markerTintColor = UIColor.rgba(red: 250, green: 166, blue: 26)
            }
        }
        pin.canShowCallout = true
        let deleteButton = UIButton()
        deleteButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        deleteButton.setTitle("削除", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        pin.rightCalloutAccessoryView = deleteButton
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        presenter.removeAnnotation(title: view.annotation?.title!)
        mapView.removeAnnotation(view.annotation!)
    }
}

extension MapViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let vc = MapSearchViewController.instantiate(mapPresenter: presenter)
        navigationController?.pushViewController(vc, animated: false)
        return true
    }
}
