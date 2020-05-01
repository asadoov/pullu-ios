//
//  SuccessRegController.swift
//  pullu.test
//
//  Created by Rufat on 2/5/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class SuccessRegController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var activateButton: UIButton!
    @IBOutlet weak var box1: UITextField!
    @IBOutlet weak var box2: UITextField!
    @IBOutlet weak var box3: UITextField!
    @IBOutlet weak var box4: UITextField!
    var insert:DbInsert=DbInsert()
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
       var loadingView: UIView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: UITextField.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
                   self.view.frame.origin.y = -100
               }
               NotificationCenter.default.addObserver(forName: UITextField.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
                   self.view.frame.origin.y = 0.0
               }
               let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        // Do any additional setup after loading the view.
        box1.delegate = self
        box2.delegate = self
        box3.delegate = self
        box4.delegate = self
    }
    @objc func dismissKeyboard() {
             //Causes the view (or one of its embedded text fields) to resign the first responder status.
             view.endEditing(true)
         }
      
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !(string == "") {
            textField.text = string
            if textField == box1 {
                box2.becomeFirstResponder()
            }
            else if textField == box2 {
                box3.becomeFirstResponder()
            }
            else if textField == box3 {
                box4.becomeFirstResponder()
            }
            else {
                textField.resignFirstResponder()
            }
            return false
        }
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField.text?.count ?? 0) > 0 {

        }
        return true
    }
    
    @IBAction func activateAccountClick(_ sender: Any) {
        showActivityIndicator()
        activateButton.isEnabled=false
        var code = "\(box1.text!)\(box2.text!)\(box3.text!)\(box4.text!)"
        insert.activateAccount(code: Int(code)!)
        {
            (status)
            in
            if status.response == 0 {
                let alert = UIAlertController(title: "Bildiriş", message: "Akauntunuz uğurla təsdiqləndi", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                self.performSegue(withIdentifier: "backToLogin", sender: self)
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
                
                let alert = UIAlertController(title: "Oops", message: "Hall hazırda serverlərimizdə problem yaşanır və biz artıq bunun üzərində çalışırıq", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                 alert.addAction(UIAlertAction(title: "Ətraflı", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                    let alert = UIAlertController(title: "Ətraflı", message: "Ətraflı: Kod: \(status.response!)\n\(status.responseString ?? "")", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                     self.present(alert, animated: true, completion: nil)
                 }))
                self.present(alert, animated: true, completion: nil)
            }
            self.hideActivityIndicator()
            self.activateButton.isEnabled=true
        }
        
    }
    func showActivityIndicator() {
            DispatchQueue.main.async {
               self.loadingView = UIView()
               self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
               self.loadingView.center = self.view.center
               self.loadingView.backgroundColor = UIColor.black
               self.loadingView.alpha = 0.7
               self.loadingView.clipsToBounds = true
               self.loadingView.layer.cornerRadius = 10

               self.spinner = UIActivityIndicatorView(style: .whiteLarge)
               self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
               self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)

               self.loadingView.addSubview(self.spinner)
               self.view.addSubview(self.loadingView)
               self.spinner.startAnimating()
           }
       }

       func hideActivityIndicator() {
            DispatchQueue.main.async {
               self.spinner.stopAnimating()
               self.loadingView.removeFromSuperview()
           }
       }
    
//    @IBAction func backToLogin_Click(_ sender: Any) {
//        self.dismiss(animated:true)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
