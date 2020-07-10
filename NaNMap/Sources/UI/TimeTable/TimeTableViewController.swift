//
//  TimeTableViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/22.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

protocol TimeTableView: class {
    func alertWillSearchSyllabus(with text: String)
}

class TimeTableViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var timeTablePresenter: TimeTablePresenter!
    private var syllabusSearchPresenter: SyllabusSearchPresenter!
    private var cellCreator: CustomTimeTableCellCreator!
    
    static func instantinate() -> TimeTableViewController {
        let controller = UIStoryboard(name: "TimeTable", bundle: nil).instantiateViewController(withIdentifier: "timeTableViewController") as! TimeTableViewController
        controller.timeTablePresenter = TimeTableViewPresenter(view: controller)
        controller.syllabusSearchPresenter = SyllabusSearchViewPresenter(preseter: controller.timeTablePresenter)
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cellCreator = CustomTimeTableCellCreator()
        setUpCollectionView()
        setUpNavigationBar()
    }
}

private extension TimeTableViewController {
    private func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.rgba(red: 85,green: 104,blue: 211)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "時間割"
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        cellCreator.customizeCollectionView(collectionView: collectionView)
    }
}

extension TimeTableViewController: TimeTableView {
    func alertWillSearchSyllabus(with text: String) {
        let alert = UIAlertController(title: "時間割の編集", message: text+"の講義を編集しますか?", preferredStyle: UIAlertController.Style.actionSheet)
        let defaultAction = UIAlertAction(title: text+"の講義を検索する", style: UIAlertAction.Style.default, handler: {
            (action:UIAlertAction) -> Void in
            let vc = SyllabusSearchViewController.instantinate(syllabusSearchPresenter: self.syllabusSearchPresenter, classSchedule: text)
            self.navigationController?.pushViewController(vc, animated: true)
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

extension TimeTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeTableCell", for: indexPath) as! CustomTimeTableCell
        cell = cellCreator.customizeCellDesign(cell: cell)
        cell = cellCreator.customizeCellLabelFlowLayout(indexPath: indexPath, cell: cell)
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let canClickCell = !(indexPath.row <= 6 || indexPath.row % 7 == 0)
        if canClickCell {
            timeTablePresenter.setAlertText(at: indexPath.row)
        }
    }
}

extension TimeTableViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = cellCreator.customizeCellSizeFlowLayout(indexPath: indexPath, collectionView: collectionView)
        return cellSize
    }
}
