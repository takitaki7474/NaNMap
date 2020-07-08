//
//  FilterPopUpViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/07/08.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

class SyllabusFilterPopUpViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var syllabusSearchPresenter: SyllabusSearchPresenter!
    private var filter: [String] = ["宗教科目"]
    
    static func instantinate(syllabusSearchPresenter: SyllabusSearchPresenter) -> SyllabusFilterPopUpViewController {
        let controller = UIStoryboard(name: "TimeTable", bundle: nil).instantiateViewController(withIdentifier: "syllabusFilterPopUpViewController") as! SyllabusFilterPopUpViewController
        controller.syllabusSearchPresenter = syllabusSearchPresenter
        return controller
    }

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        setUpTableViewStyle()
        super.viewDidLoad()
    }
    
    func setUpTableViewStyle() {
        tableView.frame.size = CGSize(width: view.frame.width * 8/10, height: view.frame.height * 8/10)
        tableView.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension SyllabusFilterPopUpViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath)
        cell.textLabel?.text = filter[indexPath.row]
        return cell
    }
}
