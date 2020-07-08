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
    var numberOfFilterList: Int { get }
    func loadSyllabus()
    func loadTappedScheduleSyllabus(by classSchedule: String)
    func loadSyllabusSearchResult(at index: Int) -> SubjectObj?
    func searchSyllabus(with query: String)
    func loadFilter(at index: Int) -> FilterEntity?
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
    
    var numberOfFilterList: Int {
        if let count = model.filterList?.count {
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
        return model.syllabusSearchResult?[index]
    }
    
    func searchSyllabus(with query: String) {
        model.searchSyllabus(with: query)
    }
    
    func loadFilter(at index: Int) -> FilterEntity? {
        return model.filterList?[index]
    }
}

extension SyllabusSearchViewPresenter: SyllabusSearchModelDelegate {
    func searchModel() {
        view?.reloadData()
    }
}
