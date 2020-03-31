//
//  NewASecondController.swift
//  pullu.test
//
//  Created by Rufat on 2/20/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import OpalImagePicker

class NewASecondController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    let defaults = UserDefaults.standard
    @IBOutlet weak var noPriceSwitch: UISwitch!
    var newAdvertisement:NewAdvertisementStruct=NewAdvertisementStruct()
    var newAPreview:NewAPreviewStruct = NewAPreviewStruct()
    let mediaPicker=UIImagePickerController()
    
    @IBOutlet weak var chooseMediaBtn: UIButton!
    
    
    
    @IBOutlet weak var descriptionField: UITextView!
    
    
    @IBOutlet weak var price: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaults.set(nil, forKey: "backgroundID")
        if newAdvertisement.isPaid==1{
            print(newAdvertisement.aTrfID!)
            
        }
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let backgroundID = defaults.string(forKey: "backgroundID")
        if backgroundID != nil
        {
            if newAdvertisement.mediaBase64 !=  nil {
                newAdvertisement.mediaBase64!.removeAll()
                
            }
            newAdvertisement.mediaBase64 = Array<String>()
            newAdvertisement.mediaBase64!.append(backgroundID!)
            chooseMediaBtn.setTitle("Fonu dəyiş", for: .normal)
            
        }
        //            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //            navigationController?.navigationBar.shadowImage = UIImage()
        //            navigationController?.navigationBar.isTranslucent = true
        //            navigationController?.view.backgroundColor = .clear
        //            super.viewWillAppear(animated)
    }
    
    
    @IBAction func nextBtn(_ sender: Any) {
        if price.text != "" && descriptionField.text != "" && newAdvertisement.mediaBase64 != nil {
            
            
            newAdvertisement.aDescription = descriptionField.text
            newAPreview.aDescription = descriptionField.text
            newAdvertisement.aPrice = price.text
            newAPreview.aPrice = "\(price.text!)"
            
            
            performSegue(withIdentifier: "auditorySegue", sender: true)
        }
        
        
        
    }
    
    @IBAction func selectMedia(_ sender: Any) {
        let imagePicker = OpalImagePickerController()
        if newAdvertisement.aTypeID == 1 {
            performSegue(withIdentifier: "backgroundsSegue", sender: true)
        }
        if newAdvertisement.aTypeID == 2{
            let configuration = OpalImagePickerConfiguration()
            configuration.maximumSelectionsAllowedMessage = NSLocalizedString("Maximum şəkil sayı 10 olmaıdır", comment: "")
            imagePicker.configuration = configuration
            imagePicker.maximumSelectionsAllowed=10
            presentOpalImagePickerController(imagePicker, animated: true,
                                             select: { (assets) in
                                                //Select Assets
                                                
            }, cancel: {
                //Cancel
            })
        }
        if newAdvertisement.aTypeID == 3 {
            let configuration = OpalImagePickerConfiguration()
            configuration.maximumSelectionsAllowedMessage = NSLocalizedString("Siz sadəcə 1 vide seçə bilərsiniz", comment: "")
            imagePicker.configuration = configuration
            imagePicker.maximumSelectionsAllowed=1
            imagePicker.allowedMediaTypes = Set([.video])
            presentOpalImagePickerController(imagePicker, animated: true,
                                             select: { (assets) in
                                                //Select Assets
                                                
            }, cancel: {
                //Cancel
            })
            //        mediaPicker.delegate=self
            //              mediaPicker.sourceType=UIImagePickerController.SourceType.photoLibrary
            //             // mediaPicker.mediaTypes = ["public.image", "public.movie"]
            //                       mediaPicker.mediaTypes = ["public.movie"]
            //
            //              self.present(mediaPicker,animated: true,completion: nil)
        }
    }
    
    @IBAction func noPriceSwitchChanged(_ sender: Any) {
        
        print(newAdvertisement.mediaBase64!)
        
        if noPriceSwitch.isOn
        {
            
            price.isEnabled=false
            price.placeholder = "Razılaşma yolu ilə"
            price.text = ""
            
        }
        else
        {
            price.isEnabled=true
            price.placeholder = "AZN"
            newAdvertisement.aPrice = ""
            
        }
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="auditorySegue"{
            
            let displayVC = segue.destination as! AuditoryController
            displayVC.newAdvertisement = newAdvertisement
            displayVC.newAPreview = newAPreview
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
