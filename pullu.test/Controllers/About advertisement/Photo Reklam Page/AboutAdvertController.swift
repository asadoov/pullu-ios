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
    var select:dbSelect=dbSelect()
    var userData = Array<User>()
    @IBOutlet weak var advName: UILabel!
    
    @IBOutlet weak var advDescription: UILabel!
    
    @IBOutlet weak var advType: UILabel!
    
    @IBOutlet weak var balance: UILabel!
    
    
    @IBOutlet weak var sellerFullname: UILabel!
    
    @IBOutlet weak var sellerPhone: UILabel!
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    @IBOutlet weak var earnMoney: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AboutAdvertController.didTap))
        slideshow.addGestureRecognizer(gestureRecognizer)
        
        slideshow.pageIndicatorPosition = .init(horizontal: .center,vertical: .under)
        slideshow.contentScaleMode=UIViewContentMode.scaleAspectFill
        let pageControl=UIPageControl()
        pageControl.currentPageIndicatorTintColor=UIColor.darkGray
        pageControl.pageIndicatorTintColor=UIColor.lightGray
        slideshow.pageIndicator=pageControl
        
        // Do any additional setup after loading the view.
        select.getAdvertById(advertID: advertID)
        {
            (list)
            in
            
            do{
                let udata = self.defaults.string(forKey: "uData")
                
                self.userData  = try
                    JSONDecoder().decode(Array<User>.self, from: udata!.data(using: .utf8)!)
            }
            catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
            
            DispatchQueue.main.async {
                if list[0].isPaid==0{
                    self.earnMoney.isHidden=true
                }
                //  self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                //self.tableView.reloadData()
                
                // self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                
                self.advName.text=list[0].name!
                self.sellerFullname.text=list[0].sellerFullName!
                self.sellerPhone.text=list[0].sellerPhone!
                self.advDescription.text = list[0].description!
                self.advType.text=list[0].aTypeName
                self.balance.text = "\(self.userData[0].earning!) AZN"
                //  self.tableView.reloadData()
                var imageSource: [ImageSource] = []
                
                
                for  i in list[0].photoUrl ?? [""] {
                    
                    
                    Alamofire.request(i).responseImage { response in
                        if let catPicture = response.result.value {
                            imageSource.append(ImageSource(image:  catPicture))
                            // imgs.append(catPicture)
                            print("Image downloaded\(catPicture)")
                            //advert.photo=catPicture.pngData()
                            DispatchQueue.main.async {
                                self.slideshow.setImageInputs(imageSource)
                            }
                            
                            //    photos.append(catPicture)
                            
                            //print("image downloaded: \(item.photo)")
                            
                            //self.dataArray[element].photo=catPicture.pngData()
                            //print(self.dataArray[dataArray.count-1].photo)
                            
                        }
                        else  {
                            DispatchQueue.main.async {
                                self.slideshow.setImageInputs([
                                    
                                    ImageSource(image: UIImage(named: "background")!)
                                    
                                ])
                            }
                            // photos.append(UIImage(named: "background")!)
                            //self.dataArray.append(item)
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
        
        let n=(30/slideshow.images.count)
        //dasda
        slideshow.presentFullScreenController(from: self).slideshow.slideshowInterval=Double(n)
        
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
