//
//  SyllabusSearchViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/28.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

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
        navigationItem.hidesBackButton = false
        navigationItem.title = self.classSchedule + "のシラバス"
        setUpSearchController()
    }
    
    func setUpSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = true
        let searchBar = searchController.searchBar
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
}

extension SyllabusSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath)
        return cell
    }
}
