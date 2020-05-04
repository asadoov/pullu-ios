//
//  NotificationCell.swift
//  pullu.test
//
//  Created by Rufat Asadov on 2/9/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
 
    @IBOutlet weak var notificationTitle: UILabel!
    
    @IBOutlet weak var notificationBody: UILabel!
    var object:NotificationModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func reloadData() {
        self.notificationTitle.text=object?.title ?? ""
         self.notificationBody.text=object?.body ?? ""
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
