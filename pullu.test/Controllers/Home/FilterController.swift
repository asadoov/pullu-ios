//
//  FilterController.swift
//  pullu
//
//  Created by Rufat Asadov on 9/23/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import MBProgressHUD
class FilterController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate  {
    
    var loadingAlert:MBProgressHUD?
    let defaults = UserDefaults.standard
    var isPaidList = ["Bütün elanlar","Pullu","Pulsuz"]
    var isPaidPicker = UIPickerView()
    var catPicker = UIPickerView()
    @IBOutlet weak var minPriceBox: UITextField!
    @IBOutlet weak var maxPriceBox: UITextField!
    @IBOutlet weak var paidInput: UITextField!
    @IBOutlet weak var categoryInput: UITextField!
    let select  = DbSelect()
    var catList = Array<CategoryStruct>()
    var isPaid = 0
    var catID = 0
    var minPrice = 0.0
    var maxPrice = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        isPaid = defaults.integer(forKey: "isPaid")
        catID = defaults.integer(forKey: "catID")
        minPrice = defaults.double(forKey: "minPrice")
        maxPrice = defaults.double(forKey: "maxPrice")
        if minPrice>0
        {  minPriceBox.text = String(minPrice)
        }
        if maxPrice > 0 {
            maxPriceBox.text = String(maxPrice)
        }
        var isPaidRow = 0
        switch isPaid {
        case 1:
            isPaidRow = 1
            paidInput.text = "Pullu"
        case 2:
            isPaidRow = 2
            paidInput.text = "Pulsuz"
        default:
            isPaidRow = 0
            paidInput.text = "Bütün elanlar"
        }
        DispatchQueue.main.async {
            self.isPaidPicker.selectRow(isPaidRow, inComponent: 0, animated: true)
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        
        
        
        isPaidPicker.delegate = self
        isPaidPicker.dataSource = self
        catPicker.delegate = self
        catPicker.dataSource = self
        paidInput.inputView = isPaidPicker
        categoryInput.inputView = catPicker
        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert!.mode = MBProgressHUDMode.indeterminate
        var allCat = CategoryStruct()
        allCat.name = "Bütün kateqoriyalar"
        allCat.id = 0
        catList.append(allCat)
        select.ACategory(){
            (list)
            in
            self.catList += list
            DispatchQueue.main.async {
                if self.catID>0{
                    var i = 0
                    for item in self.catList{
                        
                        if item.id == self.catID
                        {
                            self.categoryInput.text = item.name
                            self.catPicker.selectRow(i, inComponent: 0, animated: true)
                        }
                        
                        i += 1
                    }
                }
                else
                {
                    self.categoryInput.text = "Bütün kateqoriyalar"
                    
                }
                self.catPicker.reloadAllComponents()
                self.loadingAlert?.hide(animated: true)
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    @IBAction func showResults(_ sender: Any) {
        loadingAlert?.show(animated: true)
         self.defaults.set(Double(minPriceBox.text ?? "0"), forKey: "minPrice")
         self.defaults.set(Double(maxPriceBox.text ?? "0"), forKey: "maxPrice")
        if isPaid > 0
        {
            self.defaults.set(isPaid, forKey: "isPaid")
            
            
        }
        self.defaults.set(catID, forKey: "catID")
        loadingAlert?.hide(animated: true)
       self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case isPaidPicker:
            return isPaidList[row]
        case catPicker:
            return catList[row].name
        default:
            return ""
        }
        
        
        //        if pickerView == genderPicker {
        //
        //            return genderList[row]
        //        }
        //        if pickerView == countryPicker {
        //
        //            return counryList[row].name
        //        }
        //        if pickerView == cityPicker {
        //
        //            return cityList[row].name
        //        }
        
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows = 0
        switch pickerView {
        case isPaidPicker:
            countrows = self.isPaidList.count
        case catPicker:
            countrows = self.catList.count
        default:
            countrows = 0
        }
        
        //        if pickerView == genderPicker {
        //            countrows = self.genderList.count
        //        }
        //        if pickerView == countryPicker {
        //            countrows = self.counryList.count
        //        }
        //        if pickerView == cityPicker {
        //
        //            countrows = self.cityList.count
        //        }
        
        
        return countrows
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        switch pickerView {
        case isPaidPicker:
            let selectedRow = isPaidPicker.selectedRow(inComponent: 0)
            // if selectedRow>0{
            //self.selectedGenderID = row
            
            switch selectedRow {
            case 0:
                isPaid = 3
            case 1:
                isPaid = 1
            case 2:
                isPaid = 2
            default:
                isPaid = 0
            }
            
            
            self.paidInput.text = self.isPaidList[row]
        case catPicker:
            let selectedRow = catPicker.selectedRow(inComponent: 0)
            // if selectedRow>0{
            //self.selectedGenderID = row
            catID = Int(catList[selectedRow].id!)
            
            
            
            self.categoryInput.text = catList[row].name
        default:
                self.categoryInput.text = ""
            
        }
        
        //        if pickerView==genderPicker{
        //            let selectedRow = genderPicker.selectedRow(inComponent: 0)
        //            if selectedRow>0{
        //                self.selectedGenderID = row
        //
        //
        //                self.genderBox.text = self.genderList[row]
        //            }
        //            else{
        //                self.genderBox.text = ""
        //            }
        //        }
        //        if pickerView==countryPicker{
        //
        //            let selectedRow = countryPicker.selectedRow(inComponent: 0)
        //            if selectedRow>0{
        //                self.cityList.removeAll()
        //                defaultCity.name = "Şəhəri seçin"
        //                self.cityList.append(defaultCity)
        //                select.GetCities(countryId:self.counryList[row].id!){
        //                    (list)
        //                    in
        //
        //                    for city in list{
        //                        self.cityList.append(city)
        //                        //print(city.name)
        //                    }
        //                    DispatchQueue.main.async {
        //                        self.selectedCountryID = self.counryList[row].id!
        //                        self.countryBox.text = self.counryList[row].name
        //                        self.cityPicker.reloadAllComponents();
        //                    }
        //
        //                }
        //            }
        //            else {
        //                self.countryBox.text = ""
        //                self.cityList.removeAll()
        //
        //                defaultCity.name = "İlk öncə ökəni seçin"
        //                self.cityList.append(defaultCity)
        //                DispatchQueue.main.async {
        //
        //                    self.cityPicker.reloadAllComponents();
        //                }
        //
        //
        //            }
        //
        //        }
        //        if pickerView==cityPicker{
        //            let selectedRow = cityPicker.selectedRow(inComponent: 0)
        //            if selectedRow>0{
        //                selectedCityID = self.cityList[row].id!
        //                self.cityBox.text = self.cityList[row].name
        //            }
        //            else {
        //                self.cityBox.text = ""
        //            }
        //        }
        
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
