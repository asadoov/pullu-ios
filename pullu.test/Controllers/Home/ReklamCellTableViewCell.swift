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
    @IBOutlet weak var aImage: UIImageView!
    @IBOutlet weak var aTitle: UILabel!
    
    @IBOutlet weak var aPrice: UILabel!
    @IBOutlet weak var aInfo: UILabel!
    @IBOutlet weak var aDate: UILabel!
    @IBOutlet weak var aType: UILabel!
    @IBOutlet weak var aViews: UILabel!
    @IBOutlet weak var aCategory: UILabel!
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
    
    @IBOutlet weak var advertClick: UIView!
    
    func reloadData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        var dt = dateFormatter.date(from: object!.cDate!)
        dateFormatter.dateFormat = "EEEE, dd MMMM"
        aTitle.text=object?.name
        aInfo.text=object?.description
        aType.text=object?.aTypeName
        aCategory.text=object?.catName
        aPrice.text="\(object!.price!) AZN "
        aDate.text=dateFormatter.string(from:dt!)
        
        if  object?.photo != nil{
            self.aImage.image=UIImage(data: object!.photo!)
        }
        else  {
            aImage.image=UIImage(named: "background")
            let loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
            loadingIndicator.center=CGPoint(x: aImage.bounds.size.width/2, y: aImage.bounds.size.height/2)
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.color = UIColor.lightGray
            // loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating();
            aImage.addSubview(loadingIndicator)
            
            //present(alert, animated: true, completion: nil)
            
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
