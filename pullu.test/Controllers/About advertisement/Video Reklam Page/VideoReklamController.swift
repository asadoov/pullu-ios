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
    var userToken:String?
    var requestToken:String?
    var select:DbSelect=DbSelect()
    let defaults = UserDefaults.standard
    var userData = Array<UserStruct>()
    //var player:AVPlayer?
    var playing = false
    var player: AVPlayer!
    var playerViewController: AVPlayerViewController!
    @IBOutlet weak var sellerFullname: UILabel!
    @IBOutlet weak var earnMoney: UIButton!
    @IBOutlet weak var playerUIView: UIView!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var aDescription: UITextView!
    @IBOutlet weak var advType: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var advName: UILabel!
     var fromArchieve:Bool = false
    @IBOutlet weak var sellerPhone: UITextView!
    var url:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        earnMoney.isEnabled=false
          self.earnMoney.isHidden=true
        earnMoney.titleLabel!.text = "Yüklənir..."
        self.defaults.set(nil, forKey: "aID")
        // Do any additional setup after loading the view.
        do{
            let udata = self.defaults.string(forKey: "uData")
            userToken = self.defaults.string(forKey: "userToken")
            self.requestToken = self.defaults.string(forKey: "requestToken")
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
                self.earnMoney.isEnabled = true
                
                 if list[0].isPaid == 1 && list[0].userID != self.userData[0].id && self.fromArchieve == false
                               {
                                    self.earnMoney.isHidden=false
                                                         self.earnMoney.isEnabled=true
                                 
                               }
                //  self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                //self.tableView.reloadData()
                
                // self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                
                self.advName.text=list[0].name!
                self.sellerFullname.text=list[0].sellerFullName!
                self.sellerPhone.text="+994\(list[0].sellerPhone!)"
                self.aDescription.text = list[0].description!
                self.advType.text=list[0].aTypeName
                //self.balance.text = "\(self.userData[0].earning!) AZN"
                self.viewCount.text = "Baxış sayı \(list[0].views!)"
               // let vc = AVPlayerViewController()
                
                self.url = list[0].photoUrl![0]
               let videoURL = URL(string: self.url!)
                                  self.player = AVPlayer(url: videoURL!)
                      //                vc.player = self.player/
                                      
                                      
                                    self.playerViewController = AVPlayerViewController()
                                      self.playerViewController.player = self.player
                                      self.playerViewController.view.frame = self.playerUIView.bounds
                  self.playerViewController.videoGravity = AVLayerVideoGravity.resizeAspectFill
                                      self.playerViewController.player?.pause()
                                      self.playerUIView.addSubview(self.playerViewController.view)
              
                //
                
                
                //                    let playerLayer = AVPlayerLayer(player:self.player )
                //                                                  playerLayer.frame = self.playerUIView.frame
                //                    playerLayer.bounds=self.playerUIView.frame
                
                //                             let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
                //                    self.playerUIView.addGestureRecognizer(gesture)
                DispatchQueue.main.async {
                    // self.playerUIView.layer.addSublayer(playerLayer)
             
                }
               
                
                
            }
            
            
        }
        
    }
//    override func viewDidAppear(_ animated: Bool) {
//
//    }
//
//    @objc func tapped(_ sender: UITapGestureRecognizer) {
//        //updateStatus()
//        let vc = AVPlayerViewController()
//        vc.player = player
//
//        present(vc, animated: true) {
//            vc.player?.play()
//        }
//    }
    private func updateStatus() {
        if playing {
            player?.pause()
        } else {
            player?.play()
        }
    }
    
    @IBAction func earnMoneyClicked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let newViewController = storyBoard.instantiateViewController(withIdentifier: "VideoStoryPage") as! VideoStory
              
               newViewController.advertID=advertID
               newViewController.userToken=userToken
               newViewController.requestToken=requestToken
        newViewController.url = url
               self.present(newViewController, animated: true, completion: nil)
    }
    //    func updateUI() {
    //        if playing {
    //            setBackgroundImage(name: "pause-button")
    //        } else {
    //            setBackgroundImage(name: "play-button")
    //        }
    //    }
    //    private func setBackgroundImage(name: String) {
    //           UIGraphicsBeginImageContext(frame.size)
    //           UIImage(named: name)?.draw(in: bounds)
    //           guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
    //           UIGraphicsEndImageContext()
    //           backgroundColor = UIColor(patternImage: image)
    //       }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
