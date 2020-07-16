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
    var select:dbSelect = dbSelect()
    var defaults = UserDefaults.standard
    var loadingAlert:MBProgressHUD?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert!.mode = MBProgressHUDMode.indeterminate
       
        // Do any additional setup after loading the view.
       
        var pass = defaults.string(forKey: "pass")
        var mail = defaults.string(forKey: "mail")
        select.getFinance(mail: mail!, pass: pass!){
            (list)
            in
            self.balance.text = "Yüklənən məbləğ \(list[0].balance!) AZN"
            self.earning.text = "Qazanılan məbləğ \(list[0].earning!) AZN"
            DispatchQueue.main.async {
                self.loadingAlert!.hide(animated: true)
                
            }
        }
        
    }
    
    @IBAction func paymentButton(_ sender: Any) {
        self.performSegue(withIdentifier: "paymentViewSegue", sender: self)
        
    }
    
    
    // MARK: - Navigation
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     if (segue.identifier == "paymentViewSegue") {
     let displayVC = segue.destination as! WebViewController
     //displayVC.id =
     }
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
