//
//  CategoryViewController.swift
//  pullu.test
//
//  Created by Rufat on 3/25/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MBProgressHUD
import SJSegmentedScrollView
class CategoryViewController: UIViewController {
  
    var advertArray: [Advertisement] = [Advertisement]()
    var isPaid: [Advertisement] = [Advertisement]()
    var isNotPaid: [Advertisement] = [Advertisement]()
    var object:CategoryStruct?
    var mail:String?
    var pass:String?
    var aID:Int?
    let  db:DbSelect=DbSelect()
    var loadingAlert:MBProgressHUD?
    
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    var loadingView: UIView = UIView()
    
    @IBOutlet weak var content: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        let defaults = UserDefaults.standard
        // Do any additional setup after loading the view.
        mail = defaults.string(forKey: "mail")
        pass = defaults.string(forKey: "pass")
        self.title=object?.name
       
        
        
          if let storyboard = self.storyboard {
                        
                        let paidController = storyboard
                            .instantiateViewController(withIdentifier: "paid") as! PaidController
                        paidController.title = "Ən maraqlı"
            paidController.catID = object!.id!
                    
        //            let backgroundImage = UIImageView()
        //                       backgroundImage.frame.size.width = 100
        //                       backgroundImage.image = UIImage(named: "logout")
        //                       backgroundImage.contentMode = .scaleAspectFit
        //                       backgroundImage.backgroundColor = .white
        //                       myViewController.navigationItem.titleView = backgroundImage
                        
                        let notPaidController = storyboard
                            .instantiateViewController(withIdentifier: "notPaid") as! NotPaidController
                        notPaidController.title = "Sadə"
            notPaidController.catID = object!.id!
                        let segmentedViewController = SJSegmentedViewController(headerViewController: nil,
                                                                                segmentControllers: [paidController,
                                                                                    notPaidController])
                         segmentedViewController.segmentBackgroundColor = UIColor.white
                                       segmentedViewController.segmentTitleColor = UIColor.black
                                   
                                  
                                   segmentedViewController.segmentTitleFont = UIFont.systemFont(ofSize: 18)
                                   segmentedViewController.selectedSegmentViewColor = UIColor.black
                                       segmentedViewController.selectedSegmentViewHeight = 3
                                       segmentedViewController.segmentViewHeight = 40
                                   segmentedViewController.headerViewHeight =  95
                        
                        addChild(segmentedViewController)
                       content.addSubview(segmentedViewController.view)
                        segmentedViewController.view.frame = content.bounds
                        segmentedViewController.didMove(toParent: self)
                    
                    }
    }
    
    
    @IBAction func exitButtonClick(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    
   
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
  
    
    
}

