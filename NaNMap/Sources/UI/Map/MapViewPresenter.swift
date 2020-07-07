//
//  MapViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/15.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import MapKit

protocol MapPresenter {
    func setUpMapRegion()
    func setPin(with info: [BuildingInfo], at index: Int)
}

final class MapViewPresenter: MapPresenter {
    weak var view: MapView?
    private let model = MapModel()
    
    init(view: MapView) {
        self.view = view
        model.delegate = self
    }
    
    func setUpMapRegion() {
        model.setUpMapRegion()
    }
    
    func setPin(with info: [BuildingInfo], at index: Int) {
        let title: String = info[index].building
        let longitude: Double = info[index].coordinate.longitude
        let latitude: Double = info[index].coordinate.latitude
        model.setPin(title, (longitude, latitude))
    }
}

extension MapViewPresenter: MapModelDelegate {
    func reloadRegion(at region: MKCoordinateRegion) {
        view?.reloadRegion(at: region)
    }
    
    func addPin(with pin: MKPointAnnotation) {
        view?.addPin(with: pin)
    }
}