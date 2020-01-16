//
//  ReklamCellTableViewCell.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/10/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
protocol ReklamCellDelegate {
    func orderClick(object: Advertisement)
}

class ReklamCellTableViewCell: UITableViewCell {
    @IBOutlet weak var ReklamImage: UIImageView!
    @IBOutlet weak var ReklamTitle: UILabel!
    
    @IBOutlet weak var ReklamInfo: UILabel!
    @IBOutlet weak var ReklamDate: UILabel!
    @IBOutlet weak var ReklamType: UILabel!
    @IBOutlet weak var ReklamBaxish: UILabel!
    @IBOutlet weak var ReklamCategory: UILabel!
    var object: Advertisement?
    // var delegate: ReklamCellDelegate?
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
        if  object?.photo != nil{
            self.ReklamImage.image=UIImage(data: object!.photo!)
        }
        
        // self.ReklamImage.contentMode = .scaleAspectFill
        
        
        
        /*Alamofire.request(object!.photoUrl!).responseImage { response in
         if let catPicture = response.result.value {
         self.ReklamImage.image=""
         self.ReklamImage.contentMode = .scaleAspectFill
         //print("image downloaded: \(catPicture)")
         }
         }*/
        
    }
}
