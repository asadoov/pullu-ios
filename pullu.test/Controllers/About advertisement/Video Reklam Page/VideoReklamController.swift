//
//  VideoReklamController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/23/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import AVKit


class VideoReklamController: UIViewController {
    var advertID:Int?
    var mail:String?
    var pass:String?
    var select:dbSelect=dbSelect()
    let defaults = UserDefaults.standard
    var userData = Array<User>()
    @IBOutlet weak var videoPlayer: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        do{
            let udata = self.defaults.string(forKey: "uData")
            pass = self.defaults.string(forKey: "pass")
            self.userData  = try
                JSONDecoder().decode(Array<User>.self, from: udata!.data(using: .utf8)!)
            self.mail=self.userData[0].mail
        }
        catch let jsonErr{
            print("Error serializing json:",jsonErr)
        }
        select.getAdvertById(advertID: advertID,mail: userData[0].mail,pass:pass )
        {
            (list)
            in
            
            
            
            DispatchQueue.main.async {
                /*  if list[0].isPaid==1{
                 self.earnMoney.isHidden=false
                 }
                 */
                //  self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                //self.tableView.reloadData()
                
                // self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                
              /*  self.advName.text=list[0].name!
                self.sellerFullname.text=list[0].sellerFullName!
                self.sellerPhone.text=list[0].sellerPhone!
                self.advDescription.text = list[0].description!
                self.advType.text=list[0].aTypeName
                self.balance.text = "\(self.userData[0].earning!) AZN"
                self.viewCount.text = "Baxış sayı \(list[0].views!)"
 
 */
                //  self.tableView.reloadData()
                
                
                
              
                    var url="http://13.92.237.16/media/07082019143318-1925388739.mp4"
                    
            let videoURL = URL(string: url)
                let player = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
                    
                    
                
                
                
            }
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
