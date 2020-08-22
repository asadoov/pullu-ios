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
import AVKit
protocol ReklamCellDelegate {
    
    func showViewersClick(cell: ReklamCellTableViewCell)
    
}

class ReklamCellTableViewCell: UITableViewCell {
    var player:AVPlayer?
    
    //    @IBOutlet weak var showViewers: UIButton!
    
    @IBOutlet weak var aImage: UIImageView!
    @IBOutlet weak var aTitle: UILabel!
    
    @IBOutlet weak var aView: UIView!
    @IBOutlet weak var aStatus: UILabel!
    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var aTypeImage: UIImageView!
    @IBOutlet weak var aPrice: UILabel!
    @IBOutlet weak var aInfo: UILabel!
    @IBOutlet weak var aDate: UILabel!
    //    @IBOutlet weak var aType: UILabel!
    //    @IBOutlet weak var aViews: UILabel!
    @IBOutlet weak var aCategory: UILabel!
    let loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    var object:Advertisement?
    
    //2. create delegate variable
    var delegate: ReklamCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func showViewersClick(_ sender: Any) {
        
        delegate?.showViewersClick(cell: self)
    }
    
    //    @IBOutlet weak var advertClick: UIView!
    //
    
    override func prepareForReuse() {
        
        aImage.image=UIImage(named: "background")
        
        loadingIndicator.center=CGPoint(x: aImage.bounds.size.width/2, y: aImage.bounds.size.height/2)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.color = UIColor.lightGray
        // loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        aImage.addSubview(loadingIndicator)
    }
    func reloadData() {
        if object != nil {
            aImage.layer.borderWidth = 1
            aImage.layer.borderColor = UIColor.gray.cgColor
            
            aView?.layer.borderWidth = 1
            aView?.layer.borderColor = UIColor.gray.cgColor
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
            aTitle.text=object?.name
            // aInfo.text=object?.description
            // if aType != nil { aType.text=object?.aTypeName}
            if aTypeImage != nil {
                
                switch object?.aTypeId {
                case 1:
                    //metn
                    aTypeImage.image = UIImage(named: "text.png")
                case 2:
                    //shekil
                    aTypeImage.image = UIImage(named: "image.png")
                case 3:
                    //video
                    aTypeImage.image = UIImage(named: "video.png")
                default:
                    break
                }
            }
            if aStatus != nil {
                var statusText = "---"
                
                
                
                
                switch object?.isActive{
                case 1:
                    //metn
                    statusText = "Yayımlanır"
                    aStatus.backgroundColor = UIColor(red: 0.16, green: 0.65, blue: 0.27, alpha: 1.00)
                case 0:
                    //shekil
                    statusText = "Gözləyir"
                    aStatus.backgroundColor = UIColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 1.00)
                    
                default:
                    break
                }
                if ((object!.views! >= object!.tariffViewCount!)&&object!.isPaid!==1) {
                    
                    statusText = "Vaxtı bitib"
                    aStatus.backgroundColor = UIColor(red: 0.42, green: 0.46, blue: 0.49, alpha: 1.00)
                }
                
                aStatus.text = statusText
            }
            
            if aCategory != nil { aCategory.text=object?.catName}
            if object!.price! == "Razılaşma yolu ilə" {
                
                // aPrice.text="\(object!.price!)"
                aPrice.text=" Razılaşma "
            }
            else  {
                
                aPrice.text="\(object!.price!) AZN "
            }
            //aDate.text=dateFormatter.string(from:dt!)
            //
            
            
            if object?.aTypeId == 1 || object?.aTypeId == 2
            {
                if object?.photo != nil {
                    
                    self.aImage.image=UIImage(data: object!.photo!)
                    
                }
                else {
                    if object?.downloaded == true {
                        aImage.image=UIImage(named: "damaged")
                        //loadingIndicator.stopAnimating()
                    }
                    
                }
                
                loadingIndicator.stopAnimating()
            }
            if object!.aTypeId == 3 {
                do {
                    let sourceURL = URL(string: (object?.photoUrl?[0]) ?? "")
                     let asset = AVAsset(url: sourceURL!)
                     let imageGenerator = AVAssetImageGenerator(asset: asset)
                     let time = CMTimeMake(value: 1, timescale: 60)
                     let imageRef = try! imageGenerator.copyCGImage(at: time, actualTime: nil)
                     let thumbnail = UIImage(cgImage:imageRef)
                    
                         DispatchQueue.main.async {
                         self.aImage.image=thumbnail
                         }
                         
                    
                }
                catch {
                    
                    DispatchQueue.main.async {
                                            self.aImage.image=UIImage(named: "damaged")
                                            }
                                            
                }
                
               
                //                let videoURL = URL(string: (object?.photoUrl![0])!)
                //                self.player = AVPlayer(url: videoURL!)
                //
                //                let playerLayer = AVPlayerLayer(player:self.player )
                //
                //                DispatchQueue.main.async {
                //                    playerLayer.frame = self.aImage.frame
                //                    self.aImage.layer.addSublayer(playerLayer)
                //                    //                          self.player?.play()
                //                }
                loadingIndicator.stopAnimating()
            }
            
            
            
            
            
            
            
            //        else  {
            //
            //
            //            if object?.aTypeId != 3{
            //
            //
            //                aImage.image=UIImage(named: "background")
            //                let loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
            //                loadingIndicator.center=CGPoint(x: aImage.bounds.size.width/2, y: aImage.bounds.size.height/2)
            //                loadingIndicator.hidesWhenStopped = true
            //                loadingIndicator.color = UIColor.lightGray
            //                // loadingIndicator.style = UIActivityIndicatorView.Style.gray
            //                loadingIndicator.startAnimating();
            //                aImage.addSubview(loadingIndicator)
            //            }
            //            else   {
            //                let label = UILabel()
            //                label.center = CGPoint(x: aImage.bounds.size.width/2, y: aImage.bounds.size.height/2)
            //
            //                // you will probably want to set the font (remember to use Dynamic Type!)
            //                label.font = UIFont.preferredFont(forTextStyle: .footnote)
            //
            //                // and set the text color too - remember good contrast
            //                label.textColor = .black
            //
            //                // may not be necessary (e.g., if the width & height match the superview)
            //                // if you do need to center, CGPointMake has been deprecated, so use this
            //
            //
            //                // this changed in Swift 3 (much better, no?)
            //                label.textAlignment = .center
            //
            //                label.text = "I am a test label"
            //
            //                aImage.addSubview(label)
            //
            //
            //            }
            //
            //
            //        }
            
            
            
            
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
}
