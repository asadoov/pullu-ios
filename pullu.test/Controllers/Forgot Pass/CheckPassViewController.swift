//
//  CheckPassViewController.swift
//  pullu.test
//
//  Created by Javidan Mirza on 3/11/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class CheckPassViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pass1text: UITextField!
    @IBOutlet weak var pass2text: UITextField!
    @IBOutlet weak var pass3text: UITextField!
    @IBOutlet weak var pass4text: UITextField!
    var dbIns : DbInsert = DbInsert()
    var usrEmail: String = ""
    var verifyNumber: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pass1text.delegate = self
        pass2text.delegate = self
        pass3text.delegate = self
        pass4text.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if !(string == "") {
                textField.text = string
                if textField == pass1text {
                    pass2text.becomeFirstResponder()
                }
                else if textField == pass2text {
                    pass3text.becomeFirstResponder()
                }
                else if textField == pass3text {
                    pass4text.becomeFirstResponder()
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
    
    

    @IBAction func nextButton(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: "Yüklənir...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        
        
         verifyNumber = "\(pass1text.text!)\(pass2text.text!)\(pass3text.text!)\(pass4text.text!)"
        
        print(verifyNumber)
        dbIns.checkSendCode(mail: usrEmail, code: verifyNumber) {
            (Status) in
            
            
            
            switch Status.response {
                
            case 0:
                self.dismiss(animated: false) {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "changePassSegue", sender: self)
                }
                }
                break
                
            case 1:
                self.dismiss(animated: false) {
                let alert = UIAlertController(title: "Bildiriş", message: " Şifrə yalnışdır ", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)}
                break
                
                case 2:
                    self.dismiss(animated: false) {
                let alert = UIAlertController(title: "Bildiriş", message: "Server Error", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)}
                
                break
            default : break
            }
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "changePassSegue") {
            let changeParam = segue.destination as! CreatePassViewController
            changeParam.usrEml = usrEmail
            changeParam.usrCode = verifyNumber
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    

}
