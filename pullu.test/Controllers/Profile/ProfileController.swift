//
//  ProfileController.swift
//  pullu.test
//
//  Created by Rufat on 2/13/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

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
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                dateFormatter.timeZone = TimeZone.current
                dateFormatter.locale = Locale.current
                let dt = dateFormatter.date(from: list[0].bDate!)
                let dtc = dateFormatter.date(from: list[0].cDate!)
                dateFormatter.dateFormat = "dd.MM.yyyy"
                
                
                self.emailField.text = list[0].mail
                self.nameField.text = list[0].name
                self.surnameField.text = list[0].surname
                self.mobileNumField.text = list[0].phone
                //self.dogumTarixField.text = list[0].bDate
                //self.creatDate.text = list[0].cDate
                self.genderBtn.titleLabel?.text = list[0].gender
                self.prefessionBtn.titleLabel?.text = list[0].profession
                self.cityBtn.titleLabel?.text = list[0].city
                self.dogumTarixField.text = dateFormatter.string(from: dt!)
                self.creatDate.text = dateFormatter.string(from: dtc!)
              
            }
            
            
        }
        
        
        
        // Do any additional setup after loading the view.
        
        // saveBtn.layer.insertSublayer(gradient, at: 0)
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "editProfSegue", sender: self)
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
