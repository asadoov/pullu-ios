//
//  HomePageController.swift
//  pullu.test
//
//  Created by Rufat Asadzade on 1/9/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class HomePageController: UIViewController {
    
    @IBOutlet var adverisementCount: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let mail = defaults.string(forKey: "mail")
        let pass = defaults.string(forKey: "pass")
        let userData = defaults.string(forKey: "uData")
        
        let  db:dbSelect=dbSelect()
        /*db.getAds(username: mail!, pass: pass!){
            (list) in
            for advert in list{
                
                let tutunController: ProductContentController = storyboard
                    .instantiateViewController(withIdentifier: "ProductContentController") as! ProductContentController
                tutunController.title = item["title"] as? String
                tutunController.catId = item["id"] as? String
                viewControllers.append(tutunController)
                
                print(advert.name)
            }
            
            
        }*/
        let data = Data(userData!.utf8)
        
        do{
            
            
            var list  = try
                JSONDecoder().decode(Array<User>.self, from: data)
            print(list[0].phone)
            
            
        }
        catch let jsonErr{
            print("Error serializing json:",jsonErr)
        }
        
        // Do any additional setup after loading the view.
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

