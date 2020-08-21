//
//  TimeTableViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/22.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

protocol TimeTableView: class {
    func reloadData()
    func alertWillSearchSyllabus(with text: String, at index: Int)
    func alertWillDeleteSyllabus(with text: String, at index: Int)
}

final class TimeTableViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    private var timeTablePresenter: TimeTablePresenter!
    private var syllabusSearchPresenter: SyllabusSearchPresenter!
    
    static func instantiate() -> TimeTableViewController {
        let controller = UIStoryboard(name: "TimeTable", bundle: nil).instantiateViewController(withIdentifier: "timeTableViewController") as! TimeTableViewController
        controller.timeTablePresenter = TimeTableViewPresenter(view: controller)
        controller.syllabusSearchPresenter = SyllabusSearchViewPresenter(preseter: controller.timeTablePresenter)
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpNavigationBar()
    }
}

private extension TimeTableViewController {
    private func setUpNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.rgba(red: 85,green: 104,blue: 211)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "時間割"
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPressed(recognizer:)))
        longPressRecognizer.delegate = self
        collectionView.addGestureRecognizer(longPressRecognizer)
        collectionView.customizeCollectionViewLayout()
    }
    
    @objc private func cellLongPressed(recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: point) {
            timeTablePresenter.setAlertWillDeleteSyllabus(at: indexPath.row)
        }
    }
}

extension TimeTableViewController: TimeTableView {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func alertWillSearchSyllabus(with text: String, at index: Int) {
        let alert = UIAlertController(title: "時間割の編集", message: text+"の講義を編集しますか?", preferredStyle: UIAlertController.Style.actionSheet)
        let searchAction = UIAlertAction(title: text+"の講義を検索する", style: UIAlertAction.Style.default, handler: {
            (action:UIAlertAction) -> Void in
            let vc = SyllabusSearchViewController.instantiate(syllabusSearchPresenter: self.syllabusSearchPresenter, classSchedule: text, classScheduleIndex: index)
            self.navigationController?.pushViewController(vc, animated: true)
        })
        let cancelAction = UIAlertAction(title: "戻る", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction) -> Void in
        })
        let cellStatus = self.timeTablePresenter.loadSavedSyllabus(at: index)
        if cellStatus.hasRegistered == true {
            let mapAction = UIAlertAction(title: text+"の講義場所を表示する", style: UIAlertAction.Style.default, handler: {
                (action:UIAlertAction) -> Void in
                let vc = ClassLocationViewController.instantiate(presenter: self.timeTablePresenter, index: index)
                self.navigationController?.pushViewController(vc, animated: true)
            })
            alert.addAction(mapAction)
        }
        alert.addAction(searchAction)
        alert.addAction(cancelAction)
        let screenSize = UIScreen.main.bounds
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
        present(alert, animated: true)
    }
    
    func alertWillDeleteSyllabus(with text: String, at index: Int) {
        let alert = UIAlertController(title: "時間割の削除", message: text+"の講義を削除しますか?", preferredStyle: UIAlertController.Style.actionSheet)
        let defaultAction = UIAlertAction(title: text+"の講義を削除する", style: UIAlertAction.Style.destructive, handler: {
            (action:UIAlertAction) -> Void in
            self.timeTablePresenter.unregisterSyllabus(at: index)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeTableCollectionViewCell", for: indexPath) as! TimeTableCollectionViewCell
        cell.presenter = timeTablePresenter
        cell.customizeCellStyle()
        cell.customizeCellLabelStyle(index: indexPath.row)
        cell.displayLabel(index: indexPath.row)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        timeTablePresenter.setAlertWillSearchSyllabus(at: indexPath.row)
    }
}

extension TimeTableViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = collectionView.customizeCellSizeFlowLayout(index: indexPath.row)
        return cellSize
    }
}
