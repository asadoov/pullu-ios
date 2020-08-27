//
//  AuditoryController.swift
//  pullu.test
//
//  Created by Rufat on 3/30/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class AuditoryController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var ageRangePicker: UIPickerView!
   
    var newAdvertisement:NewAdvertisementStruct = NewAdvertisementStruct()
    var newAPreview:NewAPreviewStruct = NewAPreviewStruct()
    var countries:Array<Country> = []
    var cities:Array<City> = []
    var genders:Array<String> = []
    var professions:Array<Profession> = []
    var ageRanges:Array<AgeRangeStruct> = []
    var select:DbSelect = DbSelect()
    var interestIds:Array<Int> = Array<Int>()
    @IBOutlet weak var chooseInterestsButton: UIButton!
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
        
        // Do any additional setup after loading the view.
        genders.append("Bütün cinslər")
        genders.append("Kişi")
        genders.append("Qadın")
        var chooseCountry:Country = Country()
        chooseCountry.id = 0
        chooseCountry.name = "Bütün ölkələr"
        self.countries.append(chooseCountry)
        var chooseCity:City = City()
        chooseCity.id = 0
        chooseCity.name = "Bütün şəhərlər"
        self.cities.append(chooseCity)
        let chooseAge:AgeRangeStruct = AgeRangeStruct()
        chooseAge.id = 0
        chooseAge.range = "Bütün yaşlar"
        self.ageRanges.append(chooseAge)
        
        var chooseProfession:Profession = Profession()
        chooseProfession.id = 0
        chooseProfession.name = "Bütün ixtisaslar"
        self.professions.append(chooseProfession)
        
        self.countryPicker.reloadAllComponents()
        self.cityPicker.reloadAllComponents()
        self.genderPicker.reloadAllComponents()
        self.ageRangePicker.reloadAllComponents()
       
        select.GetCounties(){
            
            (list)
            in
            
            self.countries+=list
            DispatchQueue.main.async {
                self.countryPicker.reloadAllComponents()
            }
        }
        select.GetAgeRange(){
            
            (list)
            in
            
            
            self.ageRanges += list
            DispatchQueue.main.async {
                self.ageRangePicker.reloadAllComponents()
            }
        }
       
        
    }
    @objc func showSpinningWheel(_ notification: NSNotification) {
         print(notification.userInfo ?? "")
         if let dict = notification.userInfo as NSDictionary? {
             if let list = dict["interests"] as? Array<Interest>{
                 // do something with your image
                if list.count>0{
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
     }
    
    @IBAction func chooseInterestsClick(_ sender: Any) {
         self.performSegue(withIdentifier: "chooseInterestsSegue", sender: self)
    }
    
    
    
    @IBAction func finishButton(_ sender: Any) {
        
        if newAdvertisement.aCountryID == nil {
            newAdvertisement.aCountryID = 0
            newAPreview.aCountry = "Hamısı"
        }
        if newAdvertisement.aCityID == nil {
            newAdvertisement.aCityID = 0
            newAPreview.aCity = "Hamısı"
        }
        if newAdvertisement.aGenderID == nil {
            newAdvertisement.aGenderID = 0
            newAPreview.aGender = 0
        }
        if newAdvertisement.aAgeRangeID == nil {
            newAdvertisement.aAgeRangeID = 0
            newAPreview.aAgeRange = "Hamısı"
        }
//        if newAdvertisement.aProfessionID == nil {
//            newAdvertisement.aProfessionID = 0
//            newAPreview.aProfession = "Hamısı"
//        }
//        newAdvertisement.mail = defaults.string(forKey: "mail")
//        newAdvertisement.pass = defaults.string(forKey: "pass")
          self.performSegue(withIdentifier: "previewController", sender: self)
        
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == countryPicker {
            
            return countries[row].name
        }
        if pickerView == cityPicker {
            
            return cities[row].name
        }
        if pickerView == genderPicker {
            
            return genders[row]
        }
        if pickerView == ageRangePicker {
            
            return ageRanges[row].range
        }
        
       
        return ""
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int=countries.count
        if pickerView == countryPicker {
            countrows = self.countries.count
        }
        if pickerView == cityPicker {
            countrows = self.cities.count
        }
        if pickerView == genderPicker {
            countrows = self.genders.count
        }
        if pickerView == ageRangePicker {
            countrows = self.ageRanges.count
        }
       
        
        return countrows
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView==countryPicker{
            
            let selectedRow = countryPicker.selectedRow(inComponent: 0)
            newAdvertisement.aCountryID = selectedRow
            newAPreview.aCountry = countries[row].name
            if selectedRow>0{
                select.GetCities(countryId:selectedRow){
                    (list)
                    in
                    
                    for city in list{
                        self.cities.append(city)
                        //print(city.name)
                    }
                    DispatchQueue.main.async {
                        
                        self.cityPicker.reloadAllComponents();
                    }
                    
                }
            }
            else {
                self.cities.removeAll()
                var choose:City = City()
                choose.id = 0;
                choose.name = "Hamısı"
                self.cities.append(choose)
                DispatchQueue.main.async {
                    
                    self.cityPicker.reloadAllComponents();
                }
                
                
            }
            
        }
        if pickerView==cityPicker{
            newAdvertisement.aCityID = cities[row].id
            newAPreview.aCity = cities[row].name
            
        }
        if pickerView==genderPicker{
            newAdvertisement.aGenderID = row
            newAPreview.aGender = row
            
        }
        if pickerView==ageRangePicker{
            newAdvertisement.aAgeRangeID = ageRanges[row].id
            newAPreview.aAgeRange = ageRanges[row].range
        }
        
        
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if(segue.identifier == "previewController"){
                let displayVC = segue.destination as! PreviewController
                displayVC.newAdvertisement = newAdvertisement
                displayVC.newAPreview = newAPreview
            }
       
            
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
     
    
}
