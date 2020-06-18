//
//  StatisticsCell.swift
//  pullu.test
//
//  Created by Rufat on 5/8/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class StatisticsCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    var count:Int?
    var name:String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func reloadData() {
        
        
        
        nameLabel.text = name
        countLabel.text = String(count ?? 0)
        
    }
    
}
