//
//  SyllabusSearchViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/28.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//
protocol SyllabusSearchPresenter {
    
}

class SyllabusSearchViewPresenter: SyllabusSearchPresenter {
    private let timeTablePresenter: TimeTablePresenter!
    
    init(timeTablePresenter: TimeTablePresenter) {
        self.timeTablePresenter = timeTablePresenter
    }
}
