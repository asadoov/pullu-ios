//
//  ChangePassViewController.swift
//  pullu.test
//
//  Created by Rufat on 5/25/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import MBProgressHUD

class ChangePassViewController: UIViewController {
 var loadingAlert:MBProgressHUD?
    @IBOutlet weak var oldPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var repeatNewPass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changePassButton(_ sender: Any) {
        
        if oldPass.text != "" &&  newPass.text != "" && repeatNewPass.text != ""{
            if newPass.text == repeatNewPass.text{
                loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                loadingAlert!.mode = MBProgressHUDMode.indeterminate
                loadingAlert!.label.text="Gözləyin"
                loadingAlert!.detailsLabel.text = "Reklamları yeniləyirik..."
                let defaults = UserDefaults.standard
                       var  mail  = defaults.string(forKey: "mail")
                       
                       var insert:DbInsert = DbInsert()
                insert.uPass(mail: mail!, pass: oldPass.text!, newPass:newPass.text! ){
                    
                    (status)
                    in
                    self.loadingAlert!.hide(animated: true)
                                  switch status.response{
                                  case 0:
                                    defaults.set(self.newPass.text, forKey: "pass")
                                      let alert = UIAlertController(title: "Uğurludur", message: "Sizin şifrəniz dəyişdirildi!", preferredStyle: UIAlertController.Style.alert)
                                      let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                          UIAlertAction in
                                          // _ = self.tabBarController?.selectedIndex = 0
                                       _ = self.navigationController?.popToRootViewController(animated: true)
                                      }
                                      alert.addAction(okAction)
                                      self.present(alert, animated: true, completion: nil)
                                    case 3:
                                    let alert = UIAlertController(title: "Diqqət", message: "Zəhmət olmasa köhnə şifrənin düzgünlüyündən əmin olun", preferredStyle: UIAlertController.Style.alert)
                                                                         alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                                                         self.present(alert, animated: true, completion: nil)
                                  default:
                                      let alert = UIAlertController(title: "Xəta", message: "Zəhmət olmasa biraz sonra yenidən cəht edin.", preferredStyle: UIAlertController.Style.alert)
                                      alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                      self.present(alert, animated: true, completion: nil)
                                      
                                  }
                }
                              
                          }
            else  {
                let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                            warningAlert.mode = MBProgressHUDMode.text
                //            warningAlert.isSquare=true
                            warningAlert.label.text = "Diqqət"
                            warningAlert.detailsLabel.text = "Yeni şifrə və yeni şifrənin təkrarı eyni deil"
                            warningAlert.hide(animated: true,afterDelay: 3)
                
                
            }
                
            }
       
        else
        {
             let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                        warningAlert.mode = MBProgressHUDMode.text
            //            warningAlert.isSquare=true
                        warningAlert.label.text = "Diqqət"
                        warningAlert.detailsLabel.text = "Zəhmət olmasa bütün boşluqların doldurulmasından və media seçildiyindən əmin olun"
                        warningAlert.hide(animated: true,afterDelay: 3)
                        
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
