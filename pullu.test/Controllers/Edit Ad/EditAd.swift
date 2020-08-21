//
//  EditAd.swift
//  pullu.test
//
//  Created by Rufat Asadov on 5/22/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import MBProgressHUD
class EditAd: UIViewController, UITextViewDelegate {
    var ad: Advertisement = Advertisement()
    var insert:DbInsert=DbInsert()
    @IBOutlet weak var aPriceBox: UITextField!
    @IBOutlet weak var aNameBox: UITextField!
    
    @IBOutlet weak var aDescriptionBox: UITextView!
    var mail:String?
    var pass:String?
    var loadingAlert:MBProgressHUD?
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        aDescriptionBox.delegate = self
        aDescriptionBox.layer.borderWidth = 1.0
        aDescriptionBox.text = "Ətraflı məlumat"
        aDescriptionBox.layer.borderColor = UIColor.gray.cgColor
        
        
        aPriceBox.text = ad.price
        aNameBox.text = ad.name
        aDescriptionBox.text = ad.description
        mail = defaults.string(forKey: "mail")
        pass = defaults.string(forKey: "pass")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
              
              //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
              //tap.cancelsTouchesInView = false
              
              view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
           //Causes the view (or one of its embedded text fields) to resign the first responder status.
           view.endEditing(true)
       }
       
       func textViewDidBeginEditing(_ textView: UITextView) {
           if textView.text == "Ətraflı məlumat"
           {textView.text = ""}
           
           textView.layer.borderColor = UIColor.red.cgColor
       }
       
       func textViewDidEndEditing(_ textView: UITextView) {
           // textView.layer.borderColor = UIColor.clear.cgColor
           if textView.text == ""{
               
               textView.text = "Ətraflı məlumat"
           }
           textView.layer.borderColor = UIColor.gray.cgColor
       }
       
    
    @IBAction func saveData(_ sender: Any) {
        if(aPriceBox.text != ad.price || aNameBox.text != ad.name || aDescriptionBox.text != ad.description){
            
            loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
            loadingAlert!.mode = MBProgressHUDMode.indeterminate
          
            
            insert.UpdateAd(userToken: mail!, requestToken: pass!, aID: ad.id!, aName: aNameBox.text!, aDescription: aDescriptionBox.text!, aPrice: Int(aPriceBox.text!)!){
                
                (status)
                in
                self.loadingAlert!.hide(animated: true)
                switch status.response{
                case 0:
                    let alert = UIAlertController(title: "Uğurludur", message: "Sizin reklamınız təsdiqləndikdən sonra yayımlanacaq. Daha sonra arxivim bölməsindən əlavə etdiyiniz reklamlarınıza baxa bilərsiniz.", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        // _ = self.tabBarController?.selectedIndex = 0
                        _ = self.navigationController?.popToRootViewController(animated: true)
                        
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                default:
                    let alert = UIAlertController(title: "Xəta", message: "Zəhmət olmasa biraz sonra yenidən cəht edin.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                
                
            }
            
        }
        
    }
    
    @IBAction func deleteAd(_ sender: Any) {
        let alert = UIAlertController(title: "Bildiriş", message: "Reklamı silmək istədiyinizdən əminsinizmi?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Bəli", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in
            
            
            
            self.loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
            self.loadingAlert!.mode = MBProgressHUDMode.indeterminate
            
            self.loadingAlert?.show(animated: true)
            
            self.insert.DeleteAd(userToken: self.mail!, requestToken: self.pass!, aID: self.ad.id!){
                
                (status)
                in
                self.loadingAlert!.hide(animated: true)
                self.loadingAlert!.hide(animated: true)
                switch status.response{
                case 0:
                    let deletedAlert = UIAlertController(title: "Uğurludur", message: "Sizin reklamınız silindi.", preferredStyle: UIAlertController.Style.alert)
                    deletedAlert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in
                        _ = self.navigationController?.popToRootViewController(animated: true)
                        
                    }))
                    
                    
                    self.present(deletedAlert, animated: true, completion: nil)
                default:
                    let alert = UIAlertController(title: "Xəta", message: "Zəhmət olmasa biraz sonra yenidən cəht edin.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                
                
            }
        }))
        
        let cancelAction = UIAlertAction(title: "Xeyr", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            
            
            
        }
        alert.addAction(cancelAction)
        
        
        self.present(alert, animated: true, completion: nil)
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
