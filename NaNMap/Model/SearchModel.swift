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
    var defaultSearchTitleList = [String]()
    var defaultBuildingInfo: [BuildingInfo]?
    var defaultBuildingList = [String]()
    
    init() {
        let path = Bundle.main.path(forResource: "DefaultSearchInfo", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        self.data = try? Data(contentsOf: url)
    }
    
    func setUpDefaultSearchInfo() {
        let decoder = JSONDecoder()
        guard let defaultSearchInfo = try? decoder.decode(DefaultSearchInfo.self, from: self.data!) else {
            return
        }
        self.defaultSearchInfo = defaultSearchInfo
        
        let sectionIndex = 0
        for row in defaultSearchInfo.section[sectionIndex].row {
          defaultSearchTitleList.append(row.title)
        }
    }
    
    func setUpDefaultSearchResult(at index: Int) {
        defaultBuildingInfo = defaultSearchInfo!.section[0].row[index].nextPage
        defaultBuildingList = []
        
        for buildingInfo in defaultBuildingInfo! {
            defaultBuildingList.append(buildingInfo.building)
        }
    }
    
}
