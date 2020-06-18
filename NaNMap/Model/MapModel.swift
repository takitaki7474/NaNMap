//
//  MapModel.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/15.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import MapKit

protocol MapModelDelegate: class {
    func reloadRegion(at region: MKCoordinateRegion)
    func addPin(with pin: MKPointAnnotation)
}

struct Annotation {
    let title: String?
    let coordinate: (longitude: Double, latitude: Double)?
}

final class MapModel {
    weak var delegate: MapModelDelegate?
    var region: MKCoordinateRegion? {
        didSet {
            delegate?.reloadRegion(at: region!)
        }
    }
    var pin: MKPointAnnotation? {
        didSet {
            delegate?.addPin(with: pin!)
        }
    }
    
    func setUpMapRegion() {
        let centerLatitude: CLLocationDegrees = 35.149405
        let centerLongitude: CLLocationDegrees = 136.962477
        let center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        self.region = MKCoordinateRegion(center: center, span: span)
    }
    
    func setPin(_ title: String, _ coodinate: (Double, Double)) {
        self.pin = MKPointAnnotation()
        let annotation = Annotation(title: title, coordinate: coodinate)
        let longitude = annotation.coordinate?.0
        let latitude = annotation.coordinate?.1
        self.pin?.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
        self.pin?.title = annotation.title
        
        let center = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        self.region = MKCoordinateRegion(center: center, span: span)
    }
}
