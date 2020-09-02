//
//  AddBalanceController.swift
//  pullu.test
//
//  Created by Javidan Mirza on 2/18/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import MBProgressHUD
class AddBalanceController: UIViewController {
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var earning: UILabel!
    var select:DbSelect = DbSelect()
    var defaults = UserDefaults.standard
    var loadingAlert:MBProgressHUD?
    var earningValue = 0.00
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert!.mode = MBProgressHUDMode.indeterminate
       
        // Do any additional setup after loading the view.
        UIApplication.shared.beginIgnoringInteractionEvents()
       
        select.GetFinance(){
            (obj)
            in
             UIApplication.shared.endIgnoringInteractionEvents()
            switch obj.status{
            case 1:
               
            
            self.balance.text = "Yüklənən məbləğ \(obj.data[0].balance!) AZN"
            self.earning.text = "Qazanılan məbləğ \(obj.data[0].earning!) AZN"
            self.earningValue = Double(obj.data[0].earning!)!
            DispatchQueue.main.async {
                self.loadingAlert!.hide(animated: true)
                
            }
                break
            case 2:
           
               let alert = UIAlertController(title: "Sessiyanız başa çatıb", message: "Zəhmət olmasa yenidən giriş edin", preferredStyle: UIAlertController.Style.alert)
                                                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                self.present(alert, animated: true, completion: nil)
                break
            default:
                let alert = UIAlertController(title: "Xəta", message: "", preferredStyle: UIAlertController.Style.alert)
                                                                 alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                 self.present(alert, animated: true, completion: nil)
                break
            }
            
        }
        
    }
    
    @IBAction func paymentButton(_ sender: Any) {
        self.performSegue(withIdentifier: "paymentViewSegue", sender: self)
        
    }
    
    @IBAction func WithdrawButtonClick(_ sender: Any) {
        if earningValue > 0.99
        {
    self.performSegue(withIdentifier: "serviceListSegue", sender: self)
        }
        else {
            let alert = UIAlertController(title: "Bildiriş", message: "Məxaric üçün,sizin, kifayət qədər qazancınız yoxdur", preferredStyle: UIAlertController.Style.alert)
                                     alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                     self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation
    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     if (segue.identifier == "serviceListSegue") {
     let displayVC = segue.destination as! WithdrawServicesController
        displayVC.earningValue = earningValue
     //displayVC.id =
     }
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     
}
