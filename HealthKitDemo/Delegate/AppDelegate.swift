//
//  AppDelegate.swift
//  HealthKitDemo
//
//  Created by Fish on 2022/10/9.
//

import UIKit
import HealthKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let isSupport = HKHealthStore .isHealthDataAvailable()
        if(isSupport) {


            /// 心率
            let heartRate =  HKQuantityType .quantityType(forIdentifier: .heartRate)
            /// 体重
            let bodyMass =  HKQuantityType .quantityType(forIdentifier: .bodyMass)
            /// 高度
            let height =  HKQuantityType .quantityType(forIdentifier: .height)
            /// 步数
            let stepCount =  HKQuantityType .quantityType(forIdentifier: .stepCount)
            /// 睡眠
            let sleep =  HKObjectType.categoryType(forIdentifier: .sleepAnalysis)
            /// 卡路里活动能量
            let energy = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)
            /// 温度
            let bodyTemperature = HKQuantityType.quantityType(forIdentifier: .bodyTemperature)
            /// 血糖
            let bloodGlucose = HKQuantityType.quantityType(forIdentifier: .bloodGlucose)
            let set = NSSet(objects: height!,bodyMass!,heartRate!,stepCount!,bodyTemperature!,bloodGlucose!)
            var redSet = NSSet(objects: height!,bodyMass!,heartRate!,stepCount!,sleep!,energy!,bodyTemperature!,bloodGlucose!)
            if #available(iOS 14.0, *) {
                /// 洗手
                let handwashing = HKQuantityType.categoryType(forIdentifier: .handwashingEvent)
                redSet = NSSet(objects: height!,bodyMass!,heartRate!,stepCount!,sleep!,energy!,handwashing!,bloodGlucose!,bodyTemperature!)
            }
            let healthStore = HKHealthStore.init()
            
            healthStore.requestAuthorization(toShare: set as? Set<HKSampleType>, read: redSet as? Set<HKObjectType>) { sucess, error in
                
                print(sucess)
            }
            
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

