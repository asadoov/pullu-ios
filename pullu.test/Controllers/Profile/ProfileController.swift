//
//  ProfileController.swift
//  pullu.test
//
//  Created by Rufat on 2/13/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

//Cavidan Mirzə

class ProfileController: UIViewController {


    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var mobileNumField: UITextField!
    @IBOutlet weak var dogumTarixField: UITextField!
    @IBOutlet weak var cinsPicker: UIPickerView!
    @IBOutlet weak var sheherField: UILabel!
    @IBOutlet weak var ixtisasField: UIPickerView!
    @IBOutlet weak var qoshulmaTarixField: UILabel!
    
    var defaults = UserDefaults.standard
    var select:dbSelect=dbSelect()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let mail = defaults.string(forKey: "mail")
//        let pass = defaults.string(forKey: "pass")
//        select.getProfileInfo(mail: mail!, pass: pass!) {
//            (profile)
//            in
//            DispatchQueue.main.async {
//                self.emailField.text = String(profile.self)
//            }
//        }
        

        // Do any additional setup after loading the view.
      
        
      
        

       // saveBtn.layer.insertSublayer(gradient, at: 0)
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
