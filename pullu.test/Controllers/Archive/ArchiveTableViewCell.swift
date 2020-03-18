//
//  ArchiveTableViewCell.swift
//  pullu.test
//
//  Created by Javidan Mirza on 3/18/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class ArchiveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var elanBashligi: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var pulluPulsuz: UILabel!
    @IBOutlet weak var imagevView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
