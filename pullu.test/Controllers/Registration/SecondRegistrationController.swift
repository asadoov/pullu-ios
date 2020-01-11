//
//  SecondRegistrationController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/11/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class SecondRegistrationController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var newUser: NewUser = NewUser()
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var bDate: UIDatePicker!
    
    @IBOutlet weak var gender: UIPickerView!
    
    let genders=["Cins","Kişi","Qadın"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        //print(String(newUser.pass!))
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  genders.count
    }
    
    @IBAction func nextClick(_ sender: Any) {
        var currentDate = Date()
        
        
        // 1) Create a DateFormatter() object.
        let format = DateFormatter()
        
        // 2) Set the current timezone to .current, or America/Chicago.
        format.timeZone = .current
        
        // 3) Set the format of the altered date.
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        // 4) Set the current date, altered by timezone.
        let dateString = format.string(from: currentDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dt = dateFormatter.date(from: dateString)
        print(dt)
        if((!name.text!.isEmpty) && (!surname.text!.isEmpty) && (!phone.text!.isEmpty) && (bDate.date<dt!)){
            var birthDate = Date()
            birthDate = bDate.date
            newUser.name=name.text
            newUser.surname=surname.text
            newUser.phone=phone.text
            newUser.bDate=birthDate
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            var dateString = dateFormatter.string(from: newUser.bDate!)
            var selectedGender = gender.selectedRow(inComponent: 0)
            
            print( dateString+"\n" + String(selectedGender))
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "thirdRegPage", sender: self)
            }
            
        }
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
