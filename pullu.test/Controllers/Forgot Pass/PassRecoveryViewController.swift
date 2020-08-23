//
//  SendEmailViewController.swift
//  pullu.test
//
//  Created by Javidan Mirza on 3/11/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import MBProgressHUD
class PassRecoveryViewController: UIViewController {
    var loadingAlert:MBProgressHUD?
    
    var insert : DbInsert = DbInsert()
    var phone:Int64?
    
    @IBOutlet weak var phoneLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        phoneLabel.text = String(phone!)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func backBtnClck(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
        
        //        let alert = UIAlertController(title: nil, message: "Yüklənir...", preferredStyle: .alert)
        //
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
        
        
        
        
        insert.sendPassChangeSMS(phone: phone ?? 0) {
            (status) in
            self.loadingAlert!.hide(animated: true)
            switch status.response {
                
            case 1:
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "fourSegue", sender: self)
                }
                break
       
                
            case 3:
                let alert = UIAlertController(title: "Nömrə mövcud deil", message: " Nömrənin düzgünlüyünü yoxlayın", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                break
             default:
                          let alert = UIAlertController(title: "Oops", message: "Hall hazırda serverlərimizdə problem yaşanır və biz artıq bunun üzərində çalışırıq", preferredStyle: UIAlertController.Style.alert)
                          alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                          alert.addAction(UIAlertAction(title: "Ətraflı", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                              let alert = UIAlertController(title: "Ətraflı", message: "Lütfən bu mesajı screenshot edib developerə göndərəsiniz\n xəta kodu: \(status.response!)\n\(status.responseString ?? "")", preferredStyle: UIAlertController.Style.alert)
                              alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                              self.present(alert, animated: true, completion: nil)
                          }))
                          self.present(alert, animated: true, completion: nil)
                          break
            }
        }
        
    }
    
//    @IBAction func resetTypeChanged(_ sender: Any) {
//
//        switch resetType.selectedSegmentIndex {
//        case 0:
//            DispatchQueue.main.async {
//                self.loginTextField.placeholder = "Nömrənizi qeyd edin..."
//            }
//        case 1:
//            DispatchQueue.main.async {
//                self.loginTextField.placeholder = "Email qeyd edin..."
//            }
//        default:
//            break
//        }
//    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fourSegue") {
            let checkpass = segue.destination as! PassRecoveryCheckOtpViewController
            checkpass.phone = phone!
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
