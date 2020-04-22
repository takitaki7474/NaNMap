//
//  CustomCellFlowLayout.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/23.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//
import UIKit

class CustomCellFlowLayout {

    let firstCellOneSideSize: CGFloat
    var scheduleCellWidth: CGFloat?
    var scheduleCellHeight: CGFloat?
    
    init() {
        self.firstCellOneSideSize = 30.0
    }
    
    func customizeCell(indexPath: IndexPath, viewWidth: CGFloat, viewHeight: CGFloat) -> (width: CGFloat, height: CGFloat) {
        self.scheduleCellWidth = (viewWidth - self.firstCellOneSideSize - 2*6) / 6.0
        self.scheduleCellHeight = (viewHeight - self.firstCellOneSideSize - 2*5) / 5.0
        var width: CGFloat
        var height: CGFloat
        
        switch indexPath.row {
         case 0:
            width = self.firstCellOneSideSize
            height = self.firstCellOneSideSize
         case 1...6:
            width = self.scheduleCellWidth!
            height = self.firstCellOneSideSize
         case let index where index % 7 == 0:
            width = self.firstCellOneSideSize
            height = self.scheduleCellHeight!
         default:
            width = self.scheduleCellWidth!
            height = self.scheduleCellHeight!
         }
        return (width, height)
    }
}
