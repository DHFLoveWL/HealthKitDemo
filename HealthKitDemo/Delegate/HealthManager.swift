//
//  HealthMaanger.swift
//  HealthKitDemo
//
//  Created by Fish on 2022/10/11.
//

import UIKit
import HealthKit
class HealthManager: NSObject {
    
    static let shared = HealthManager()
    
    let healthStore = HKHealthStore()

}

extension HealthManager: GetHealthInfoProtocol {
    
  
    /// 获取用户心率
    func fetchUserHeartRateWithTimeQuantum(startDate:Date,endDate:Date,completion: (@escaping ([HKSample]) -> Void)) {
        
        let categoryType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let query = HKSampleQuery.init(sampleType: categoryType,
                                       predicate: predicate,
                                       limit: HKObjectQueryNoLimit,
                                       sortDescriptors:  [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]){ _, results, _ in
            guard let result = results else { return }
            return completion(result)
        }
        healthStore.execute(query)
    }
    
    
    /// 获取CategoryType类型的数组信息
    func fetchUserHealthInfoOfCategoryType(startDate:Date,endDate:Date,type:HKCategoryTypeIdentifier,completion: (@escaping ([HKSample]) -> Void)) {
        
        let categoryType = HKCategoryType.categoryType(forIdentifier: type)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let query = HKSampleQuery.init(sampleType: categoryType,
                                       predicate: predicate,
                                       limit: HKObjectQueryNoLimit,
                                       sortDescriptors:  [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]){ _, results, _ in
            guard let result = results else { return }
            return completion(result)
        }
        healthStore.execute(query)
    }
    /// 获取quantityType类型的数组信息
    func fetchUserHealthInfoOfQuantityType(startDate:Date,endDate:Date,type:HKQuantityTypeIdentifier,completion: (@escaping ([HKSample]) -> Void)) {
        
        let quantityType = HKQuantityType.quantityType(forIdentifier: type)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let query = HKSampleQuery.init(sampleType: quantityType,
                                       predicate: predicate,
                                       limit: HKObjectQueryNoLimit,
                                       sortDescriptors:  [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]){ _, results, _ in
            guard let result = results else { return }
            return completion(result)
        }
        healthStore.execute(query)
    }
    
    /// 保存信息
    func saveUserHealthInfoOfCategoryType(type:HKCategoryTypeIdentifier,startDate:Date,endDate:Date,_ unit:HKUnit?,num:Int,completion: (@escaping (Bool) -> Void)) {
        let categoryType = HKCategoryType.categoryType(forIdentifier: type)!
        let categorySample =  HKCategorySample.init(type: categoryType, value: num, start: startDate, end: endDate)
        
        healthStore.save(categorySample) { sucess, error in
            completion(sucess)
            if sucess {
                print("写入数据成功")

            }else {
                print("写入数据成功")

            }
        }
        
    }
    /// 写入数据
    func saveUserHealthInfoOfQuantityType(type:HKQuantityTypeIdentifier,startDate:Date,endDate:Date,_ unit:HKUnit?,num:Double,completion: (@escaping (Bool) -> Void)) {
        
        let quantityType = HKQuantityType.quantityType(forIdentifier: type)!
        let quantityConsumed = HKQuantity.init(unit: unit ?? HKUnit.count(), doubleValue: num)
        

        let quantitySample = HKQuantitySample.init(type: quantityType, quantity: quantityConsumed, start: startDate, end: endDate)
        
        healthStore.save(quantitySample) { sucess, error in
            if sucess {
                print("写入数据成功")

            }else {
                print("写入数据成功")

            }
            completion(sucess)

        }

    }
    
}
