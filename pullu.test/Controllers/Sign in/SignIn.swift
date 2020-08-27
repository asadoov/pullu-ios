//
//  logIn.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/7/20.
//  Copyright © 2020 Javidan Mirza. All rights reserved.
//

import UIKit
import FirebaseMessaging
import MBProgressHUD
class SignIn: UIViewController {
    
    let defaults = UserDefaults.standard
    
    
    var loadingAlert:MBProgressHUD?
    
    @IBOutlet weak var pass: UITextField!
    
    var phoneNum:Int64?
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        NotificationCenter.default.addObserver(forName: UITextField.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = -200
        }
        NotificationCenter.default.addObserver(forName: UITextField.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = 0.0
        }
        
        
        //Looks for single or multiple taps.
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
    
    @IBAction func closePage(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func SignIn_Click(_ sender: Any) {
        //let alert = UIAlertController(title: nil, message: "Yüklənir...", preferredStyle: .alert)
        
        //        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        //        loadingIndicator.hidesWhenStopped = true
        //        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        //        loadingIndicator.startAnimating();
        //
        //
        //        alert.view.addSubview(loadingIndicator)
        //        present(alert, animated: true, completion: nil)
        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert!.mode = MBProgressHUDMode.indeterminate
        
        let select: DbSelect=DbSelect()
        
        if (phoneNum! > 0 && pass.text != "") {
            select.SignIn(phone: phoneNum!, pass: pass.text!) { (rslt) in
                
                DispatchQueue.main.async {
                    self.loadingAlert?.hide(animated: true)
                }
                let obj:ResponseStruct<UserStruct> = rslt
                switch obj.status{
                case 1:
                    if(obj.data.count > 0){
                        
                        //print(usrList[0].mail)
                        
                        DispatchQueue.main.async {
                            
                            
                            Messaging.messaging().subscribe(toTopic: "\(obj.data[0].id!)"){ error in
                                if error == nil{
                                    print("Subscribed to topic")
                                }
                                else{
                                    print("Not Subscribed to topic")
                                }
                            }
                            
                            self.defaults.set(obj.data[0].id, forKey: "uID")
                            self.defaults.set(obj.data[0].mail, forKey: "mail")
                            self.defaults.set(obj.data[0].phone, forKey: "phone")
                            
                            //self.defaults.set(usrList, forKey: "userData")
                            let jsonEncoder = JSONEncoder()
                            do {
                                let jsonData = try jsonEncoder.encode(obj.data)
                                let jsonString = String(data: jsonData, encoding: .utf8)
                                self.defaults.set(jsonString, forKey: "uData")
                                
                                // print("JSON String : " + jsonString!)
                            }
                            catch {
                            }
                            var menu:MenuController = MenuController()
                            menu.updateRootVC(status: true)
                            
                            //                            self.performSegue(withIdentifier: "segue", sender: self)
                        }
                        
                    }
                        
                    else{
                        DispatchQueue.main.async {
                            
                            let alert = UIAlertController(title: "Bildiriş", message: "Məlumat səhfdi", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)}
                        
                        
                        
                    }
                    break
                case 2:
                    DispatchQueue.main.async {
                        
                        let alert = UIAlertController(title: "Bildiriş", message: "Şifrənizin düzgünlüyünü yoxlayın", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    break
                default:
                    DispatchQueue.main.async {
                        
                        let alert = UIAlertController(title: "Xəta", message: "Biraz sonra yenidən cəhd edin", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)}
                    
                    
                    break
                    
                }
                
                
            }
        }
        else {
            
                let alert = UIAlertController(title: "Bildiriş", message: "Bütün boşluqları doldurun", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            
        }
        
        
        //print(usrList[0].mail)
        
    }
    
    
    
    @IBAction func forgotPassButton(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "passRecoverySegue", sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segue"){
            let displayVC = segue.destination as! TabBarController
            displayVC.navigationItem.hidesBackButton = true
            
            
        }
        
        if(segue.identifier == "passRecoverySegue"){
            
            if let navController = segue.destination as? UINavigationController {
                
                if let chidVC = navController.topViewController as? PassRecoveryViewController {
                    //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                    chidVC.phone = phoneNum!
                    
                }
                
            }
            
            //  let displayVC = segue.destination as! PassRecoveryViewController
            //displayVC.navigationItem.hidesBackButton = true
            
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    
}
