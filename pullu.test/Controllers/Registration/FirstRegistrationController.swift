//
//  FirstRegistrationController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/11/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import MBProgressHUD
class FirstRegistrationController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    @IBOutlet weak var operatorChooser: UITextField!
    
    @IBOutlet weak var phoneNum: UITextField!
    let defaults = UserDefaults.standard
    var data = ["050","051","055","070","099"]
    var picker = UIPickerView()
    var phoneNumWithOperator = ""
    @IBOutlet weak var questButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        operatorChooser.text = data[row]
    }
    
    
    @IBAction func questButtonClick(_ sender: Any) {
        let menu:MenuController = MenuController()
             menu.updateRootVC(status: true)
    }
    
    @IBAction func closeButton(_ sender: Any) {
      
        let menu:MenuController = MenuController()
        menu.updateRootVC(status: true)
        
    }
    
    
    var newUser: NewUser = NewUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signInButton.layer.cornerRadius = self.signInButton.frame.height.self / 2.0
         self.questButton.layer.cornerRadius = self.questButton.frame.height.self / 2.0
        NotificationCenter.default.addObserver(forName: UITextField.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = -200
        }
        NotificationCenter.default.addObserver(forName: UITextField.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = 0.0
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        picker.delegate = self
        picker.dataSource = self
        operatorChooser.inputView = picker
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        
        
        
        view.addGestureRecognizer(tap)
        
        
        
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func phoneNumTextChanged(_ sender: Any) {
        if phoneNum.text!.count>7 {
            phoneNum.text!.removeLast()
            
        }
    }
    
    @IBAction func signInButtonClick(_ sender: Any) {
        let loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert.mode = MBProgressHUDMode.indeterminate
        //            warningAlert.isSquare=true
        
        if ((phoneNum.text?.isEmpty) != nil && phoneNum.text?.count==7 && (operatorChooser.text?.isEmpty) != nil){
            let insert = DbInsert()
            phoneNumWithOperator = operatorChooser.text! + phoneNum.text!
            insert.SendSms(phone: Int(phoneNumWithOperator)!){
                (status)
                in
                loadingAlert.hide(animated: true)
                switch (status.response){
                case 1:
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "verifyOtpSegue", sender: self)
                    }
                    break
                case 2:
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "logInSegue", sender: self)
                    }
                    break
                case 3:
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "verifyOtpSegue", sender: self)
                    }
                    break
                    
                    
                    
                default:
                    
                    let alert = UIAlertController(title: "Xəta", message: "Zəhmət olmasa biraz sonra yenidən cəht edin", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                        //logout
                    }))
                    self.present(alert, animated: true, completion: nil)
                    break;
                    
                    
                }
            }
        }
        else {
            loadingAlert.hide(animated: true)
            
        }
        
        
    }
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
    //    @IBAction func forwardClick(_ sender: Any) {
    //        if((!email.text!.isEmpty)&&(!pass.text!.isEmpty)&&(!passRepeat.text!.isEmpty)){
    //            if (pass.text==passRepeat.text) {
    //
    //
    //                newUser.mail=email.text
    //                newUser.pass=pass.text
    //
    //                DispatchQueue.main.async {
    //                    self.performSegue(withIdentifier: "secondRegPage", sender: self)
    //                }
    //            }
    //
    //
    //
    //        }
    //        else{
    //            let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
    //                        warningAlert.mode = MBProgressHUDMode.text
    //            //            warningAlert.isSquare=true
    //                        warningAlert.label.text = "Diqqət"
    //                        warningAlert.detailsLabel.text = "Zəhmət olmasa bütün boşluqların düzgün doldurduğunuzdan əmin olun"
    //                        warningAlert.hide(animated: true,afterDelay: 3)
    //
    //        }
    //    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "verifyOtpSegue"){
            if let navController = segue.destination as? UINavigationController {
                
                if let chidVC = navController.topViewController as? CheckOtp {
                    //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                    chidVC.phoneNum = Int(phoneNumWithOperator)!
                    
                }
                
            }
            
            
        }
        //        if(segue.identifier == "verifyOtpSegue"){
        //                   let displayVC = segue.destination as! CheckOtp
        //                   displayVC.phoneNum = Int(phoneNumWithOperator)!
        //               }
        if(segue.identifier == "logInSegue"){
            if let navController = segue.destination as? UINavigationController {
                
                if let chidVC = navController.topViewController as? SignIn {
                    //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                    chidVC.phoneNum = Int64(phoneNumWithOperator)!
                    
                }
                
            }
            
            
        }
        //        if(segue.identifier == ""){
        //                          let displayVC = segue.destination as! logIn
        //                          displayVC.phoneNum = Int(phoneNumWithOperator)!
        //                      }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
