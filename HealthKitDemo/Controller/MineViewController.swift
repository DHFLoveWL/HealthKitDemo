//
//  MineViewController.swift
//  HealthKitDemo
//
//  Created by Fish on 2022/10/11.
//

import UIKit
import HealthKit

class MineViewController: UIViewController {
    
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
        
        let nibName = UINib(nibName: "InputTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "InputTableViewCell")
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
extension MineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "InputTableViewCell", for: indexPath) as? InputTableViewCell  else {
            return UITableViewCell.init()
        }
        let model = listData[indexPath.row]
        cell.icon.tintColor = UIColor.black
        cell.icon?.image = UIImage.init(named: model.image)
        if(model.image == "figure.walk"){
            cell.icon?.image = UIImage(systemName: model.image)
        }
        
        cell.label.text = model.name
        return cell
    
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let item = self.listData[indexPath.row]
        
        let vc = Bundle.main.loadNibNamed("EditView", owner: nil, options: nil)?.last as! EditView
     
        vc.titleLabel.text = item.name

        switch indexPath.row {
            
        case 0:
            vc.quantityType = .heartRate
            vc.unit = HKUnit.init(from: "count/min")
            vc.startDate = Calendar.current.date(byAdding: DateComponents(minute: -1), to: Date())!
            break
        case 1:
            vc.quantityType = .stepCount
            vc.startDate = Calendar.current.date(byAdding: DateComponents(hour: -1,minute: -1), to: Date())!
            break
        case 2:
            vc.quantityType = .activeEnergyBurned
            vc.unit = HKUnit(from: "kcal")
            vc.startDate = Calendar.current.date(byAdding: DateComponents(hour: -1,minute: -1,second: -1), to: Date())!

            break
//        case 3:
//            vc.quantityType = .electrodermalActivity
//
//            break
        case 3:
            vc.quantityType = .bloodGlucose
            vc.unit = HKUnit(from: "oz/fl_oz_us")
            vc.startDate = Calendar.current.date(byAdding: DateComponents(minute: -1), to: Date())!
            break
        case 4:
            vc.quantityType = .bodyTemperature
            vc.unit = HKUnit(from: "degC")
            vc.startDate = Calendar.current.date(byAdding: DateComponents(second: -1), to: Date())!

            break
        case 6:
            vc.quantityType = .electrodermalActivity
            
            break
        default:
            break
            
        }
        
        self.view.addSubview(vc)
        

    }
    
    
    
}
