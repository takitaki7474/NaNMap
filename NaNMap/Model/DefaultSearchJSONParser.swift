//
//  DefaultSearchJSONParser.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/20.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation

struct DefaultSearchJSONParser: DefaultSearchJSONParserProtocol {
    
    func parse(data: Data) -> DefaultSearchCandidates? {
        let decoder = JSONDecoder()
        guard let defaultSearchCandidates = try? decoder.decode(DefaultSearchCandidates.self, from: data) else {
            return nil
        }
        return defaultSearchCandidates
    }
}

protocol DefaultSearchJSONParserProtocol {
    func parse(data: Data) -> DefaultSearchCandidates?
}


