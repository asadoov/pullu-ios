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
    @IBOutlet weak var professionPicker: UIPickerView!
    
    var countries:Array<Country> = []
    var cities:Array<City> = []
    var genders:Array<String> = []
    var professions:Array<Profession> = []
    var ageRanges:Array<AgeRangeStruct> = []
    var db:dbSelect = dbSelect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        genders.append("Kişi")
        genders.append("Qadın")
        var chooseCountry:Country = Country()
        chooseCountry.ID = 0
        chooseCountry.name = "Ölkəni seçin.."
        self.countries.append(chooseCountry)
        var chooseCity:City = City()
              chooseCity.ID = 0
              chooseCity.name = "---"
              self.cities.append(chooseCity)
        let chooseAge:AgeRangeStruct = AgeRangeStruct()
        chooseAge.id = 0
        chooseAge.range = "Yaş seçin.."
        self.ageRanges.append(chooseAge)
        
        var chooseProfession:Profession = Profession()
        chooseProfession.ID = 0
        chooseProfession.name = "Sektor seçin.."
        self.professions.append(chooseProfession)
        
        self.countryPicker.reloadAllComponents()
        self.cityPicker.reloadAllComponents()
        self.genderPicker.reloadAllComponents()
        self.ageRangePicker.reloadAllComponents()
        self.professionPicker.reloadAllComponents()
        db.getCounties(){
            
            (list)
            in
            
            self.countries+=list
            DispatchQueue.main.async {
                self.countryPicker.reloadAllComponents()
            }
        }
        db.getAgeRange(){
            
            (list)
            in
            
            
            self.ageRanges += list
            DispatchQueue.main.async {
                self.ageRangePicker.reloadAllComponents()
            }
        }
        db.getProfessions(){
            
            (list)
            in
            
            self.professions += list
            DispatchQueue.main.async {
                self.professionPicker.reloadAllComponents()
            }
        }
        
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
        
        if pickerView == professionPicker {
            
            return professions[row].name
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
        if pickerView == professionPicker {
            countrows = self.professions.count
        }
        
        return countrows
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView==countryPicker{
            
            let selectedRow = countryPicker.selectedRow(inComponent: 0)
            if selectedRow>0{
                db.getCities(countryId:selectedRow){
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
                choose.ID = 0;
                choose.name = "Şəhəri seçin"
                self.cities.append(choose)
                DispatchQueue.main.async {
                    
                    self.cityPicker.reloadAllComponents();
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
