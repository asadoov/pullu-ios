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
    @IBOutlet weak var saveButton: UIButton!
    var phoneNum = 0
    var otp = 0
    var password = ""
    override func viewDidLoad() {
        super.viewDidLoad()
         self.saveButton.layer.cornerRadius = self.saveButton.frame.height.self / 2.0
        NotificationCenter.default.addObserver(forName: UITextField.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
                  self.view.frame.origin.y = -100
              }
              NotificationCenter.default.addObserver(forName: UITextField.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
                  self.view.frame.origin.y = 0.0
              }
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
