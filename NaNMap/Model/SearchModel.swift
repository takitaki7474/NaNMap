//
//  SearchModel.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/16.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//
import Foundation

final class SearchModel {
    
    private var data: Data?
    var defaultSearchInfo: DefaultSearchInfo?
    var defaultSearchList = [String]()
    
    init() {
        let path = Bundle.main.path(forResource: "DefaultSearchInfo", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        self.data = try? Data(contentsOf: url)
    }
    
    func loadDefaultSearchInfo() {
        let decoder = JSONDecoder()
        guard let defaultSearchInfo = try? decoder.decode(DefaultSearchInfo.self, from: self.data!) else {
            return
        }
        self.defaultSearchInfo = defaultSearchInfo
    }
    
    func setUpDefaultSearchList() {
        let sectionIndex = 0
        for row in defaultSearchInfo!.section[sectionIndex].row {
          defaultSearchList.append(row.title)
        }
    }
    
    func makeDefaultBuildingInfo() {
        
    }
    
}