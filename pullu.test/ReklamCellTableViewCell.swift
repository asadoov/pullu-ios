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

    @IBOutlet weak var ReklamInfo: UILabel!
    @IBOutlet weak var ReklamDate: UILabel!
    @IBOutlet weak var ReklamType: UILabel!
    @IBOutlet weak var ReklamBaxish: UILabel!
    @IBOutlet weak var ReklamCategory: UILabel!
    var object: Advertisement?
    var delegate: ReklamCellTableViewCell?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
   
    func reloadData() {
        
        
        ReklamTitle.text=object?.name
        ReklamInfo.text=object?.description
        ReklamType.text=object?.aTypeName
        ReklamCategory.text=object?.catName
      /*  photoView.image = nil
        photoView.sd_setShowActivityIndicatorView(true)
        photoView.sd_setIndicatorStyle(.whiteLarge)
        photoView.sd_setImage(with: URL(string: Utility.getURLQuery((object?.photo)!)))
        titleLabel.text = object?.title
        descLabel.text = object?.desc
        priceButton.setTitle(object?.price, for: .disabled)*/
    }
}
