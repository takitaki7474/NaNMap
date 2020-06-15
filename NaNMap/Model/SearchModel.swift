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
    var defaultSearchCandidates: DefaultSearchCandidates?
    var defaultCellList = [String]()
    
    init() {
        let path = Bundle.main.path(forResource: "DefaultSearchCandidates", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        self.data = try? Data(contentsOf: url)
    }
    
    func loadDefaultSearchCandidates() {
        let decoder = JSONDecoder()
        guard let defaultSearchCandidates = try? decoder.decode(DefaultSearchCandidates.self, from: self.data!) else {
            return
        }
        self.defaultSearchCandidates = defaultSearchCandidates
    }
    
    func setUpDefaultCellList() {
        let sectionIndex = 0
        for row in defaultSearchCandidates!.section[sectionIndex].row {
          defaultCellList.append(row.title)
        }
    }
    
}
