//
//  SearchModel.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/16.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation

final class MapSearchModel {
    private var data: Data?
    /*
    var defaultSearchInfo: DefaultSearchInfo?
    var defaultSearchTitleList = [String]()
    var defaultBuildingInfo: [BuildingInfo]?
    var defaultBuildingList = [String]()*/
    var buildings: [Building]?
    
    init() {
        loadBuildings()
        /*
        let path = Bundle.main.path(forResource: "DefaultSearchInfo", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        self.data = try? Data(contentsOf: url)*/
    }
    
    func loadBuildings() {
        let path = Bundle.main.path(forResource: "Buildings", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        let decoder = JSONDecoder()
        guard let buildings = try? decoder.decode([Building].self, from: data!) else {
            return
        }
        self.buildings = buildings
    }
    /*
    func setUpDefaultSearchInfo() {
        let decoder = JSONDecoder()
        guard let defaultSearchInfo = try? decoder.decode(DefaultSearchInfo.self, from: self.data!) else {
            return
        }
        self.defaultSearchInfo = defaultSearchInfo
        
        let sectionIndex = 0
        for row in defaultSearchInfo.section[sectionIndex].row {
            self.defaultSearchTitleList.append(row.title)
        }
    }*/
    /*
    func setUpDefaultSearchResult(at index: Int) {
        self.defaultBuildingInfo = defaultSearchInfo!.section[0].row[index].nextPage
        self.defaultBuildingList = []
        for buildingInfo in defaultBuildingInfo! {
            self.defaultBuildingList.append(buildingInfo.building)
        }
    }*/
}
