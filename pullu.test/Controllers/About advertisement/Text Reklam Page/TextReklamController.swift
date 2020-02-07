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
    @IBOutlet weak var advertDescription: UILabel!
    @IBOutlet weak var sellerFullname: UILabel!
    
    @IBOutlet weak var sellerPhone: UILabel!
    @IBOutlet weak var advertImage: UIImageView!
    @IBOutlet weak var earnMoney: UIButton!
    
    @IBOutlet weak var advertType: UILabel!
    @IBOutlet weak var advertPrice: UILabel!
    @IBOutlet weak var balance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(TextReklamController.tappedMe))
        advertImage.addGestureRecognizer(tap)
        advertImage.isUserInteractionEnabled = true
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
                self.advertDescription.text = list[0].description!
                self.advertType.text=list[0].aTypeName
                self.balance.text = "\(self.userData[0].earning!) AZN"
                self.viewCount.text = "Baxış sayı \(list[0].views!)"
                
            }
        }
        
    }
    
    @objc func tappedMe()
    {
        self.performSegue(withIdentifier: "earnMoney", sender: self)
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
        newViewController.advertDescription=self.advertDescription.text
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
