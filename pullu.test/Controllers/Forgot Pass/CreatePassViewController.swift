//
//  CreatePassViewController.swift
//  pullu.test
//
//  Created by Javidan Mirza on 3/11/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class CreatePassViewController: UIViewController {

    @IBOutlet weak var newPassText: UITextField!
    @IBOutlet weak var newPassRepttext: UITextField!
    var dbIns : DbInsert = DbInsert()
    var login: String?
    var usrCode: String?
    
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
      
          // Do any additional setup after loading the view.
      }
      
      @objc func dismissKeyboard() {
          //Causes the view (or one of its embedded text fields) to resign the first responder status.
          view.endEditing(true)
      }
    
    @IBAction func okButton(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: "Yüklənir...", preferredStyle: .alert)
               
               let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
               loadingIndicator.hidesWhenStopped = true
               loadingIndicator.style = UIActivityIndicatorView.Style.gray
               loadingIndicator.startAnimating();
               
               
               alert.view.addSubview(loadingIndicator)
               present(alert, animated: true, completion: nil)
        

            if (self.newPassText.text! == self.newPassRepttext.text!){
        
        
        dbIns.createNewPass(newpass: newPassText.text!, login: login!, code: usrCode!){
            (Status) in
            
            
            
            switch Status.response{
                
            case 0:
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "lastPageSegue", sender: self)
                }
                break
                
            case 1:
                let alert = UIAlertController(title: "Bildiriş", message: " deyishilmedi ", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                break
                
                case 2:
                let alert = UIAlertController(title: "Bildiriş", message: "Error", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                break
            default : break
            }
    
        }
        }
        else {
            let alert = UIAlertController(title: "Bildiriş", message: "Zəhmət olmasa bütün boşluqlarıı doldurun!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
