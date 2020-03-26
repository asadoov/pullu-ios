//
//  textReklamController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/23/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Alamofire

class TextReklamController: UIViewController {
    
    let defaults = UserDefaults.standard
    var advertID:Int?
    var select:dbSelect=dbSelect()
    var userData = Array<User>()
    var pass:String?
    
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var advertName: UILabel!
    
    @IBOutlet weak var aDescription: UITextView!
    @IBOutlet weak var sellerFullname: UILabel!
    
    @IBOutlet weak var sellerPhone: UILabel!
    
    @IBOutlet weak var earnMoney: UIButton!
    
    @IBOutlet weak var advertType: UILabel!
    @IBOutlet weak var advertPrice: UILabel!
    @IBOutlet weak var balance: UILabel!
    
    @IBOutlet weak var advertImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let alert = UIAlertController(title: nil, message: "Yüklənir...", preferredStyle: .alert)
                   
                   let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                   loadingIndicator.hidesWhenStopped = true
                   loadingIndicator.style = UIActivityIndicatorView.Style.gray
                   loadingIndicator.startAnimating();
                   
                   
                   alert.view.addSubview(loadingIndicator)
                   present(alert, animated: false, completion: nil)
        // navigationController?.navigationBar.isTranslucent = false
        
        
        // Do any additional setup after loading the view.
        
        do{
            let udata = self.defaults.string(forKey: "uData")
            pass = self.defaults.string(forKey: "pass")
            
            self.userData  = try
                JSONDecoder().decode(Array<User>.self, from: udata!.data(using: .utf8)!)
        }
        catch let jsonErr{
            print("Error serializing json:",jsonErr)
        }
        select.getAdvertById(advertID: advertID,mail:self.userData[0].mail,pass:pass )
        {
            (list)
            in
            
            
            
            DispatchQueue.main.async {
                if list[0].isPaid==1{
                    self.earnMoney.isHidden=false
                }
                //  self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                //self.tableView.reloadData()
                
                // self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                
                self.advertName.text=list[0].name!
                self.sellerFullname.text=list[0].sellerFullName!
                self.sellerPhone.text=list[0].sellerPhone!
                self.aDescription.text = list[0].description!
                self.advertType.text=list[0].aTypeName
                self.balance.text = "\(self.userData[0].earning!) AZN"
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
                
                self.dismiss(animated: false)
            }
        }
        
    }
    
    
    
    
    @IBAction func earnMoney_click(_ sender: Any) {
        earnMoney.isHidden=true;
        let defaults = UserDefaults.standard
        let pass = defaults.string(forKey: "pass")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TextStoryPage") as! ReklamStoryController
        newViewController.advertID=advertID!
        newViewController.mail=self.userData[0].mail
        newViewController.pass=pass!
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
