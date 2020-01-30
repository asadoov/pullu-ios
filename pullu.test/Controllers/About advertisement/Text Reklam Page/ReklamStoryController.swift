//
//  ReklamStoryController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/24/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class ReklamStoryController: UIViewController {
    let insert:DbInsert=DbInsert()
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var advertDescriptionLabel: UILabel!
    var advertID:Int?
    var mail:String?
    var pass:String?
    var advertDescription:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        advertDescriptionLabel.text=advertDescription
        var time=0
       // print("advID\(advertID!) mail\(mail!) pass \(pass!)")
        // Do any additional setup after loading the view.
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            time+=1
            if time==30{
                self.insert.earnMoney(advertID: self.advertID, mail: self.mail,pass:self.pass){
                    
                    (status)
                    in
                    if (status.statusCode!==1)
                    {
                        let alert = UIAlertController(title: "Təbriklər!", message: "Siz reklamın tarifinə uyğun qazanc əldə etdiniz!", preferredStyle: UIAlertController.Style.alert)
                                       alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                                       self.present(alert, animated: true, completion: nil)
                    }
                    
                }
                
                self.dismiss(animated: true)
                
            }
            
            DispatchQueue.main.async {
                self.timerLabel.text=String(Int(self.timerLabel.text!)!-1)
            }
            
            
        }
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
