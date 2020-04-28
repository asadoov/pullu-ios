//
//  EditProfileViewController.swift
//  pullu.test
//
//  Created by Javidan Mirza on 4/28/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
 

    
    var defaults = UserDefaults.standard
    var select:dbSelect=dbSelect()
    var profilM: [ProfileModel] = [ProfileModel]()
    
    @IBOutlet weak var adLabel: UITextField!
    @IBOutlet weak var soyadLabel: UITextField!
    @IBOutlet weak var telefonLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var profButton: UIButton!
    @IBOutlet weak var cinsButton: UIButton!
    @IBOutlet weak var seherButton: UIButton!
    @IBOutlet weak var bdateLabel: UITextField!
    @IBOutlet weak var crdateLabel: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let pass = defaults.string(forKey: "pass")
               let mail = defaults.string(forKey: "mail")
               select.getProfileInfo(mail: mail, pass: pass) {
                   (list) in
          
                   DispatchQueue.main.async {
                    let dateFormatter = DateFormatter()
                       dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                       dateFormatter.timeZone = TimeZone.current
                       dateFormatter.locale = Locale.current
                       let dat = dateFormatter.date(from: list[0].bDate!)
                       let datc = dateFormatter.date(from: list[0].cDate!)
                       dateFormatter.dateFormat = "dd.MM.yyyy"
                    
                    self.adLabel.text = list[0].name
                    self.soyadLabel.text = list[0].surname
                    self.telefonLabel.text = list[0].phone
                    self.emailLabel.text = list[0].mail
                    
                    self.profButton.titleLabel?.text = list[0].profession
                    self.cinsButton.titleLabel?.text = list[0].gender
                    self.seherButton.titleLabel?.text = list[0].city
                    
                    self.bdateLabel.text = dateFormatter.string(from: dat!)
                    self.crdateLabel.text = dateFormatter.string(from: datc!)
                }
                
        // Do any additional setup after loading the view.
        }
    }
    
    @IBAction func genderButton(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 200,height: 300)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        let editRadiusAlert = UIAlertController(title: "Cinsiyyəti seçin", message: "", preferredStyle: UIAlertController.Style.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         3
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
