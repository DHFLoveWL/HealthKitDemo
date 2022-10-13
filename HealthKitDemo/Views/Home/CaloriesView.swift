//
//  HealthBaseInfoView.swift
//  HealthKit-Example
//
//  Created by Fish on 2022/10/9.
//

import UIKit
import HealthKit

class CaloriesView: HealthBaseInfoView {
    
    @IBOutlet weak var activityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.roundCorners(cornerRadius: self.frame.width/5, maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        
        self.getHealthInfoOfQuantityType(type: .activeEnergyBurned, HKUnit(from: "kcal")) {[unowned self] enger in
            
            DispatchQueue.main.async {
                self.activityLabel.text = Int(enger).description
            }
        }

    }
}
