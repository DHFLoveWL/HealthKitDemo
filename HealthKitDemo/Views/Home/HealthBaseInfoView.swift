//
//  HealthBaseInfoView.swift
//  HealthKit-Example
//
//  Created by Fish on 2022/10/9.
//

import UIKit
import HealthKit

@objc protocol GetHealthInfoProtocol {
    
    /// 根据类型获取健康信息，比如身高，体重等
    @objc optional func getHealthInfoOfQuantityType(type:HKQuantityTypeIdentifier, _ unit:HKUnit?, completion: (@escaping (Double) -> Void));
    /// 根据类型获取健康信息，比如身高，体重等
    @objc optional  func getHealthInfoOfCategoryType(type:HKCategoryTypeIdentifier, _ unit:HKUnit?, completion: (@escaping ([HKSample]) -> Void));
    
}


class HealthBaseInfoView: UIView, GetHealthInfoProtocol {
    let healthStore = HKHealthStore()
    func getHealthInfoOfCategoryType(type: HKCategoryTypeIdentifier, _ unit:HKUnit?, completion: @escaping (([HKSample]) -> Void)) {
        let categoryType = HKQuantityType.categoryType(forIdentifier: type)!
        let calendar = Calendar.current
        let now = NSDate()
        let componsssss :Set<Calendar.Component> = [Calendar.Component.day,Calendar.Component.month,Calendar.Component.year]
        var components = calendar.dateComponents(componsssss, from: now as Date)
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        let startDate = calendar.date(from: components)
        let endDate = calendar.date(byAdding: Calendar.Component.day, value: 1, to: startDate!)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let query = HKSampleQuery.init(sampleType: categoryType,
                                       predicate: predicate,
                                       limit: HKObjectQueryNoLimit,
                                       sortDescriptors:  [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]){ _, results, _ in
            guard let result = results else {
                return completion([])
            }
            
            return completion(result)
        }
        healthStore.execute(query)
    }
    
    
    func getHealthInfoOfQuantityType(type: HKQuantityTypeIdentifier, _ unit:HKUnit?,  completion: @escaping ((Double) -> Void)) {
        let quantityType = HKQuantityType.quantityType(forIdentifier: type)!
        let calendar = Calendar.current
        let now = NSDate()
        let componsssss :Set<Calendar.Component> = [Calendar.Component.day,Calendar.Component.month,Calendar.Component.year]
        var components = calendar.dateComponents(componsssss, from: now as Date)
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        var startDate = calendar.date(from: components)
        var endDate = calendar.date(byAdding: Calendar.Component.day, value: 1, to: startDate!)
        var predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        
        if(type == .heartRate){
            startDate = Calendar.current.date(byAdding: DateComponents(weekday: -1), to: Date())!
            predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
            let query = HKSampleQuery.init(sampleType:quantityType , predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { _, results, error in
                guard let result = results else {return completion(0.0) }
                /// 获取最新的心率数据
                let sample = result.first
                let heartSample = sample as? HKQuantitySample
                let heart = heartSample?.quantity.doubleValue(for: unit ??  HKUnit.count())
                completion(heart ?? 0.0)
                
            }
            
            healthStore.execute(query)
            
            
        }else{
            let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
                
                guard let result = result, let sum = result.sumQuantity() else {
                    return completion(0.0)
                }
                let doubleValue = sum.doubleValue(for: unit ?? HKUnit.count())
                return completion(doubleValue)
            }
            
            healthStore.execute(query)
        }
    }
    
}

    
   


extension UIView {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}

