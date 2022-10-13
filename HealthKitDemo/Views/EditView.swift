//
//  EditView.swift
//  HealthKitDemo
//
//  Created by Fish on 2022/10/11.
//

import UIKit
import HealthKit
class EditView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    var quantityType: HKQuantityTypeIdentifier?
    var categoryType: HKCategoryTypeIdentifier?
    var unit: HKUnit?
    var startDate: Date?
    var endDate: Date?
    @IBOutlet weak var inputTextField: UITextField!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
     @IBAction func cancelAction(_ sender: Any) {
         self .removeFromSuperview()

     }
     override func draw(_ rect: CGRect) {
         
         
        // Drawing code
         
         
    }
     @IBAction func sureAction(_ sender: Any) {
         
        let defalutStartDate = Calendar.current.date(byAdding: DateComponents(day: -1), to: Date())!

         HealthManager.shared.saveUserHealthInfoOfQuantityType(type: quantityType!, startDate: startDate ?? defalutStartDate, endDate: endDate ?? Date(), unit, num: Double(self.inputTextField.text ?? "0")!) { sucess in
             DispatchQueue.main.async {
                 self .removeFromSuperview()

             }

         }

     }
     

}
