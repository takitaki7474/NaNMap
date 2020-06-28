//
//  SyllabusSearchModel.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/28.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//
import Foundation

class SyllabusSearchModel {
    private var data: Data?
    var syllabus: Syllabus?
    
    init() {
        let path = Bundle.main.path(forResource: "Syllabus", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        self.data = try? Data(contentsOf: url)
    }
    
    func loadSyllabus() {
        let decoder = JSONDecoder()
        guard let syllabus = try? decoder.decode(Syllabus.self, from: self.data!) else {
            print("error")
            return
        }
        self.syllabus = syllabus
    }
    
}
