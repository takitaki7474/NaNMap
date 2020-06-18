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
}

final class MapModel {
    weak var delegate: MapModelDelegate?
    var region: MKCoordinateRegion? {
        didSet {
            delegate?.reloadRegion(at: region!)
        }
    }
    
    func setUpMapRegion() {
        let centerLatitude: CLLocationDegrees = 35.149405
        let centerLongitude: CLLocationDegrees = 136.962477
        let center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        region = MKCoordinateRegion(center: center, span: span)
    }
    
}
