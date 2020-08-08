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
    func alertWillAddTimeTable(with scheduleText: String, at index: Int)
}

class SyllabusSearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var timeTablePresenter: TimeTablePresenter!
    private var syllabusSearchPresenter: SyllabusSearchPresenter!
    private var searchController: UISearchController!
    private var classSchedule: String!
    private var classScheduleIndex: Int!
    
    static func instantiate(syllabusSearchPresenter: SyllabusSearchPresenter, classSchedule: String, classScheduleIndex: Int) -> SyllabusSearchViewController {
        let controller = UIStoryboard(name: "TimeTable", bundle: nil).instantiateViewController(withIdentifier: "syllabusSearchViewController") as! SyllabusSearchViewController
        controller.syllabusSearchPresenter = syllabusSearchPresenter
        controller.classSchedule = classSchedule
        controller.classScheduleIndex = classScheduleIndex
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
        let filterButton = UIBarButtonItem(title: "フィルタ", style: .done, target: self, action: #selector(tapFilterButton))
        filterButton.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = filterButton
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
    
    @objc func tapFilterButton() {
        let vc = SyllabusFilterViewController.instantiate(syllabusSearchPresenter: syllabusSearchPresenter)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
}

extension SyllabusSearchViewController: SyllabusSearchView {
    func reloadData() {
        tableView.reloadData()
    }
    
    func alertWillAddTimeTable(with scheduleText: String, at index: Int) {
        let alert = UIAlertController(title: "時間割の追加", message: "この講義を"+scheduleText+"に追加しますか?", preferredStyle: UIAlertController.Style.actionSheet)
        let defaultAction = UIAlertAction(title: scheduleText+"に追加する", style: UIAlertAction.Style.default, handler: {
            (action:UIAlertAction) -> Void in
            self.syllabusSearchPresenter.loadSelectedSyllabus(at: index, classScheduleIndex: self.classScheduleIndex)
            self.navigationController?.popViewController(animated: true)
        })
        let cancelAction = UIAlertAction(title: "戻る", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction) -> Void in
        })
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        let screenSize = UIScreen.main.bounds
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
        present(alert, animated: true)
    }
}

extension SyllabusSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return syllabusSearchPresenter.numberOfSyllabusSearchResult
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "syllabusTableViewCell", for: indexPath) as! SyllabusTableViewCell
        let subjectObj = syllabusSearchPresenter.loadSyllabusSearchResult(at: indexPath.row)
        cell.display(semester: subjectObj!.semester + subjectObj!.schedule)
        cell.display(subjectName: subjectObj!.subjectName)
        cell.display(classroom: subjectObj!.classroom?.classroom)
        cell.display(teacher: subjectObj!.teacher)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        syllabusSearchPresenter.setAlertWillAddTimeTable(with: self.classSchedule, at: indexPath.row)
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.endEditing(true)
    }
}
