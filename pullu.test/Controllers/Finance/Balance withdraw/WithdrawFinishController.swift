//
//  WithdrawFinishController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 7/24/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class WithdrawFinishController: UIViewController {
    @IBOutlet weak var earningValueTextBox: UILabel!
    @IBOutlet weak var prefixTextBox: UILabel!
    @IBOutlet weak var mobileNumTextBox: UILabel!
    @IBOutlet weak var moneyCountTextBox: UILabel!
    
    
    var serviceName:String?
    var serviceID:Int?
    
    var moneyCount:Double?
    var mobileNum:String?
    var mobilePrefix:String?
    var mobileNumWithPrefix:Int64?
    var earningValue:Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = serviceName
        earningValueTextBox.text = "Qazanılan məbləğ: \(earningValue!)"
        prefixTextBox.text = "Prefiks: \(mobilePrefix!)"
        mobileNumTextBox.text = "Nömrə: \(mobileNum!)"
        moneyCountTextBox.text = "Məbləğ: \(moneyCount!)"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func PayClick(_ sender: Any) {
        if earningValue! > moneyCount! {
            let amount = Int64(moneyCount!*100)
            let defaults = UserDefaults.standard
            let mobile = defaults.string(forKey: "phone")
            let pass = defaults.string(forKey: "pass")
            let insert:DbInsert = DbInsert()
            insert.Withdraw(mobile: Int64(mobile!) , pass: pass!, account: mobileNumWithPrefix!, serviceID: serviceID!, amount: amount ){
                status
                in
                switch status.response
                {
                case 1:
                    let alert = UIAlertController(title: "Uğurlu əməliyyat!", message: "Ödəniş uğurla başa çatmışdır, təşəkkür edirik", preferredStyle: UIAlertController.Style.alert)
                                                                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                        self.present(alert, animated: true, completion: nil)
                    break
                case 2:
                    let alert = UIAlertController(title: "Əməliyyat gözlənmədədir", message: "Yaxın zamanda ödənişiniz qəbul olunacaq, təşəkkür edirik!", preferredStyle: UIAlertController.Style.alert)
                                                                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                        self.present(alert, animated: true, completion: nil)
               
                case 5:
                    let alert = UIAlertController(title: "Uğursuz əməliyyat!", message: "Zəhmət olmasa, ödəniləcək nömrənin düzgünlüyünü yoxlayasınız", preferredStyle: UIAlertController.Style.alert)
                                                                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                        self.present(alert, animated: true, completion: nil)
                case 6:
                    let alert = UIAlertController(title: "Uğursuz əməliyyat!", message: "Balansınızda kifayət qədər vəsait yoxdur", preferredStyle: UIAlertController.Style.alert)
                                                                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                        self.present(alert, animated: true, completion: nil)
                default:
                    
                        let alert = UIAlertController(title: "Uğursuz əməliyyat!", message: "Xəta baş verdi, zəhmət olmasa biraz sonra yenidən cəhd edəsiniz", preferredStyle: UIAlertController.Style.alert)
                                                                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                            self.present(alert, animated: true, completion: nil)
                    
                    
                }
                
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
