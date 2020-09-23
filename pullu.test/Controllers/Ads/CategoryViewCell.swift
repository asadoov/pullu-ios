//
//  CategoryViewCell.swift
//  pullu.test
//
//  Created by Rufat on 2/28/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
    var object: CategoryStruct?
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    func reloadData() {
     self.categoryLabel.text=object?.name!
        if object?.downloadedIco != nil {
       self.catImage.image=UIImage(data: object!.downloadedIco!)
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
