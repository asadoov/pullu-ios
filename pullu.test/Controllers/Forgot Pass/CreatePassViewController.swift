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
    var usrEml: String = ""
    var usrCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func okButton(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: "Yüklənir...", preferredStyle: .alert)
               
               let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
               loadingIndicator.hidesWhenStopped = true
               loadingIndicator.style = UIActivityIndicatorView.Style.gray
               loadingIndicator.startAnimating();
               
               
               alert.view.addSubview(loadingIndicator)
               present(alert, animated: true, completion: nil)
        
        dbIns.createNewPass(newpass: newPassText.text!, mail: usrEml, code: usrCode){
            (statu) in
            
            
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
