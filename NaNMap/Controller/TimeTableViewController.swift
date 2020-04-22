//
//  TimeTableViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/22.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

class TimeTableViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var customCellFlowLayout: CustomCellFlowLayout!
    
    static func instantinate() -> TimeTableViewController {
         return UIStoryboard(name: "TimeTable", bundle: nil).instantiateViewController(withIdentifier: "timeTableViewController") as! TimeTableViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        customCellFlowLayout = CustomCellFlowLayout()
    }
}


private extension TimeTableViewController {
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2.0
        layout.minimumInteritemSpacing = 2.0
        collectionView.collectionViewLayout = layout
    }
}


extension TimeTableViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeTableCell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}


extension TimeTableViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = collectionView.frame.width
        let viewHeight = collectionView.frame.height
        let customizedCell = customCellFlowLayout.customizeCell(indexPath: indexPath, viewWidth: viewWidth, viewHeight: viewHeight)
        let width = customizedCell.0
        let height = customizedCell.1
        return CGSize(width: width, height: height)
    }
}
