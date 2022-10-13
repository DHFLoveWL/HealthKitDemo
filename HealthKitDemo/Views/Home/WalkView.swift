//
//  HealthBaseInfoView.swift
//  HealthKit-Example
//
//  Created by Fish on 2022/10/9.
//

import HealthKit
import UIKit


class WalkView: HealthBaseInfoView {

    @IBOutlet weak var walkNumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.getHealthInfoOfQuantityType(type: .stepCount, nil) { steps in
            DispatchQueue.main.async {
                
                self.walkNumLabel.text = steps.description

            }
        }
        
    }
    
//    func getTodaysSteps(completion: @escaping (Int) -> Void) {
//        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
//
//        let now = Date()
//        let startOfDay = Date.yesterDayDate
//        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
//
//        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
//            guard let result = result, let sum = result.sumQuantity() else {
//                completion(0)
//                return
//            }
//            let doubleValue = sum.doubleValue(for: HKUnit.count())
//            completion(Int(doubleValue))
//        }
//
//        healthStore.execute(query)
//    }
}
