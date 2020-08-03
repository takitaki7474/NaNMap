//
//  ClassInformationView.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/08/01.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

class ClassInformationView: UIView {
    @IBOutlet weak var courseItemLabel: UILabel!
    @IBOutlet weak var locationItemLabel: UILabel!
    @IBOutlet weak var teacherItemLabel: UILabel!
    @IBOutlet weak var categoryItemLabel: UILabel!
    @IBOutlet weak var semesterItemLabel: UILabel!
    
    static func instantiate(frame: CGRect) -> ClassInformationView {
        let view = UINib(nibName: "ClassInformation", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ClassInformationView
        view.setViewStyle(frame: frame)
        return view
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setViewStyle(frame: CGRect) {
        self.frame = frame
        self.backgroundColor = .blue
        let lineSpace: CGFloat = 5.0
        let itemHeight: CGFloat = (frame.height - (lineSpace * 6.0)) / 5.0
        let itemWidth: CGFloat = 70.0
        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        setItem(label: courseItemLabel, point: CGPoint(x: lineSpace, y: lineSpace), size: itemSize, text: "Course")
        setItem(label: locationItemLabel, point: CGPoint(x: lineSpace, y: (lineSpace*2)+itemHeight), size: itemSize, text: "Location")
        setItem(label: teacherItemLabel, point: CGPoint(x: lineSpace, y: (lineSpace*3)+(itemHeight*2)), size: itemSize, text: "Teacher")
        setItem(label: categoryItemLabel, point: CGPoint(x: lineSpace, y: (lineSpace*4)+(itemHeight*3)), size: itemSize, text: "Category")
        setItem(label: semesterItemLabel, point: CGPoint(x: lineSpace, y: (lineSpace*5)+(itemHeight*4)), size: itemSize, text: "Semester")
    }
    
    private func setItem(label: UILabel, point: CGPoint, size: CGSize, text: String) {
        label.frame.origin = point
        label.frame.size = size
        label.backgroundColor = .gray
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = text
    }
}
