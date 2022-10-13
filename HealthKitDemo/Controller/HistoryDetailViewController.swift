//
//  HistoryDetailViewController.swift
//  HealthKitDemo
//
//  Created by Fish on 2022/10/11.
//

import UIKit
import HealthKit
class HistoryDetailViewController: UIViewController {

    var listData: [HKSample] = []
    var quantityType:HKQuantityTypeIdentifier?
    var categoryType:HKCategoryTypeIdentifier?
    var unit:HKUnit?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibName = UINib(nibName: "DetailTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "DetailTableViewCell")
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 44
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        
        let startDate = Calendar.current.date(byAdding: DateComponents(day: -7), to: Date())!
        
        if let quantityType = quantityType {
            
            HealthManager.shared.fetchUserHealthInfoOfQuantityType(startDate: startDate, endDate: Date(), type: quantityType) { array in
                
                DispatchQueue.main.async {
                
                    self.listData = array
                    self.tableView.reloadData()
                }
            }
        }
        if let categoryType = categoryType {
            
            HealthManager.shared.fetchUserHealthInfoOfCategoryType(startDate: startDate, endDate: Date(), type: categoryType) { array in
                
                DispatchQueue.main.async {
                
                    self.listData = array
                    self.tableView.reloadData()
                }
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HistoryDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as! DetailTableViewCell
        
        let heartSample = listData[indexPath.row] as? HKQuantitySample
        let heart = heartSample?.quantity.doubleValue(for:unit ?? HKUnit.count())
        cell.titleLabel.text = heart?.description
        let date = heartSample?.startDate
        let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "zh_CN")
        cell.timeLabel.text = dateFormatter.string(from: date!)
        return cell
    }
}
