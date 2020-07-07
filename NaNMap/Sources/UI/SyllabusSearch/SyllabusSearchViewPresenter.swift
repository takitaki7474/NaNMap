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
    func loadSyllabusSearchResult(at index: Int) -> SubjectObj?
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
    
    func loadSyllabusSearchResult(at index: Int) -> SubjectObj? {
        let subjectObj: SubjectObj? = model.syllabusSearchResult?[index]
        return subjectObj
    }
}

extension SyllabusSearchViewPresenter: SyllabusSearchModelDelegate {
    func searchModel() {
        view?.reloadData()
    }
}
