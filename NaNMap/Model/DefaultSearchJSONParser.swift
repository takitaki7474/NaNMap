//
//  DefaultSearchJSONParser.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/20.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation


struct DefaultSearchJSONParser: DefaultSearchJSONParserProtocol {
    
    private var data: Data?
    
    init() {
        let path = Bundle.main.path(forResource: "DefaultSearchCandidates", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        self.data = try? Data(contentsOf: url)
    }
    
    func parse() -> DefaultSearchCandidates? {
        let decoder = JSONDecoder()
        guard let defaultSearchCandidates = try? decoder.decode(DefaultSearchCandidates.self, from: self.data!) else {
            return nil
        }
        return defaultSearchCandidates
    }
}


protocol DefaultSearchJSONParserProtocol {
    func parse() -> DefaultSearchCandidates?
}
