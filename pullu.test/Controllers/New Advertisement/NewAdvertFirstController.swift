//
//  NewAdvertisementController.swift
//  pullu.test
//
//  Created by Rufat on 2/19/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class NewAdvertFirstController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var newAdvertisement:NewAdvertisementStruct=NewAdvertisementStruct()
    var newAPreview:NewAPreviewStruct = NewAPreviewStruct()
    @IBOutlet weak var aTypePicker: UIPickerView!
    @IBOutlet weak var aCatPicker: UIPickerView!
    
    
    @IBOutlet weak var isPaidSwitch: UISegmentedControl!
    
    @IBOutlet weak var titleTxt: UITextField!
    
    
    
    var select:DbSelect=DbSelect()
    var catList:Array<CategoryStruct>=[]
    var typeList:Array<TypeStruct>=[]
    var isPaidFinished=true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let alert = UIAlertController(title: nil, message: "Yüklənir...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: false, completion: nil)
//        NotificationCenter.default.addObserver(forName: UITextField.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
//            self.view.frame.origin.y = -200
//        }
//        NotificationCenter.default.addObserver(forName: UITextField.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
//            self.view.frame.origin.y = 0.0
//        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        select.aType(){
            (list)
            in
            self.typeList=list
            self.typeList.remove(at: 2)
            DispatchQueue.main.async {
                self.aTypePicker.reloadAllComponents();
            }
        }
        select.aCategory(){
            (list)
            in
            self.catList=list
            DispatchQueue.main.async {
                self.aCatPicker.reloadAllComponents();
                self.dismiss(animated: true)
                
            }
        }
        
        //        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //              navigationController?.navigationBar.shadowImage = UIImage()
        //        navigationController?.navigationBar.isTranslucent = true
        
    }
    
    
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func isPaidChanged(_ sender: Any) {
        if isPaidSwitch.selectedSegmentIndex == 0{
            if isPaidFinished==true {
                isPaidFinished=false
                
                if typeList.count>2{
                    typeList.remove(at: 2)//удаление видео из листа
                    self.aTypePicker.reloadAllComponents()
                    isPaidFinished=true
                }
            }
            else
            {
                
                isPaidSwitch.selectedSegmentIndex=1
            }
        }else
        {
            if isPaidFinished==true {
                isPaidFinished=false
                select.aType(){
                    (list)
                    in
                    self.typeList=list
                    
                    DispatchQueue.main.async {
                        self.aTypePicker.reloadAllComponents();
                    }
                    self.isPaidFinished=true
                }
            }
            else
            {
                
                isPaidSwitch.selectedSegmentIndex=0
            }
        }
        
    }
    
    
    @IBAction func nextBtnClick(_ sender: Any) {
        
        if !titleTxt.text!.isEmpty{
            let typeID = typeList.filter{a in a.name==typeList[aTypePicker.selectedRow(inComponent: 0)].name}
            newAdvertisement.aTypeID=typeID[0].id!
            newAdvertisement.aMediaTypeID = typeID[0].id!
            newAPreview.aType = typeID[0].name!
            let catID = catList.filter{a in a.name==catList[aCatPicker.selectedRow(inComponent: 0)].name}
            newAdvertisement.aCategoryID=catID[0].id!
            newAPreview.aCategory = catID[0].name!
            newAdvertisement.aTitle=titleTxt.text
            newAPreview.aTitle = titleTxt.text
            
            
            if isPaidSwitch.selectedSegmentIndex==1{
                newAdvertisement.isPaid=1
                newAPreview.isPaid = 1
                performSegue(withIdentifier: "tariffPage", sender: true)
            }
            else {
                newAdvertisement.isPaid=0
                newAPreview.isPaid = 0
                performSegue(withIdentifier: "newASecond", sender: true)
                
            }
            //            let jsonEncoder = JSONEncoder()
            //                                   do {
            //            let jsonData = try jsonEncoder.encode(newAdverisement)
            //                                       let jsonString = String(data: jsonData, encoding: .utf8)
            //
            //                                    print(jsonString!)
            //            }
            //                                   catch{
            //
            //                             print("error")
            //            }
        }
        else
        {
            let alert = UIAlertController(title: "Bildiriş", message: "Zəhmət olmasa bütün boşluqlarıı doldurun!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int=1
        
        if pickerView == aCatPicker {
            countrows = self.catList.count
        }
        if pickerView == aTypePicker {
            countrows = self.typeList.count
        }
        return countrows
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == aCatPicker {
            
            return catList[row].name
        }
        if pickerView == aTypePicker {
            
            return typeList[row].name
        }
        return ""
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="tariffPage"{
            let displayVC = segue.destination as! TariffController
            displayVC.newAdvertisement = newAdvertisement
            displayVC.newAPreview = newAPreview
        }
        if segue.identifier=="newASecond"{
            
            let displayVC = segue.destination as! NewASecondController
            displayVC.newAdvertisement = newAdvertisement
            displayVC.newAPreview =  newAPreview
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
