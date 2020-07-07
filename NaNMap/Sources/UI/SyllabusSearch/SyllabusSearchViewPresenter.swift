//
//  SyllabusSearchViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/28.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//
protocol SyllabusSearchPresenter {
    var view: SyllabusSearchView? { get set }
    var numberOfSyllabusSearchResult: Int { get }
    func loadSyllabus()
    func loadTappedScheduleSyllabus(by classSchedule: String)
}

class SyllabusSearchViewPresenter: SyllabusSearchPresenter {
    private let model = SyllabusSearchModel()
    weak var view: SyllabusSearchView?
    
    init() {
        model.delegate = self
    }
    
    var numberOfSyllabusSearchResult: Int {
        if let count = model.syllabusSearchResult?.count {
            return count
        } else {
            return 0
        }
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