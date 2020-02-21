//
//  NewAdvertisementController.swift
//  pullu.test
//
//  Created by Rufat on 2/19/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class NewAdvertFirstController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var newAdverisement:NewAdvertisementStruct?
    
    @IBOutlet weak var aTypePicker: UIPickerView!
    @IBOutlet weak var aCatPicker: UIPickerView!
    
    
    @IBOutlet weak var isPaidSwitch: UISegmentedControl!
    
    @IBOutlet weak var titleTxt: UITextField!
    
    
    @IBOutlet weak var nextBtn: UIButton!
    var select:dbSelect=dbSelect()
    var catList:Array<CategoryStruct>=[]
    var typeList:Array<TypeStruct>=[]
    var isPaidFinished=true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(forName: UITextField.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = -200
        }
        NotificationCenter.default.addObserver(forName: UITextField.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = 0.0
        }
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
            }
        }
   
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
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
        var index = typeList.filter{a in a.name==typeList[aTypePicker.selectedRow(inComponent: 0)].name}
       newAdverisement?.aTypeID=index[0].id!
        index = typeList.filter{a in a.name==typeList[aTypePicker.selectedRow(inComponent: 0)].name}
        newAdverisement?.aCategoryID
      //  print(index[0].id!)
      
       
//        if !titleTxt.text!.isEmpty{
//
//
//
//            if isPaidSwitch.selectedSegmentIndex==1{
//
//                performSegue(withIdentifier: "tariffPage", sender: true)
//            }
//            else {
//                performSegue(withIdentifier: "newASecond", sender: true)
//
//            }
//        }
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
