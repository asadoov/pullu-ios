//
//  VideoStory.swift
//  pullu.test
//
//  Created by Rufat on 5/26/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import AVKit
class VideoStory: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    
    let defaults = UserDefaults.standard
    @IBOutlet weak var closeButton: UIButton!
    var advertID:Int?
    var url:String?
    var userToken:String?
    var requestToken:String?
    var player:AVPlayer?
    let insert:DbInsert=DbInsert()
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.isHidden = true
        self.defaults.set(nil, forKey: "aID")
        // Do any additional setup after loading the view
        
              let videoURL = URL(string: url!)
         self.player = AVPlayer(url: videoURL!)
        
                                        let playerLayer = AVPlayerLayer(player:self.player )
                                                                      
        DispatchQueue.main.async {
            playerLayer.frame = self.view.frame
                            self.view.layer.addSublayer(playerLayer)
            self.player?.play()
                       }
                                       
        var time=0
        // print("advID\(advertID!) mail\(mail!) pass \(pass!)")
        // Do any additional setup after loading the view.
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            time+=1
            if time==31{
                self.insert.earnMoney(advertID: self.advertID){
                                
                                (status)
                                in
                                switch status.response
                                {
                                case 1:
                                    self.defaults.set(status.requestToken, forKey: "requestToken")
                                   let alert = UIAlertController(title: "Təbriklər!", message: "Siz reklamın tarifinə uyğun qazanc əldə etdiniz! Maliyə bölməsinə keçid edərək cari balansızı öyrənə bilərsiniz", preferredStyle: UIAlertController.Style.alert)
                                                   alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: {
                                                       (action: UIAlertAction!) in
                                                       self.defaults.set(self.advertID, forKey: "aID")
                                                     self.dismiss(animated: true)
                                                   }))
                                     self.present(alert, animated: true, completion: nil)
                                   break
                                case 3:
                                   let alert = UIAlertController(title: "Sessiyanız başa çatıb", message: "Zəhmət olmasa yenidən giriş edin", preferredStyle: UIAlertController.Style.alert)
                                                                                             
                                                                                             alert.addAction(UIAlertAction(title: "Giriş et", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                                                                                                 self.defaults.set(nil, forKey: "userToken")
                                                                                                 self.defaults.set(nil, forKey: "requestToken")
                                                                                                 self.defaults.set(nil, forKey: "uData")
                                                                                                 let menu:MenuController = MenuController()
                                                                                                 menu.updateRootVC(status: false)                                                                                              }))
                                         self.present(alert, animated: true, completion: nil)
                                   break
                                default:
                                                                          // let alert = UIAlertController(title: "Oops", message: "Ətraflı: Kod: \(status.response!)\n\(status.responseString ?? "")", preferredStyle: UIAlertController.Style.alert)
                                                                          let errorAlert = UIAlertController(title: "Oops", message: "Hall hazırda serverlərimizdə problem yaşanır və biz artıq bunun üzərində çalışırıq", preferredStyle: UIAlertController.Style.alert)
                                                                          errorAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                          errorAlert.addAction(UIAlertAction(title: "Ətraflı", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                                                                              let alert = UIAlertController(title: "Ətraflı", message: "Lütfən bu mesajı screenshot edib developerə göndərəsiniz\n xəta kodu: \(status.response!)\n\(status.responseString ?? "")", preferredStyle: UIAlertController.Style.alert)
                                                                              alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                              self.present(alert, animated: true, completion: nil)
                                                                          }))
                                                                       self.present(errorAlert, animated: true, completion: nil)
                               
                                
                                }
                                
                                }
                                
                
                timer.invalidate()
            }
            else{
                DispatchQueue.main.async {
                    self.timerLabel.text=String(Int(self.timerLabel.text!)!-1)
                }
                
            }
            
            
            
            
            
            
            
        }
        
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        dismiss(animated: true)
        
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
