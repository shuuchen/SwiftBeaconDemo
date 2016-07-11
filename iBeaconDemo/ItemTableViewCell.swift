//
//  ItemTableViewCell.swift
//  iBeaconDemo
//
//  Created by Du Shuchen on 2016/06/09.
//  Copyright © 2016年 Shuchen Du. All rights reserved.
//

import UIKit
import CoreLocation

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var meters: UILabel!
    @IBOutlet weak var uuid: UILabel!
    @IBOutlet weak var major: UILabel!
    @IBOutlet weak var minor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
