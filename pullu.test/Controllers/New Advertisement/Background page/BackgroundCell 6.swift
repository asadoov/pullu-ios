//
//  CollectionViewCell.swift
//  pullu.test
//
//  Created by Rufat on 3/16/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class BackgroundCell: UICollectionViewCell {
    @IBOutlet weak var backgroundImageCell: UIImageView!
    
    var backgroundImage:BackroundImageStruct?
    func reloadData() {
        
       // backgroundImageCell.image=backgroundImage
//     self.categoryLabel.text=object?.name!
        if backgroundImage?.downloadedImg != nil {
            self.backgroundImageCell.image=UIImage(data: (backgroundImage?.downloadedImg)!)
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
