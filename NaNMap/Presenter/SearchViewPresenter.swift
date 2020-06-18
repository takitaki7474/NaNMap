//
//  SearchViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/20.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation

/*
protocol SearchView {
    func fetchDefaultSearchCandidates(fetchResult: DefaultSearchCandidates)
}


final class SearchViewPresenter {
    
    private let view: SearchView
    private let JSONParser: DefaultSearchJSONParserProtocol
    
    init(view: SearchView, JSONParser: DefaultSearchJSONParserProtocol) {
        self.view = view
        self.JSONParser = JSONParser
    }
    
    func loadDefaultSearchCandidates() {
        let defaultSearchCandidates = self.JSONParser.parse()
        self.view.fetchDefaultSearchCandidates(fetchResult: defaultSearchCandidates!)
    }
}
 */
protocol SearchPresenter {
    var numberOfDefaultSearchTitleList: Int { get }
    var numberOfDefaultBuildingList: Int { get }
    func setUpDefaultSearchResult(at index: Int)
    func setUpDefaultSearchInfo()
    func loadDefaultSearchTitleList(at index: Int) -> String
    func loadDefaultBuildingList(at index: Int) -> String
    func tapDefaultBuildingCell(at index: Int)
}

final class SearchViewPresenter: SearchPresenter {
    private let model = SearchModel()
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
        print(model.defaultBuildingInfo!)
    }

    
}
