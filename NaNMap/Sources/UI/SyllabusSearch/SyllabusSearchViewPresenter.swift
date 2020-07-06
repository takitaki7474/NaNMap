//
//  SyllabusSearchViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/28.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//
protocol SyllabusSearchPresenter {
    func loadSyllabus()
    func loadTappedScheduleSyllabus(by classSchedule: String)
}

class SyllabusSearchViewPresenter: SyllabusSearchPresenter {
    private let model = SyllabusSearchModel()
    
    func loadSyllabus() {
        model.loadSyllabus()
    }
    
    func loadTappedScheduleSyllabus(by classSchedule: String) {
        model.loadTappedScheduleSyllabus(by: classSchedule)
    }
}
