//
//  SearchViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/20.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

protocol SearchPresenter {
    var numberOfDefaultSearchTitleList: Int { get }
    var numberOfDefaultBuildingList: Int { get }
    func setUpDefaultSearchResult(at index: Int)
    func setUpDefaultSearchInfo()
    func loadDefaultSearchTitleList(at index: Int) -> String
    func loadDefaultBuildingList(at index: Int) -> String
    func tapDefaultBuildingCell(at index: Int)
}

final class MapSearchViewPresenter: SearchPresenter {
    private let model = MapSearchModel()
    private let mapPresenter: MapPresenter!
    
    init(mapPresenter: MapPresenter) {
        self.mapPresenter = mapPresenter
    }
    
    var numberOfDefaultSearchTitleList: Int {
        return model.defaultSearchTitleList.count
    }
    
    var numberOfDefaultBuildingList: Int {
        return model.defaultBuildingList.count
    }
    
    func setUpDefaultSearchResult(at index: Int) {
        model.setUpDefaultSearchResult(at: index)
    }
    
    func setUpDefaultSearchInfo() {
        model.setUpDefaultSearchInfo()
    }

    func loadDefaultSearchTitleList(at index: Int) -> String {
        return model.defaultSearchTitleList[index]
    }
    
    func loadDefaultBuildingList(at index: Int) -> String {
        return model.defaultBuildingList[index]
    }
    
    func tapDefaultBuildingCell(at index: Int) {
        let info: [BuildingInfo] = model.defaultBuildingInfo!
        mapPresenter.setPin(with: info, at: index)
    }
}
