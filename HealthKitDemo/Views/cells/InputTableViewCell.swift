//
//  InputTableViewCell.swift
//  HealthKitDemo
//
//  Created by Fish on 2022/10/11.
//

import UIKit

class InputTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
