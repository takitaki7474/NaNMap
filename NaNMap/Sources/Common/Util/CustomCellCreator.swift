//
//  CustomCellFlowLayout.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/23.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//
import UIKit

class CustomTimeTableCellCreator {
    
    func customizeCollectionView(collectionView: UICollectionView) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2.0
        layout.minimumInteritemSpacing = 2.0
        collectionView.collectionViewLayout = layout
        collectionView.layer.borderColor = UIColor.white.cgColor
        collectionView.layer.borderWidth = 2
    }
    
    func customizeCellDesign(cell: UICollectionViewCell) -> UICollectionViewCell {
        cell.backgroundColor = UIColor.rgba(red: 186, green: 193, blue: 234)
        cell.layer.cornerRadius = 4
        return cell
    }
    
    func customizeCellSizeFlowLayout(indexPath: IndexPath, collectionView: UICollectionView) -> CGSize {
        let firstCellOneSideSize: CGFloat = 30.0
        let collectionViewWidth = collectionView.frame.width
        let collectionViewHeight = collectionView.frame.height
        let cellWidth: CGFloat
        let cellHeight: CGFloat
        switch indexPath.row {
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
    
    func customizeCellLabelFlowLayout(indexPath: IndexPath, cell: UICollectionViewCell) -> UICollectionViewCell {
        let dayOfWeek: [String] = ["月", "火", "水", "木", "金", "土"]
        let period: [String] = ["1", "2", "3", "4", "5"]
        let cellLabel = cell.contentView.viewWithTag(1) as? UILabel
        cellLabel?.textColor = .black
        cellLabel?.textAlignment = .center
        cellLabel?.center.x = cell.frame.width/2.0
        cellLabel?.center.y = cell.frame.height/2.0
        
        switch indexPath.row {
        case 0:
            cellLabel?.text = ""
        case 1...6:
            cellLabel?.text = dayOfWeek[indexPath.row - 1]
        case let index where index % 7 == 0:
            cellLabel?.text = period[(indexPath.row / 7) - 1]
        default:
            cellLabel?.text = ""
        }
    
        return cell
    }
}
