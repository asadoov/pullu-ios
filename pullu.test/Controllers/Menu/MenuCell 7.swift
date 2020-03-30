//
//  MenuCell.swift
//  pullu.test
//
//  Created by Rufat on 3/25/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var menuItem: UILabel!
    @IBOutlet weak var menuIcon: UIImageView!
    
    var object: MenuStruct?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func reloadData() {
        self.menuItem.text=object?.name!
        
        self.menuIcon.image=UIImage(data: object!.icon!)
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
