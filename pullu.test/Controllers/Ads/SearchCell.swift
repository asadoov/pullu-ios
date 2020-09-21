//
//  SearchCell.swift
//  pullu
//
//  Created by Rufat on 9/9/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class AdCell: UICollectionViewCell {
    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var aCategoryLabel: UILabel!
    @IBOutlet weak var aTypeImage: UIImageView!
    @IBOutlet weak var aImage: UIImageView!
    @IBOutlet weak var aPriceLabel: UILabel!
    @IBOutlet weak var aTitle: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    let loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
       var object:Advertisement?
    var titleLabel:UILabel = UILabel()
    func createNotFoundImage() {
           self.titleLabel.text = "🤷🏼‍♂️"
           self.titleLabel.textColor = UIColor.black
           self.titleLabel.font = UIFont(name:"chalkboard SE", size: 58)
           
           self.titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: self.aImage!.frame.width - 10, height: 50))
           self.titleLabel.textAlignment = .center
           self.titleLabel.center = self.aImage.center
           self.aImage.addSubview(self.titleLabel)
       }
       func createLoadingIndicator() {
           self.loadingIndicator.center=CGPoint(x: self.aImage.bounds.size.width/2, y: self.aImage.bounds.size.height/2)
           self.loadingIndicator.hidesWhenStopped = true
           self.loadingIndicator.color = UIColor.lightGray
           
           self.aImage.addSubview(self.loadingIndicator)
           self.loadingIndicator.startAnimating()
       }
       func reloadData() {
           
           
           
           if object != nil {
               
               createNotFoundImage()
               createLoadingIndicator()
               
               
               
               
               aImage?.layer.borderWidth = 1
               aImage?.layer.borderColor = UIColor.gray.cgColor
               
               cellView?.layer.borderWidth = 1
               cellView?.layer.borderColor = UIColor.gray.cgColor
               //        paidCell.layer.borderWidth = 1.0
               //        paidCell.layer.borderColor = UIColor.lightGray.cgColor
               if cell != nil { cell.backgroundColor =  UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)}
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
               dateFormatter.timeZone = TimeZone.current
               dateFormatter.locale = Locale.current
               var dt = dateFormatter.date(from: object!.cDate!)
               //  dateFormatter.dateFormat = "EEEE, dd MMMM"
               dateFormatter.dateFormat = "dd.MM.yyyy"
               aTitle?.text=object?.name
               // aInfo.text=object?.description
               // if aType != nil { aType.text=object?.aTypeName}
               if aTypeImage != nil {
                   DispatchQueue.main.async {
                       switch self.object?.aTypeId {
                       case 1:
                           //metn
                           self.aTypeImage.image = UIImage(named: "text.png")
                       case 2:
                           //shekil
                           self.aTypeImage.image = UIImage(named: "image.png")
                       case 3:
                           //video
                           self.aTypeImage.image = UIImage(named: "video.png")
                       default:
                           break
                       }
                   }
               }
//               if aStatus != nil {
//                   var statusText = "---"
//                   
//                   
//                   
//                   
//                   switch object?.isActive{
//                   case 1:
//                       //metn
//                       statusText = "Yayımlanır"
//                       aStatus.backgroundColor = UIColor(red: 0.16, green: 0.65, blue: 0.27, alpha: 1.00)
//                   case 0:
//                       //shekil
//                       statusText = "Gözləyir"
//                       aStatus.backgroundColor = UIColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 1.00)
//                       
//                   default:
//                       break
//                   }
//                   if ((object!.views! >= object!.tariffViewCount!)&&object!.isPaid!==1) {
//                       
//                       statusText = "Vaxtı bitib"
//                       aStatus.backgroundColor = UIColor(red: 0.42, green: 0.46, blue: 0.49, alpha: 1.00)
//                   }
//                   
//                   aStatus.text = statusText
//               }
//               
//               if aCategory != nil { aCategory.text=object?.catName}
               if object!.price! == "Razılaşma yolu ilə" {
                   
                   // aPrice.text="\(object!.price!)"
                   aPriceLabel?.text=" Razılaşma "
               }
               else  {
                   
                   aPriceLabel?.text="\(object!.price!) AZN "
               }
               
               
               
               
               
               
               
               DispatchQueue.main.async {
                   self.aImage!.image=nil
                   
                   if self.object?.downloaded == true{
                       
                       if self.object?.photo != nil {
                           for subView in self.aImage.subviews {
                               subView.removeFromSuperview()
                           }
                           self.loadingIndicator.stopAnimating()
                           self.aImage!.image=UIImage(data:self.object!.photo!)
                       }
                       else {
                           
                           self.createNotFoundImage()
                           self.loadingIndicator.stopAnimating()
                       }
                       
                   }
                   else   {
                       self.createLoadingIndicator()
                       
                       
                       
                   }
               }
               
               
               
           }
           
           
           
           
       }
//    func reloadData() {
//      self.categoryLabel.text=object?.name!
//         if object?.downloadedIco != nil {
//        self.catImage.image=UIImage(data: object!.downloadedIco!)
//         }
//         // self.ReklamImage.contentMode = .scaleAspectFill
//         
//         
//         
//         /*Alamofire.request(object!.photoUrl!).responseImage { response in
//          if let catPicture = response.result.value {
//          self.ReklamImage.image=""
//          self.ReklamImage.contentMode = .scaleAspectFill
//          //print("image downloaded: \(catPicture)")
//          }
//          }*/
//         
//     }
}
