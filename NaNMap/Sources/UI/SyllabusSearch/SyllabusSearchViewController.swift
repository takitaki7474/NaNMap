//
//  SyllabusSearchViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/28.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

protocol SyllabusSearchView: class {
    func reloadData()
}

class SyllabusSearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var timeTablePresenter: TimeTablePresenter!
    private var syllabusSearchPresenter: SyllabusSearchPresenter!
    private var searchController: UISearchController!
    private var classSchedule: String!
    
    static func instantinate(syllabusSearchPresenter: SyllabusSearchPresenter, classSchedule: String) -> SyllabusSearchViewController {
        let controller = UIStoryboard(name: "TimeTable", bundle: nil).instantiateViewController(withIdentifier: "syllabusSearchViewController") as! SyllabusSearchViewController
        controller.syllabusSearchPresenter = syllabusSearchPresenter
        controller.classSchedule = classSchedule
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        syllabusSearchPresenter.view = self
        setUpDefaultTableView()
        setUpNavigationBar()
    }
}

private extension SyllabusSearchViewController {
    func setUpDefaultTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        syllabusSearchPresenter.loadTappedScheduleSyllabus(by: classSchedule)
    }
    
    func setUpNavigationBar() {
        navigationItem.hidesBackButton = true
        let doneButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(tapDoneButton))
        doneButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = self.classSchedule + "のシラバス"
        setUpSearchController()
    }
    
    func setUpSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        let searchBar = searchController.searchBar
        searchBar.delegate = self
        searchBar.placeholder = "講義を検索"
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.tintColor = UIColor.gray
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = searchController
        } else {
            tableView.tableHeaderView = searchBar
        }
    }
    
    @objc func tapDoneButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension SyllabusSearchViewController: SyllabusSearchView {
    func reloadData() {
        tableView.reloadData()
    }
}

extension SyllabusSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return syllabusSearchPresenter.numberOfSyllabusSearchResult
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "syllabusCell", for: indexPath) as! CustomSyllabusCell
        let subjectObj = syllabusSearchPresenter.loadSyllabusSearchResult(at: indexPath.row)
        cell.semesterLabel.text = subjectObj!.semester + self.classSchedule
        cell.subjectLabel.text = subjectObj?.subjectName
        cell.classroomLabel.text = subjectObj?.classroom
        cell.teacherLabel.text = subjectObj?.teacher
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

extension SyllabusSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! != "" {
            syllabusSearchPresenter.searchSyllabus(with: searchController.searchBar.text!)
        }
    }
}

extension SyllabusSearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        syllabusSearchPresenter.loadTappedScheduleSyllabus(by: classSchedule)
    }
}
