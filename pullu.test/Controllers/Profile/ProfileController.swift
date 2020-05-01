//
//  ProfileController.swift
//  pullu.test
//
//  Created by Javidan Mirza on 4/30/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class ProfileController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var insert:DbInsert = DbInsert()
    var genderList = ["Kişi","Qadın"]
    var professionList: [Profession] = [Profession]()
    //var countriesList: [Country] = [Country]()
    var cityList: [City] = [City]()
    var countryID:Int?
    let genderPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
    let professionPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
    
    //     let countriesPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
    
    let cityPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
    
    var infoChanged=false
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int=genderList.count
        
        if pickerView == genderPicker {
            countrows = self.genderList.count
        }
        if pickerView == professionPicker {
            countrows = self.professionList.count
        }
        if pickerView == cityPicker {
            countrows = self.cityList.count
        }
        //if pickerView == cities {
        //    countrows = self.cityList.count
        //}
        //if pickerView == professions {
        //    countrows = self.professionList.count
        //}
        
        return countrows
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //return genderList[row]
        if pickerView == genderPicker {
            
            return genderList[row]
        }
        if pickerView == professionPicker {
            
            return professionList[row].name
        }
        if pickerView == cityPicker {
            
            return cityList[row].name
        }
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
    
    // @IBOutlet weak var countryButton: UIButton!
    
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
            self.countryID = self.profileList[0].countryID
            DispatchQueue.main.async {
                self.emailField.text = list[0].mail
                self.nameField.text = list[0].name
                self.surnameField.text = list[0].surname
                self.mobileNumField.text = list[0].phone
                self.genderButton.setTitle(list[0].gender, for: .normal)
                self.professionButton.setTitle(list[0].profession, for: .normal)
                
                //                self.countryButton.setTitle(list[0].country, for: .normal)
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
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        vc.view.addSubview(genderPicker)
        let editRadiusAlert = UIAlertController(title: "Cinsi seçin", message: "", preferredStyle: UIAlertController.Style.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Seç", style: .default, handler: { (action: UIAlertAction!) in
            let selectedGender = self.genderPicker.selectedRow(inComponent: 0)
            self.genderButton.setTitle(self.genderList[selectedGender], for: .normal)
            self.uProfile.genderID = selectedGender
            self.infoChanged=true
        }))
        editRadiusAlert.addAction(UIAlertAction(title: "Bağla", style: .cancel, handler: nil))
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
    
    @IBAction func professionButtonClick(_ sender: Any) {
        
        select.getProfessions(){
            (list)
            in
            self.professionList = list
            
            DispatchQueue.main.async {
                let vc = UIViewController()
                vc.preferredContentSize = CGSize(width: 250,height: 300)
                
                self.professionPicker.delegate = self
                self.professionPicker.dataSource = self
                vc.view.addSubview(self.professionPicker)
                let editRadiusAlert = UIAlertController(title: "Sektoru seçin", message: "", preferredStyle: UIAlertController.Style.alert)
                editRadiusAlert.setValue(vc, forKey: "contentViewController")
                editRadiusAlert.addAction(UIAlertAction(title: "Seç", style: .default, handler: { (action: UIAlertAction!) in
                    let selectedProfession = self.professionList[self.professionPicker.selectedRow(inComponent: 0)].id
                    self.professionButton.setTitle(self.professionList[self.professionPicker.selectedRow(inComponent: 0)].name, for: .normal)

                    self.uProfile.professionID = selectedProfession
                    self.infoChanged=true
                }))
                editRadiusAlert.addAction(UIAlertAction(title: "Bağla", style: .cancel, handler: nil))
                self.present(editRadiusAlert, animated: true)
            }
            
        }
        
        
        
    }
    
    
    
    @IBAction func cityButtonClick(_ sender: Any) {
        
        select.getCities(countryId: countryID){
            (list)
            in
            self.cityList = list
            
            DispatchQueue.main.async {
                let vc = UIViewController()
                vc.preferredContentSize = CGSize(width: 250,height: 300)
                
                self.cityPicker.delegate = self
                self.cityPicker.dataSource = self
                vc.view.addSubview(self.cityPicker)
                let editRadiusAlert = UIAlertController(title: "Şəhəri seçin", message: "", preferredStyle: UIAlertController.Style.alert)
                editRadiusAlert.setValue(vc, forKey: "contentViewController")
                editRadiusAlert.addAction(UIAlertAction(title: "Seç", style: .default, handler: { (action: UIAlertAction!) in
                    let selectedCity = self.cityList[self.cityPicker.selectedRow(inComponent: 0)].id
                     self.cityButton.setTitle(self.cityList[self.cityPicker.selectedRow(inComponent: 0)].name, for: .normal)
                    self.uProfile.cityID = selectedCity
                    self.infoChanged=true
                }))
                editRadiusAlert.addAction(UIAlertAction(title: "Bağla", style: .cancel, handler: nil))
                self.present(editRadiusAlert, animated: true)
            }
        }
        
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        
        if(nameField.text != profileList[0].name){
            uProfile.name = nameField.text
            infoChanged=true
        }
        if(surnameField.text != profileList[0].name){
            uProfile.surname = surnameField.text
            infoChanged=true
        }
        if(mobileNumField.text != profileList[0].phone){
            uProfile.phone = mobileNumField.text
            infoChanged=true
        }
        if(emailField.text != profileList[0].mail){
            uProfile.mail = emailField.text
            infoChanged=true
        }
        if infoChanged {
            let defaults = UserDefaults.standard
            
            // let userData = defaults.string(forKey: "uData")
            let  mail = defaults.string(forKey: "mail")
            let  pass = defaults.string(forKey: "pass")
            uProfile.mail = mail
            uProfile.pass = pass
            
            insert.updateProfile(profile: uProfile)
            {
                (status)
                in
                if status.response == 0{
                    
                    let alert = UIAlertController(title: "Bildiriş", message: "Məlumatlar uğurla yazıldı", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                   // let alert = UIAlertController(title: "Oops", message: "Ətraflı: Kod: \(status.response!)\n\(status.responseString ?? "")", preferredStyle: UIAlertController.Style.alert)
                      let alert = UIAlertController(title: "Oops", message: "Hall hazırda serverlərimizdə problem yaşanır və biz artıq bunun üzərində çalışırıq", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                     alert.addAction(UIAlertAction(title: "Ətraflı", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                        let alert = UIAlertController(title: "Ətraflı", message: "Ətraflı: Kod: \(status.response!)\n\(status.responseString ?? "")", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                         self.present(alert, animated: true, completion: nil)
                     }))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                
            }
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
