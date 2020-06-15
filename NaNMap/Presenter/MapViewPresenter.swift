//
//  MapViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/15.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//
import MapKit

final class MapViewPresenter {
    weak var view: MapView?
    private let model = MapModel()
    
    init(view: MapView) {
        self.view = view
        model.delegate = self
    }
    
    func setUpMapRegion() {
        model.setUpMapRegion()
    }
}

extension MapViewPresenter: MapModelDelegate {
    
    func reloadRegion(at region: MKCoordinateRegion) {
        view?.reloadRegion(at: region)
    }
}
