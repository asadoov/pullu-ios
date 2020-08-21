//
//  RegLastController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 7/15/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import MBProgressHUD
class RegLastController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var select:DbSelect = DbSelect()
    var insert:DbInsert = DbInsert()
    var newUser: NewUser = NewUser()
    @IBOutlet weak var nameBox: UITextField!
    @IBOutlet weak var surnameBox: UITextField!
    @IBOutlet weak var mailBox: UITextField!
    @IBOutlet weak var bDateBox: UITextField!
    @IBOutlet weak var genderBox: UITextField!
    @IBOutlet weak var countryBox: UITextField!
    @IBOutlet weak var cityBox: UITextField!
    @IBOutlet weak var chooseInterestsButton: UIButton!
    let defaults = UserDefaults.standard
    
    var defaultCity:City = City()
    var loadingAlert:MBProgressHUD?
    var bDatePicker = UIDatePicker()
    var genderPicker = UIPickerView()
    let genderList=["Cins","Kişi","Qadın"]
    var countryPicker = UIPickerView()
    var counryList:Array<Country>=Array<Country>()
    var cityPicker = UIPickerView()
    var cityList:Array<City> = Array<City>()
    //var interestList:Array<Interest> = Array<Interest>()
    var interestIds:Array<Int> = Array<Int>()
    var selectedGenderID = 0
    var selectedCountryID = 0
    var selectedCityID = 0
    var phoneNum:Int?
    var otp:Int?
    var password:String?
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == genderPicker {
            
            return genderList[row]
        }
        if pickerView == countryPicker {
            
            return counryList[row].name
        }
        if pickerView == cityPicker {
            
            return cityList[row].name
        }
        return ""
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows = 0
        if pickerView == genderPicker {
            countrows = self.genderList.count
        }
        if pickerView == countryPicker {
            countrows = self.counryList.count
        }
        if pickerView == cityPicker {
            
            countrows = self.cityList.count
        }
        
        
        return countrows
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView==genderPicker{
            let selectedRow = genderPicker.selectedRow(inComponent: 0)
            if selectedRow>0{
                self.selectedGenderID = row
                
                
                self.genderBox.text = self.genderList[row]
            }
            else{
                self.genderBox.text = ""
            }
        }
        if pickerView==countryPicker{
            
            let selectedRow = countryPicker.selectedRow(inComponent: 0)
            if selectedRow>0{
                self.cityList.removeAll()
                defaultCity.name = "Şəhəri seçin"
                self.cityList.append(defaultCity)
                select.GetCities(countryId:self.counryList[row].id!){
                    (list)
                    in
                    
                    for city in list{
                        self.cityList.append(city)
                        //print(city.name)
                    }
                    DispatchQueue.main.async {
                        self.selectedCountryID = self.counryList[row].id!
                        self.countryBox.text = self.counryList[row].name
                        self.cityPicker.reloadAllComponents();
                    }
                    
                }
            }
            else {
                self.countryBox.text = ""
                self.cityList.removeAll()
                
                defaultCity.name = "İlk öncə ökəni seçin"
                self.cityList.append(defaultCity)
                DispatchQueue.main.async {
                    
                    self.cityPicker.reloadAllComponents();
                }
                
                
            }
            
        }
        if pickerView==cityPicker{
            let selectedRow = cityPicker.selectedRow(inComponent: 0)
            if selectedRow>0{
                selectedCityID = self.cityList[row].id!
                self.cityBox.text = self.cityList[row].name
            }
            else {
                self.cityBox.text = ""
            }
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        DispatchQueue.main.async {
            self.loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
            self.loadingAlert!.mode = MBProgressHUDMode.indeterminate
        }
        
        // Register to receive notification in your class
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
        
        
        bDatePicker.datePickerMode = .date
        let currentDate = NSDate()  //get the current date
        bDatePicker.maximumDate = currentDate as Date  //set the current date/time as a maximum
        bDatePicker.date = currentDate as Date
        bDatePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        countryPicker.delegate = self
        countryPicker.dataSource = self
        cityPicker.delegate = self
        cityPicker.dataSource = self
        bDateBox.inputView = bDatePicker
        genderBox.inputView = genderPicker
        countryBox.inputView = countryPicker
        cityBox.inputView = cityPicker
        defaultCity.name = "İlk öncə ökəni seçin"
        self.cityList.append(defaultCity)
        var defaultCountry:Country = Country()
        defaultCountry.name = "Ölkəni seçin"
        self.counryList.append(defaultCountry)
        select.GetCounties(){
            (list) in
            DispatchQueue.main.async {
                self.loadingAlert?.hide(animated: true)
            }
            for item in list{
                self.counryList.append(item)
                DispatchQueue.main.async {
                    self.countryPicker.reloadAllComponents();
                }
            }
            
        }
        // Do any additional setup after loading the view.
    }
    @objc func datePickerChanged(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let dateString = dateFormatter.string(from: bDatePicker.date)
        bDateBox.text = dateString
    }
    
    
    @IBAction func finishRegClick(_ sender: Any) {
        if (!nameBox.text!.isEmpty && !surnameBox.text!.isEmpty && !mailBox.text!.isEmpty && !bDateBox.text!.isEmpty && !genderBox.text!.isEmpty && !countryBox.text!.isEmpty && !cityBox.text!.isEmpty && interestIds.count > 0)
        {
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateString = dateFormatter.string(from: bDatePicker.date)
            if calcAge(birthday: dateString) <= 18 {
                let alert = UIAlertController(title: "Bildiriş", message: "Yaşınız 18 dən yuxarı olmalıdı", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                DispatchQueue.main.async {
                           self.loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                           self.loadingAlert!.mode = MBProgressHUDMode.indeterminate
                       }
                // print("18+")
                newUser.name = nameBox.text!
                newUser.surname = surnameBox.text!
                newUser.mail = mailBox.text!
                newUser.phone = phoneNum
                newUser.pass = password
                newUser.gender = selectedGenderID
                newUser.bDate = bDateBox.text!
                newUser.country = selectedCountryID
                newUser.city = selectedCityID
                newUser.interestIds = interestIds
                newUser.otp = otp
                insert.signUp(newUserData: newUser){
                    (statusCode)
                    in
                    DispatchQueue.main.async {
                        self.loadingAlert?.hide(animated: true)
                           }
                    do {
                        self.defaults.set(self.newUser.mail, forKey: "mail")
                        self.defaults.set(self.newUser.pass, forKey: "pass")
                        
                        switch statusCode.response {
                        case 1:
                            self.performSegue(withIdentifier: "successRegPage", sender: self)
                            break
                        case 2:
                            let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                            warningAlert.mode = MBProgressHUDMode.text
                            //            warningAlert.isSquare=true
                            warningAlert.label.text = "Xəta"
                            warningAlert.detailsLabel.text = "Biraz sonra birdaha cəhd edin"
                            warningAlert.hide(animated: true,afterDelay: 3)
                            break
                        case 3:
                            let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                                                       warningAlert.mode = MBProgressHUDMode.text
                                                       //            warningAlert.isSquare=true
                                                       warningAlert.label.text = "Diqqət"
                                                       warningAlert.detailsLabel.text = "Istifadəçi tapılmadı"
                                                       warningAlert.hide(animated: true,afterDelay: 3)
                            break
                        case 4:
                            let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                                                       warningAlert.mode = MBProgressHUDMode.text
                                                       //            warningAlert.isSquare=true
                                                       warningAlert.label.text = "Diqqət"
                                                       warningAlert.detailsLabel.text = "Istifadəçi artıq aktivdir"
                                                       warningAlert.hide(animated: true,afterDelay: 3)
                            break
                            case 5:
                            let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                                                       warningAlert.mode = MBProgressHUDMode.text
                                                       //            warningAlert.isSquare=true
                                                       warningAlert.label.text = "Xəta"
                                                       warningAlert.detailsLabel.text = "Biraz sonra birdaha cəhd edin"
                                                       warningAlert.hide(animated: true,afterDelay: 3)
                            break
                        default:
                            break
                            
                            
                        }
                        
                       
                        
                        // print("JSON String : " + jsonString!)
                    }
                    catch {
                        let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                        warningAlert.mode = MBProgressHUDMode.text
                        //            warningAlert.isSquare=true
                        warningAlert.label.text = "Xəta"
                        warningAlert.detailsLabel.text = "Biraz sonra birdaha cəhd edin"
                        warningAlert.hide(animated: true,afterDelay: 3)
                        
                        
                        
                    }
                    
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Bildiriş", message: "Bütün boşluqları doldurun!", preferredStyle: UIAlertController.Style.alert)
                           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                           self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func chooseInterestsClick(_ sender: Any) {
        self.performSegue(withIdentifier: "chooseInterestsSegue", sender: self)
    }
    // handle notification
    @objc func showSpinningWheel(_ notification: NSNotification) {
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary? {
            if let list = dict["interests"] as? Array<Interest>{
                // do something with your image
                        chooseInterestsButton.setTitle("", for: .normal)
                self.interestIds.removeAll()
                for item in list{
                    self.interestIds.append(item.id!)
                    // print(item)
                    if item.id == list.first?.id {
                        
                        chooseInterestsButton.setTitle("\(item.name!)", for: .normal)
                    }
                    else{
                        
                        chooseInterestsButton.setTitle("\(chooseInterestsButton.title(for: .normal)!), \(item.name!)", for: .normal)
                        
                    }
                    
                }
                
            }
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM-dd-yyyy"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
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
