//
//  ThirdRegistrationController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/12/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class ThirdRegistrationController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var countries: UIPickerView!
    @IBOutlet weak var cities: UIPickerView!
    @IBOutlet weak var professions: UIPickerView!
    var countriesList = ["Ölkəni seçin"]
    var cityList = ["Şəhəri seçin"]
    var professionList = ["Sektoru seçin"]
    let db:dbSelect=dbSelect()
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
                        print(city.name)
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
