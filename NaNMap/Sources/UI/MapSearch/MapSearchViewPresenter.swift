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
    func tapDefaultBuildingCell(at index: Int)
}

final class MapSearchViewPresenter: MapSearchPresenter {
    private let model = MapSearchModel()
    private let mapPresenter: MapPresenter!
    
    init(mapPresenter: MapPresenter) {
        self.mapPresenter = mapPresenter
    }
    
    var numberOfBuildings: Int {
        return model.buildings!.count
    }
    
    func loadBuildingTitle(at index: Int) -> String {
        return model.buildings![index].building
    }
    
    func tapDefaultBuildingCell(at index: Int) {
        let info: [Building] = model.buildings!
        mapPresenter.setPin(with: info, at: index)
    }
}
