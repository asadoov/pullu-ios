//
//  OperatorsController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 7/23/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class OperatorsController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
  
    var azercell = ["050","051"]
    var bakcell = ["055","099"]
    var nar = ["070"]
    var picker = UIPickerView()
    
    @IBOutlet weak var mobileNum: UITextField!
     @IBOutlet weak var mobilePrefix: UITextField!
    
    @IBOutlet weak var moneyBox: UITextField!
    
    @IBOutlet weak var coinBox: UITextField!
    var serviceName:String?
    var serviceID:Int?
    
    var moneyCount:Double?
    var mobileNumWithPrefix:Int64?
    var earningValue:Double?
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        switch serviceID {
        case 6:
            count = azercell.count
        case 7:
            count = bakcell.count
        case 8:
            count = nar.count
        default:
            break
        }
        return count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var rowString = ""
        switch serviceID {
        case 6:
            rowString = azercell[row]
        case 7:
            rowString = bakcell[row]
        case 8:
            rowString = nar[row]
        default:
            break
        }
        
        return rowString
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var prefix = ""
        switch serviceID {
               case 6:
                   prefix = azercell[row]
               case 7:
                   prefix = bakcell[row]
               case 8:
                   prefix = nar[row]
               default:
                   break
               }
        mobilePrefix.text = prefix
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        picker.delegate = self
        picker.dataSource = self
        mobilePrefix.inputView = picker
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
         view.addGestureRecognizer(tap)
        switch serviceID {
               case 6:
                mobilePrefix.text = "050"
               case 7:
                    mobilePrefix.text = "055"
               case 8:
                   mobilePrefix.text = "070"
               default:
                   break
               }
        title = serviceName
        
    }
    @objc func dismissKeyboard() {
           //Causes the view (or one of its embedded text fields) to resign the first responder status.
           view.endEditing(true)
       }
    
    @IBAction func mobileTextChanged(_ sender: Any) {
   if mobileNum.text!.count>7 {
              mobileNum.text!.removeLast()
              
          }
    }
    
    @IBAction func moneyTextChanged(_ sender: Any) {
        if moneyBox.text!.count>3 {
            moneyBox.text!.removeLast()
            
        }
    }
    
    @IBAction func coinTextChanged(_ sender: Any) {
   if coinBox.text!.count>2 {
       coinBox.text!.removeLast()
       
   }
    }
    
    @IBAction func nextPageClick(_ sender: Any) {
        
        if !mobilePrefix.text!.isEmpty && !mobileNum.text!.isEmpty && !moneyBox.text!.isEmpty{
            moneyCount = Double("\(moneyBox.text!).\(coinBox.text ?? "00")")
            mobileNumWithPrefix = Int64("\(mobilePrefix.text!)\(mobileNum.text!)")
            performSegue(withIdentifier: "withdrawFinishPageSegue", sender: self)}
        else {
            
            let alert = UIAlertController(title: "Bildiriş", message: "Zəhmət olmasa, bütün boşluqları doldurun", preferredStyle: UIAlertController.Style.alert)
                                                     alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                     self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "withdrawFinishPageSegue") {
        let displayVC = segue.destination as! WithdrawFinishController
            displayVC.serviceName = serviceName
            displayVC.serviceID = serviceID
            displayVC.mobilePrefix = mobilePrefix.text
            displayVC.mobileNum = mobileNum.text
            displayVC.earningValue = earningValue
            displayVC.moneyCount = moneyCount
            displayVC.mobileNumWithPrefix = mobileNumWithPrefix
        //displayVC.id =
        }
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     
    
}
