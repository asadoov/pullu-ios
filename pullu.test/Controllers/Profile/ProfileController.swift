//
//  ProfileController.swift
//  pullu.test
//
//  Created by Rufat on 2/13/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

//Cavidan Mirzə

class ProfileController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var genderList = ["Kişi","Qadın"]
    var countriesList = ["Ölkəni seçin"]
       var cityList = ["Şəhəri seçin"]
       var professionList = ["Sektoru seçin"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
var countrows : Int=genderList.count
        
//if pickerView == countries {
//    countrows = self.countriesList.count
//}
//if pickerView == cities {
//    countrows = self.cityList.count
//}
//if pickerView == professions {
//    countrows = self.professionList.count
//}

return countrows
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
         return genderList[row]
//        if pickerView == countries {
//
//            return countriesList[row]
//        }
//        if pickerView == cities {
//
//            return cityList[row]
//        }
//        if pickerView == professions {
//
//            return professionList[row]
//        }
        return ""
        
    }
    
    
    
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var mobileNumField: UITextField!
    @IBOutlet weak var dogumTarixField: UITextField!
    @IBOutlet weak var createdDate: UITextField!
    
    @IBOutlet weak var genderButton: UIButton!
    
    @IBOutlet weak var professionButton: UIButton!
    
    @IBOutlet weak var countryButton: UIButton!
    
    @IBOutlet weak var cityButton: UIButton!
    
    
    
    var defaults = UserDefaults.standard
    var select:dbSelect=dbSelect()
    var profileList: [ProfileModel] = [ProfileModel]()
     var uProfile = UpdateProfileStruct()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        
        let pass = defaults.string(forKey: "pass")
        let mail = defaults.string(forKey: "mail")
        select.getProfileInfo(mail: mail, pass: pass) {
            (list) in
            self.profileList = list
            DispatchQueue.main.async {
                self.emailField.text = list[0].mail
                self.nameField.text = list[0].name
                self.surnameField.text = list[0].surname
                self.mobileNumField.text = list[0].phone
                self.genderButton.setTitle(list[0].gender, for: .normal)
                  self.countryButton.setTitle(list[0].country, for: .normal)
            self.cityButton.setTitle(list[0].city, for: .normal)
           
                
                var bFormattedDate = dateFormatter.date(from: list[0].bDate!)
                var createdFormattedDate = dateFormatter.date(from: list[0].cDate!)
                dateFormatter.dateFormat = "dd.MM.yyyy"
                self.dogumTarixField.text = dateFormatter.string(from:bFormattedDate!)
                self.createdDate.text = dateFormatter.string(from:createdFormattedDate!)
                
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
    @IBAction func genderButtonClick(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        let editRadiusAlert = UIAlertController(title: "Cinsi seçin...", message: "", preferredStyle: UIAlertController.Style.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)
//        let myDatePicker: UIDatePicker = UIDatePicker()
//        myDatePicker.timeZone = .current
//          myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
//          let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
//          alertController.view.addSubview(myDatePicker)
//          let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
//              print("Selected Date: \(myDatePicker.date)")
//          })
//          let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//          alertController.addAction(selectAction)
//          alertController.addAction(cancelAction)
//          present(alertController, animated: true)
    }
    
    @IBAction func professionClick(_ sender: Any) {
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
   
        
        if(nameField.text != profileList[0].name){
            uProfile.name = nameField.text
            
        }
        if(surnameField.text != profileList[0].name){
            uProfile.surname = surnameField.text
            
        }
        if(mobileNumField.text != profileList[0].phone){
            uProfile.phone = mobileNumField.text
            
        }
        if(emailField.text != profileList[0].mail){
                 uProfile.mail = emailField.text
                 
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
