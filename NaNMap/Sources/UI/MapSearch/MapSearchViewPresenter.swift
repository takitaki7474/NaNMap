//
//  SearchViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/20.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

protocol MapSearchPresenter {
    var numberOfBuildings: Int { get }
    var numberOfLocationSearchResults: Int { get }
    func loadBuildingTitle(at index: Int) -> String
    func tapBuildingCell(at index: Int)
    func searchLocation(with query: String)
    func loadLocationSearchResult(at index: Int) -> MapSearchLocationObj
}

final class MapSearchViewPresenter: MapSearchPresenter {
    weak var view: MapSearchView?
    private let model = MapSearchModel()
    private let mapPresenter: MapPresenter!
    
    init(view: MapSearchView, mapPresenter: MapPresenter) {
        self.view = view
        self.mapPresenter = mapPresenter
        model.delegate = self
    }
    
    var numberOfBuildings: Int {
        return model.buildings!.count
    }
    
    var numberOfLocationSearchResults: Int {
        return model.locationSearchResults!.count
    }
    
    func loadBuildingTitle(at index: Int) -> String {
        return model.buildings![index].building
    }
    
    func tapBuildingCell(at index: Int) {
        let info: [Building] = model.buildings!
        mapPresenter.addAnnotation(with: info, at: index)
    }
    
    func searchLocation(with query: String) {
        model.searchLocation(with: query)
    }
    
    func loadLocationSearchResult(at index: Int) -> MapSearchLocationObj {
        return model.locationSearchResults![index]
    }
}

extension MapSearchViewPresenter: MapSearchModelDelegate {
    func searchModel() {
        view?.reloadData()
    }
}
