//
//  logIn.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/7/20.
//  Copyright © 2020 Javidan Mirza. All rights reserved.
//

import UIKit

class logIn: UIViewController {
    
    
    
    
    @IBOutlet weak var uName: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    @IBAction func SignIn_Click(_ sender: Any) {
        var usrList:Array<User>=Array<User>()
        let db: dbSelect=dbSelect()
        if (uName.text != "" && pass.text != "") {
            db.SignIn(username: uName.text!, pass: pass.text!) { (rslt) in
                
                usrList = rslt
                if(usrList.count > 0){
                    
                    print(usrList[0].mail)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "segue", sender: self)
                        
                    }
                    
                }
                    
                    
                    
                    
                    
                    
                else{
                    DispatchQueue.main.async {
                        
                        let alert = UIAlertController(title: "Bildiriş", message: "Məlumat səhfdi", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)}
                    
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
    
    
    
    
}
