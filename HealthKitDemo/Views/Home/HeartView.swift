//
//  HealthBaseInfoView.swift
//  HealthKit-Example
//
//  Created by Fish on 2022/10/9.
//
import UIKit
import HealthKit

class HeartView: HealthBaseInfoView {
    
    @IBOutlet weak var heartLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.roundCorners(cornerRadius: self.frame.width/5, maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        
        
        self.getHealthInfoOfQuantityType(type: .heartRate, HKUnit.init(from: "count/min")) { lastRecord in
            DispatchQueue.main.async {
                self.heartLabel.text = String(format: "%@", Int(lastRecord).description)
            }
        }
      
        

    }
}
