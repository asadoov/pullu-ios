//
//  ReklamCellTableViewCell.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/10/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class ReklamCellTableViewCell: UITableViewCell {
    @IBOutlet weak var ReklamImage: UIImageView!
    @IBOutlet weak var ReklamTitle: UILabel!
    @IBOutlet weak var ReklamInfo: UITextView!
    @IBOutlet weak var ReklamDate: UILabel!
    @IBOutlet weak var ReklamType: UILabel!
    @IBOutlet weak var ReklamBaxish: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
