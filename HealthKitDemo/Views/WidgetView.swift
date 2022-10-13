//
//  WidgetView.swift
//  HealthKitDemo
//
//  Created by Fish on 2022/10/10.
//

import UIKit

class WidgetView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()

        self.roundCorners(cornerRadius: self.frame.width/5, maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        
        self.backgroundColor = UIColor(named: "MainBGColor")
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "SubPointColor")?.cgColor
    }

}
