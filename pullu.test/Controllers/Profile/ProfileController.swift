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
    
    
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var mobileNumField: UITextField!
    @IBOutlet weak var dogumTarixField: UITextField!
    @IBOutlet weak var creatDate: UITextField!
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var prefessionBtn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    
    
    
    
    
    var defaults = UserDefaults.standard
    var select:dbSelect=dbSelect()
    var profilM: [ProfileModel] = [ProfileModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let pass = defaults.string(forKey: "pass")
        let mail = defaults.string(forKey: "mail")
        select.getProfileInfo(mail: mail, pass: pass) {
            (list) in
   
            DispatchQueue.main.async {
                self.emailField.text = list[0].mail
                self.nameField.text = list[0].name
                self.surnameField.text = list[0].surname
                self.mobileNumField.text = list[0].phone
                self.dogumTarixField.text = list[0].bDate
                self.creatDate.text = list[0].cDate
                self.genderBtn.titleLabel?.text = list[0].gender
                self.prefessionBtn.titleLabel?.text = list[0].profession
                self.cityBtn.titleLabel?.text = list[0].city
                
                
              
            }
            
        }
        
        
        
        // Do any additional setup after loading the view.
        
        // saveBtn.layer.insertSublayer(gradient, at: 0)
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        
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
