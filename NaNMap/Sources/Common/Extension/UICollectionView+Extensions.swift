//
//  UICollectionView+Extensions.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/07/12.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func customizeCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2.0
        layout.minimumInteritemSpacing = 2.0
        self.collectionViewLayout = layout
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
    }
    
    func customizeCellSizeFlowLayout(index: Int) -> CGSize {
        let firstCellOneSideSize: CGFloat = 30.0
        let collectionViewWidth = self.frame.width
        let collectionViewHeight = self.frame.height
        let cellWidth: CGFloat
        let cellHeight: CGFloat
        switch index {
            case 0:
                cellWidth = firstCellOneSideSize
                cellHeight = firstCellOneSideSize
            case 1...6:
                cellWidth = (collectionViewWidth - firstCellOneSideSize - 2*6) / 6.0
                cellHeight = firstCellOneSideSize
            case let index where index % 7 == 0:
                cellWidth = firstCellOneSideSize
                cellHeight = (collectionViewHeight - firstCellOneSideSize - 2*5) / 5.0
            default:
                cellWidth = (collectionViewWidth - firstCellOneSideSize - 2*6) / 6.0
                cellHeight = (collectionViewHeight - firstCellOneSideSize - 2*5) / 5.0
         }
        let cellSize = CGSize(width: cellWidth, height: cellHeight)
        return cellSize
    }
}
