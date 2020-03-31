//
//  ProfileController.swift
//  pullu.test
//
//  Created by Rufat on 2/13/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Firebase

//Cavidan Mirzə

class ProfileController: UIViewController {
    
    var defaults = UserDefaults.standard
    var select:dbSelect=dbSelect()
    //var profilM: [ProfileModel] = [ProfileModel]()
    
    @IBOutlet weak var nameFiel: UITextField!
    @IBOutlet weak var surnameFiel: UITextField!
    @IBOutlet weak var phoneNFiel: UITextField!
    @IBOutlet weak var bdateFiel: UITextField!
    @IBOutlet weak var cDateFiel: UITextField!
    @IBOutlet weak var emailFiel: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let pass = defaults.string(forKey: "pass")
        let mail = defaults.string(forKey: "mail")
        select.getProfileInfo(mail: mail, pass: pass) {
            (profileList) in
            
            let list2 = profileList[0]
            
            func reloadData() {
            DispatchQueue.main.async {
                self.nameFiel.text = list2.name
                self.surnameFiel.text = list2.surname
                self.phoneNFiel.text = list2.phone
                self.emailFiel.text = list2.mail
            }
            }
        }
        
        
        
        // Do any additional setup after loading the view.
        
        // saveBtn.layer.insertSublayer(gradient, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .blue
        super.viewWillDisappear(animated)
        
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
