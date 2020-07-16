//
//  InterestCell.swift
//  pullu.test
//
//  Created by Rufat Asadov on 7/15/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class ViewerCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameSurname: UILabel!
   let loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImage.layer.masksToBounds = true
        userImage!.layer.borderColor = UIColor.white.cgColor
        userImage!.layer.borderWidth = 1.5
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        
        loadingIndicator.center=CGPoint(x: userImage.bounds.size.width/2, y: userImage.bounds.size.height/2)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.color = UIColor.lightGray
        // loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        userImage.addSubview(loadingIndicator)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
