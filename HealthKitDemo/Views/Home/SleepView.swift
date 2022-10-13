//
//  HealthBaseInfoView.swift
//  HealthKit-Example
//
//  Created by Fish on 2022/10/9.
//

import UIKit
import HealthKit
class SleepView: HealthBaseInfoView {
    
    @IBOutlet weak var sleepLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.roundCorners(cornerRadius: self.frame.width/5, maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner])
          
        
        self.getHealthInfoOfCategoryType(type: .sleepAnalysis,nil) { array in
            
            guard array != [] else {return}
            var totleSleep = 0.00;

            DispatchQueue.main.async {
                
                for item  in array {
                    
                    let quantitySample = item as! HKCategorySample
                    
                    if(quantitySample.value == 0 ) {
                        
                      let sleepTime =  quantitySample.endDate .timeIntervalSince(quantitySample.startDate)
                        totleSleep += sleepTime
                    }

                }
                print(totleSleep)
                
                self.sleepLabel.text =  String(format: "%.2fh", totleSleep/3600)

            }
            

            
        }
        

    }
    
    

}
