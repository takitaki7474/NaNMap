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
    var numberOfDefaultSearchBuildingList: Int { get }
    func setUpDefaultSearchResult(at index: Int)
    func setUpDefaultSearchInfo()
    func loadDefaultSearchTitleList(at index: Int) -> String
    func loadDefaultSearchBuildingList(at index: Int) -> String
}

final class SearchViewPresenter: SearchPresenter {
    var model = SearchModel()
    
    var numberOfDefaultSearchTitleList: Int {
        return model.defaultSearchTitleList.count
    }
    
    var numberOfDefaultSearchBuildingList: Int {
        return model.defaultSearchBuildingList.count
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
    
    func loadDefaultSearchBuildingList(at index: Int) -> String {
        return model.defaultSearchBuildingList[index]
    }

    
}
