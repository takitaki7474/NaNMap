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
    /*
     static func instantinate() -> ClassInformationView {
        let view = UINib(nibName: "ClassInformation", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ClassInformationView
        return view
    }*/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func initNib() {
        guard let view = UINib(nibName: "ClassInformation", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        //view.frame = self.bounds
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        testLabel.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        view.backgroundColor = .white
        self.addSubview(view)
    }
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
    }*/
}
