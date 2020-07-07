//
//  SyllabusSearchViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/28.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//
protocol SyllabusSearchPresenter {
    var view: SyllabusSearchView? { get set }
    func loadSyllabus()
    func loadTappedScheduleSyllabus(by classSchedule: String)
}

class SyllabusSearchViewPresenter: SyllabusSearchPresenter {
    private let model = SyllabusSearchModel()
    weak var view: SyllabusSearchView?
    
    init() {
        model.delegate = self
    }
    
    func loadSyllabus() {
        model.loadSyllabus()
    }
    
    func loadTappedScheduleSyllabus(by classSchedule: String) {
        model.loadTappedScheduleSyllabus(by: classSchedule)
    }
}

extension SyllabusSearchViewPresenter: SyllabusSearchModelDelegate {
    func searchModel() {
        view?.reloadData()
    }
}
