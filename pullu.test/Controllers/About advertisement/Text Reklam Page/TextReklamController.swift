//
//  textReklamController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/23/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class TextReklamController: UIViewController {
    
    let defaults = UserDefaults.standard
    var advertID:Int?
    var select:DbSelect=DbSelect()
    var userData = Array<UserStruct>()
    var userToken:String?
    var requestToken:String?
    var fromArchieve:Bool = false
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var advertName: UILabel!
    
    @IBOutlet weak var aDescription: UITextView!
    @IBOutlet weak var sellerFullname: UILabel!
    
    @IBOutlet weak var sellerPhone: UITextView!
    
    
    @IBOutlet weak var earnMoney: UIButton!
    
    @IBOutlet weak var advertType: UILabel!
    @IBOutlet weak var advertPrice: UILabel!
    @IBOutlet weak var balance: UILabel!
    
    @IBOutlet weak var advertImage: UIImageView!
    var loadingAlert:MBProgressHUD?
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        earnMoney.isEnabled=false
//        self.earnMoney.isHidden=true
          self.sellerPhone.layer.cornerRadius = self.sellerPhone.frame.height.self / 2.0
        
        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert!.mode = MBProgressHUDMode.indeterminate
        
        self.defaults.set(nil, forKey: "aID")
        
        // navigationController?.navigationBar.isTranslucent = false
        
        
        // Do any additional setup after loading the view.
        
        do{
            let udata = self.defaults.string(forKey: "uData")
            userToken = self.defaults.string(forKey: "userToken")
            requestToken = self.defaults.string(forKey: "requestToken")
            
            self.userData  = try
                JSONDecoder().decode(Array<UserStruct>.self, from: udata!.data(using: .utf8)!)
        }
        catch let jsonErr{
            print("Error serializing json:",jsonErr)
        }
        select.GetAdvertById(advertID: advertID)
        {
            (list)
            in
            
            
            
            DispatchQueue.main.async {
                self.loadingAlert?.hide(animated: true)
//                if list[0].isPaid == 1 && list[0].userID != self.userData[0].id && self.fromArchieve == false
//                {
//                    self.earnMoney.isHidden=false
//                    self.earnMoney.isEnabled=true
//
//                }
                
                //  self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                //self.tableView.reloadData()
                
                // self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                
                self.advertName.text=list[0].name!
                self.sellerFullname.text=list[0].sellerFullName!
                self.sellerPhone.text="+994\(list[0].sellerPhone!)"
                self.aDescription.text = list[0].description!
                self.advertType.text=list[0].aTypeName
                //self.balance.text = "\(self.userData[0].earning!) AZN"
                self.viewCount.text = "Baxış sayı \(list[0].views!)"
                
                let loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
                
                
                
                self.advertImage.image = UIImage(named: "background")!
                
                loadingIndicator.center=CGPoint(x: self.advertImage.bounds.size.width/2, y: self.advertImage.bounds.size.height/2)
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.color = UIColor.lightGray
                // loadingIndicator.style = UIActivityIndicatorView.Style.gray
                loadingIndicator.startAnimating();
                self.advertImage.addSubview(loadingIndicator)
                
                for  i in list[0].photoUrl ?? [""] {
                    
                    
                    Alamofire.request(i).responseImage { response in
                        if let catPicture = response.result.value {
                            // self.imageSource.append(ImageSource(image:  catPicture))
                            // imgs.append(catPicture)
                            print("Image downloaded\(catPicture)")
                            //advert.photo=catPicture.pngData()
                            DispatchQueue.main.async {
                                // self.slideshow.setImageInputs(self.imageSource)
                                loadingIndicator.stopAnimating()
                                self.advertImage.image = UIImage(data: catPicture.pngData()!)
                            }
                            
                            //    photos.append(catPicture)
                            
                            //print("image downloaded: \(item.photo)")
                            
                            //self.dataArray[element].photo=catPicture.pngData()
                            //print(self.dataArray[dataArray.count-1].photo)
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                
                
            }
        }
        
    }
    
    @IBAction func exitButtonClick(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    
    
    @IBAction func earnMoney_click(_ sender: Any) {
        earnMoney.isHidden=true;
        let defaults = UserDefaults.standard
        let pass = defaults.string(forKey: "pass")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TextStoryPage") as! ReklamStoryController
        newViewController.advertID=advertID!
        newViewController.usertoken=userToken
        newViewController.requesttoken=requestToken
        newViewController.advertDescription=self.aDescription.text
        self.present(newViewController, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
