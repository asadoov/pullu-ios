//
//  FirstRegistrationController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/11/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import MBProgressHUD
class FirstRegistrationController: UIViewController {
    

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var passRepeat: UITextField!
    var newUser: NewUser = NewUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
      
        
        
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func forwardClick(_ sender: Any) {
        if((!email.text!.isEmpty)&&(!pass.text!.isEmpty)&&(!passRepeat.text!.isEmpty)){
            if (pass.text==passRepeat.text) {
                
         
                newUser.mail=email.text
                newUser.pass=pass.text
            
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "secondRegPage", sender: self)
                }
            }
            
            
            
        }
        else{
            let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                        warningAlert.mode = MBProgressHUDMode.text
            //            warningAlert.isSquare=true
                        warningAlert.label.text = "Diqqət"
                        warningAlert.detailsLabel.text = "Zəhmət olmasa bütün boşluqların düzgün doldurduğunuzdan əmin olun"
                        warningAlert.hide(animated: true,afterDelay: 3)
            
        }
    }
    @IBAction func backBtnClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func backButton(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "geriSegue", sender: self)
        }
        
        
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "secondRegPage"){
                let displayVC = segue.destination as! SecondRegistrationController
            displayVC.newUser = newUser
        }
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     
    
}
