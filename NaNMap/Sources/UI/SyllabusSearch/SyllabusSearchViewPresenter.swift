//
//  SyllabusSearchViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/28.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//
protocol SyllabusSearchPresenter {
    func loadSyllabus()
}

class SyllabusSearchViewPresenter: SyllabusSearchPresenter {
    private let timeTablePresenter: TimeTablePresenter!
    private let model = SyllabusSearchModel()
    
    init(timeTablePresenter: TimeTablePresenter) {
        self.timeTablePresenter = timeTablePresenter
    }
    
    func loadSyllabus() {
        model.loadSyllabus()
    }
}
