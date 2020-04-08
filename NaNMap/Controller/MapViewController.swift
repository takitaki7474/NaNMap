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

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScreen()
        initMapView()
    }
    
}

private extension MapViewController {
    @IBAction func didTapSearchButton(_ sender: Any){
        nextScreen()
    }
    
    func nextScreen(){
        let searchViewController = SearchViewController.instantinate()
        navigationController?.pushViewController(searchViewController, animated: false)
    }
    
    func setUpScreen(){
        self.navigationController?.navigationBar.barTintColor = UIColor.rgba(red: 85,green: 104,blue: 211)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = "名古屋キャンパス"
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
