//
//  SearchViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/20.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

protocol MapSearchPresenter {
    var numberOfBuildings: Int { get }
    func loadBuildingTitle(at index: Int) -> String
    func tapBuildingCell(at index: Int)
    func searchBuilding(with query: String)
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
    
    func loadBuildingTitle(at index: Int) -> String {
        return model.buildings![index].building
    }
    
    func tapBuildingCell(at index: Int) {
        let info: [Building] = model.buildings!
        mapPresenter.addAnnotation(with: info, at: index)
    }
    
    func searchBuilding(with query: String) {
        model.searchBuilding(with: query)
    }
}

extension MapSearchViewPresenter: MapSearchModelDelegate {
    func searchModel() {
        view?.reloadData()
    }
}
