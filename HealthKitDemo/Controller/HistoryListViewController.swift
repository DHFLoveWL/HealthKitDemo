//
//  HistoryListViewController.swift
//  HealthKitDemo
//
//  Created by Fish on 2022/10/11.
//

import UIKit
import HealthKit

class HistoryListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let listData:[HealthModel] = [
        HealthModel(image:R.home_heart , name: T.list_heart),
        HealthModel(image:R.home_walk, name: T.list_step),

        HealthModel(image:R.home_calories , name: T.list_calories),

//        HealthModel(image:R.home_walk , name: T.list_sport),

        HealthModel(image:R.home_heart , name: T.list_bload),

        HealthModel(image:R.home_calories , name: T.list_temperature),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    
     
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
extension HistoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell  else {
            return UITableViewCell.init()
        }
        let model = listData[indexPath.row]
        cell.icon.tintColor = UIColor.black
        cell.icon?.image = UIImage.init(named: model.image)
        if(model.image == "figure.walk"){
            cell.icon?.image = UIImage(systemName: model.image)
        }
        cell.nameLabel.text = model.name
        return cell
    
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.listData[indexPath.row]
        let vc =  HistoryDetailViewController()
        vc.title = item.name

        switch indexPath.row {
            
        case 0:
            vc.quantityType = .heartRate
            vc.unit = HKUnit.init(from: "count/min")
            break
        case 1:
            vc.quantityType = .stepCount
            
            break
        case 2:
            vc.quantityType = .activeEnergyBurned
            vc.unit = HKUnit(from: "kcal")
            break
//        case 3:
//            vc.quantityType = .electrodermalActivity
//
//            break
        case 3:
            vc.quantityType = .bloodGlucose
            vc.unit = HKUnit(from: "oz/fl_oz_us")

            break
        case 4:
            vc.quantityType = .bodyTemperature
            vc.unit = HKUnit(from: "degC")//摄氏度
            break
        case 6:
            vc.quantityType = .electrodermalActivity
            
            break
        default:
            break
            
        }
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    
}
