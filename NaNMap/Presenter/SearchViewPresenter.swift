//
//  SearchViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/20.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation

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
