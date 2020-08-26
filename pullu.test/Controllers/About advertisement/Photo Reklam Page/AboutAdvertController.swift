//
//  AboutAdvertController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/17/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire
import AlamofireImage

class AboutAdvertController: UIViewController {
    let defaults = UserDefaults.standard
    var advertID:Int?
    var userToken:String?
    var requestToken:String?
    var select:DbSelect=DbSelect()
    var userData = Array<UserStruct>()
    var fromArchieve:Bool = false
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var advName: UILabel!
    
    @IBOutlet weak var aDescription: UITextView!
    
    
    @IBOutlet weak var advType: UILabel!
    
    @IBOutlet weak var balance: UILabel!
    
    
    @IBOutlet weak var sellerFullname: UILabel!
    
    @IBOutlet weak var sellerPhone: UITextView!
    
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    //    @IBOutlet weak var blurClocks: UIImageView!
    @IBOutlet weak var earnMoney: UIButton!
    var imageSource: [ImageSource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        earnMoney.isEnabled=false
        self.earnMoney.isHidden=true
        earnMoney.titleLabel!.text = "Yüklənir..."
        self.defaults.set(nil, forKey: "aID")
        //        let alert = UIAlertController(title: nil, message: "Yüklənir...", preferredStyle: .alert)
        //
        //        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        //        loadingIndicator.hidesWhenStopped = true
        //        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        //        loadingIndicator.startAnimating();
        //        alert.view.addSubview(loadingIndicator)
        //        present(alert, animated: false, completion: nil)
        
        //   navigationController?.navigationBar.isTranslucent = false
        
        
        //        let blurEffect = UIBlurEffect(style:.regular)
        //        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //        //always fill the view
        //        blurEffectView.frame = self.view.bounds
        //        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //
        //        blurClocks.addSubview(blurEffectView)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AboutAdvertController.didTap))
        slideshow.addGestureRecognizer(gestureRecognizer)
        
        slideshow.pageIndicatorPosition = .init(horizontal: .center,vertical: .under)
        slideshow.contentScaleMode=UIViewContentMode.scaleAspectFill
        let pageControl=UIPageControl()
        pageControl.currentPageIndicatorTintColor=UIColor.darkGray
        pageControl.pageIndicatorTintColor=UIColor.lightGray
        slideshow.pageIndicator=pageControl
        
        // Do any additional setup after loading the view.
        do{
            let udata = self.defaults.string(forKey: "uData")
            userToken = self.defaults.string(forKey: "userToken")
            self.userData  = try
                JSONDecoder().decode(Array<UserStruct>.self, from: udata!.data(using: .utf8)!)
            self.requestToken=self.defaults.string(forKey: "requestToken")
        }
        catch let jsonErr{
            print("Error serializing json:",jsonErr)
        }
        //print("mail: \(userData[0].mail) pass: \(pass) advertID: \(advertID)")
        select.GetAdvertById(advertID: advertID)
        {
            (list)
            in
            
            
            
            DispatchQueue.main.async {
                
                
                //  self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                //self.tableView.reloadData()
                
                // self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                
                self.advName.text=list[0].name!
                self.sellerFullname.text=list[0].sellerFullName!
                self.sellerPhone.text="+994\(list[0].sellerPhone!)"
                self.aDescription.text = list[0].description!
                self.advType.text=list[0].aTypeName
                self.balance.text = "\(self.userData[0].earning!) AZN"
                self.viewCount.text = "Baxış sayı \(list[0].views!)"
                
                //  self.tableView.reloadData()
                let loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
                
                self.slideshow.setImageInputs([
                    
                    ImageSource(image: UIImage(named: "background")!)
                    
                ])
                
                
                loadingIndicator.center=CGPoint(x: self.slideshow.bounds.size.width/2, y: self.slideshow.bounds.size.height/2)
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.color = UIColor.lightGray
                // loadingIndicator.style = UIActivityIndicatorView.Style.gray
                loadingIndicator.startAnimating();
                self.slideshow.addSubview(loadingIndicator)
                
                
                
                
                
                for  i in list[0].photoUrl ?? [""] {
                    
                    
                    Alamofire.request(i).responseImage { response in
                        
                         loadingIndicator.stopAnimating();
                        
                        if let catPicture = response.result.value {
                            self.imageSource.append(ImageSource(image:  catPicture))
                            // imgs.append(catPicture)
                            print("Image downloaded\(catPicture)")
                            //advert.photo=catPicture.pngData()
                            DispatchQueue.main.async {
                               
                                self.slideshow.setImageInputs(self.imageSource)
                            }
                            
                            //    photos.append(catPicture)
                            
                            //print("image downloaded: \(item.photo)")
                            
                            //self.dataArray[element].photo=catPicture.pngData()
                            //print(self.dataArray[dataArray.count-1].photo)
                            
                        }
                        else{
                            self.imageSource.append(ImageSource(image: UIImage(named: "damaged")!))
                            DispatchQueue.main.async {
                               
                                self.slideshow.setImageInputs(self.imageSource)
                            }
                        }
                        
                        if (self.imageSource.count == list[0].photoUrl!.count)
                        {
                            if self.imageSource.count>0{
                                if list[0].isPaid == 1 && list[0].userID != self.userData[0].id && self.fromArchieve == false
                                {
                                    self.earnMoney.titleLabel!.text = "Reklamı izlə"
                                    self.earnMoney.isHidden=false
                                    self.earnMoney.isEnabled=true
                                }
                                
                            }
                            
                        }
                        else {
                            self.earnMoney.isHidden=true
                        }
                        
                    }
                    
                    
                }
                
                
            }
            
            
        }
        
        
    }
    
    @objc func didTap() {
        slideshow.presentFullScreenController(from: self)
    }
    
    @IBAction func earnMoney_click(_ sender: Any) {
        earnMoney.isHidden=true;
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "PhotoStoryPage") as! PhotoStoryController
        newViewController.imageSource=imageSource
        newViewController.advertID=advertID
        newViewController.userToken=userToken
        newViewController.requestToken=requestToken
        self.present(newViewController, animated: true, completion: nil)
        // let n=(30/slideshow.images.count)
        
        // slideshow.presentFullScreenController(from: self).slideshow.slideshowInterval=Double(n)
        
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
