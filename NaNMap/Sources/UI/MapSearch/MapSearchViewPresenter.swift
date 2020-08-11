//
//  SearchViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/20.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

protocol MapSearchPresenter {
    var numberOfDefaultSearchResults: Int { get }
    var numberOfLocationSearchResults: Int { get }
    func loadDefaultSearchResultTitle(at index: Int) -> String
    func tapDefaultSearchResultCell(at index: Int)
    func searchLocation(with query: String)
    func loadLocationSearchResult(at index: Int) -> MapSearchLocationObj
    func loadDefaultSearchResults(defaultIndex: Int)
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
    
    var numberOfDefaultSearchResults: Int {
        return model.defaultSearchResults!.count
    }
    
    var numberOfLocationSearchResults: Int {
        return model.locationSearchResults!.count
    }
    
    func loadDefaultSearchResultTitle(at index: Int) -> String {
        return model.defaultSearchResults![index].location
    }
    /*
    func tapBuildingCell(at index: Int) {
        let info: [Building] = model.buildings!
        mapPresenter.addAnnotation(with: info, at: index)
    }*/
    
    func tapDefaultSearchResultCell(at index: Int) {
        let info: [Location] = model.defaultSearchResults!
        mapPresenter.addAnnotation(with: info, at: index)
    }
    
    func searchLocation(with query: String) {
        model.searchLocation(with: query)
    }
    
    func loadLocationSearchResult(at index: Int) -> MapSearchLocationObj {
        return model.locationSearchResults![index]
    }
    
    func loadDefaultSearchResults(defaultIndex: Int) {
        model.loadDefaultSearchResults(defaultIndex: defaultIndex)
    }
}

extension MapSearchViewPresenter: MapSearchModelDelegate {
    func searchModel() {
        view?.reloadData()
    }
}
