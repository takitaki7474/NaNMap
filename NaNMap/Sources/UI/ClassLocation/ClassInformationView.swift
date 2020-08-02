//
//  ClassInformationView.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/08/01.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

class ClassInformationView: UIView {
    @IBOutlet weak var testLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func initNib() {
        guard var view = UINib(nibName: "ClassInformation", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        view = setViewStyle(view: view)
        self.addSubview(view)
    }
    
    private func setViewStyle(view: UIView) -> UIView {
        view.frame = self.frame
        view.backgroundColor = .white
        testLabel.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        return view
    }
}
