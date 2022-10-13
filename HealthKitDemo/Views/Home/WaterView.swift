//
//  HealthBaseInfoView.swift
//  HealthKit-Example
//
//  Created by Fish on 2022/10/9.
//

import UIKit
import HealthKit

class WaterView: HealthBaseInfoView {
    
    @IBOutlet weak var waterCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.roundCorners(cornerRadius: self.frame.width/5, maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        

        if #available(iOS 14.0, *) {
            self.getHealthInfoOfCategoryType(type: .handwashingEvent,nil) { array in
                
//                var totalCount = 0
//                for item in array {
//                    totalCount += item.
//                }
//
                DispatchQueue.main.async {
                    
                    self.waterCount.text = String(format: "%ld次", array.count)
                }
            }
        }
 
 

    }
}
