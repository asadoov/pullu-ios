//
//  ThirdRegistrationController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/12/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import  MBProgressHUD
class ThirdRegistrationController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let defaults = UserDefaults.standard
    var newUser: NewUser = NewUser()
    @IBOutlet weak var countries: UIPickerView!
    @IBOutlet weak var cities: UIPickerView!
    @IBOutlet weak var professions: UIPickerView!
    var countriesList = ["Ölkəni seçin"]
    var cityList = ["Şəhəri seçin"]
    var professionList = ["Sektoru seçin"]
    let db:dbSelect=dbSelect()
    let dbInsert:DbInsert=DbInsert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        db.getCounties(){
            (list) in
            for item in list{
                self.countriesList.append(item.name!)
                DispatchQueue.main.async {
                    self.countries.reloadAllComponents();
                }
            }
            
        }
        db.getProfessions(){
            (list) in
            for item in list{
                self.professionList.append(item.name!)
                DispatchQueue.main.async {
                    self.professions.reloadAllComponents();
                }
            }
            
        }
        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == countries {
            
            return countriesList[row]
        }
        if pickerView == cities {
            
            return cityList[row]
        }
        if pickerView == professions {
            
            return professionList[row]
        }
        return ""
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int=countriesList.count
        if pickerView == countries {
            countrows = self.countriesList.count
        }
        if pickerView == cities {
            countrows = self.cityList.count
        }
        if pickerView == professions {
            countrows = self.professionList.count
        }
        
        return countrows
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView==countries{
            
            let selectedRow = countries.selectedRow(inComponent: 0)
            if selectedRow>0{
                db.getCities(countryId:selectedRow){
                    (list)
                    in
                    
                    for city in list{
                        self.cityList.append(city.name!)
                        //print(city.name)
                    }
                    DispatchQueue.main.async {
                        
                        self.cities.reloadAllComponents();
                    }
                    
                }
            }
            else {
                self.cityList.removeAll()
                self.cityList.append("Şəhəri seçin")
                DispatchQueue.main.async {
                    
                    self.cities.reloadAllComponents();
                }
                
                
            }
            
        }
        
    }
    
    
    @IBAction func finishClick(_ sender: Any) {
        
        let selectedCountry = countriesList[countries.selectedRow(inComponent: 0)]
        let selectedCity = cityList[cities.selectedRow(inComponent: 0)]
        let selectedProfession = professionList[professions.selectedRow(inComponent: 0)]
        newUser.country=selectedCountry
        newUser.city=selectedCity
        newUser.sector=selectedProfession
        //print("\(newUser.bDate)")
        if !selectedCountry.isEmpty && !selectedCity.isEmpty && !selectedProfession.isEmpty{
            do{
                dbInsert.SignUp(newUserData: newUser){
                    (statusCode)
                    in
                    
                    do {
                        self.defaults.set(self.newUser.mail, forKey: "mail")
                        self.defaults.set(self.newUser.pass, forKey: "pass")
                        
                        
                        if statusCode.response==0{
                            
                            self.performSegue(withIdentifier: "successRegPage", sender: self)
                        }
                        if statusCode.response==1   {
                            let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                            warningAlert.mode = MBProgressHUDMode.text
                            //            warningAlert.isSquare=true
                            warningAlert.label.text = "Xəta"
                            warningAlert.detailsLabel.text = "Biraz sonra birdaha cəhd edin"
                            warningAlert.hide(animated: true,afterDelay: 3)
                            
                        }
                        if statusCode.response==2   {
                            let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                            warningAlert.mode = MBProgressHUDMode.text
                            //            warningAlert.isSquare=true
                            warningAlert.label.text = "Diqqət"
                            warningAlert.detailsLabel.text = "Mail artıq mövcuddur"
                            warningAlert.hide(animated: true,afterDelay: 3)
                            
                            
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
            catch{
                let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                warningAlert.mode = MBProgressHUDMode.text
                //            warningAlert.isSquare=true
                warningAlert.label.text = "Xəta"
                warningAlert.detailsLabel.text = "Biraz sonra birdaha cəht edin"
                warningAlert.hide(animated: true,afterDelay: 3)
                
                
                
            }
        }
        else
        {
            
            let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
            warningAlert.mode = MBProgressHUDMode.text
            //            warningAlert.isSquare=true
            warningAlert.label.text = "Diqqət"
            warningAlert.detailsLabel.text = "Zəhmət olmasa bütün boşluqların doldurulmasından "
            warningAlert.hide(animated: true,afterDelay: 3)
        }
        
        // print(selectedCountry)
        
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
