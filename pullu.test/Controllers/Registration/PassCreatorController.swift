//
//  passCreatorController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 7/15/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import MBProgressHUD
class PassCreatorController: UIViewController {
    @IBOutlet weak var passTextBox: UITextField!
    
    @IBOutlet weak var passRepeatTextBox: UITextField!
     var phoneNum = 0
    var otp = 0
    var password = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
        if !passTextBox.text!.isEmpty && !passRepeatTextBox.text!.isEmpty
        {
            password = passTextBox.text!
            self.performSegue(withIdentifier: "regLastPageSegue", sender: self)
            
            
        }
        else
        {
            let alert = UIAlertController(title: "Bildiriş", message: "Zəhmət olmasa şifrənizi yazın", preferredStyle: UIAlertController.Style.alert)
                                             alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                             self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "regLastPageSegue"){
                                let displayVC = segue.destination as! RegLastController
            displayVC.phoneNum = phoneNum
                   displayVC.otp = otp
            displayVC.password = password
                            }
    }
    

}
