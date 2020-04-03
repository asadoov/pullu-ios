//
//  NewASecondController.swift
//  pullu.test
//
//  Created by Rufat on 2/20/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import OpalImagePicker
import Photos

class NewASecondController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate{
    
    
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
        
     
        
        descriptionField.delegate = self
        descriptionField.layer.borderWidth = 1.0
        descriptionField.text = "Ətraflı məlumat"
        descriptionField.layer.borderColor = UIColor.gray.cgColor
        
        
        self.defaults.set(nil, forKey: "backgroundUrl")
        self.defaults.set(nil, forKey: "previewImg")
        if newAdvertisement.isPaid==1{
            print(newAdvertisement.aTrfID!)
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        
        textView.layer.borderColor = UIColor.red.cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // textView.layer.borderColor = UIColor.clear.cgColor
        if textView.text == ""{
            
            textView.text = "Ətraflı məlumat"
        }
        textView.layer.borderColor = UIColor.gray.cgColor
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let backgroundUrl = defaults.string(forKey: "backgroundUrl")
        let previewImg = defaults.data(forKey: "previewImg")
        if (backgroundUrl != nil && previewImg != nil)
        {
            
            newAdvertisement.mediaBase64 = Array<String>()
            newAdvertisement.mediaBase64!.append(backgroundUrl!)
            
            newAPreview.mediaBase64 = Array<String>()
            newAPreview.mediaBase64!.append(previewImg!.base64EncodedString())
            
            chooseMediaBtn.setTitle("Fonu dəyiş", for: .normal)
            
        }
        else    {
            chooseMediaBtn.setTitle("Media seçimi", for: .normal)
            
            
        }
        //            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //            navigationController?.navigationBar.shadowImage = UIImage()
        //            navigationController?.navigationBar.isTranslucent = true
        //            navigationController?.view.backgroundColor = .clear
        //            super.viewWillAppear(animated)
    }
    
    
    @IBAction func nextBtn(_ sender: Any) {
        if ((price.text != "" || newAdvertisement.aPrice != "") && descriptionField.text != "" && descriptionField.text != "Ətraflı məlumat" && newAdvertisement.mediaBase64 != nil ){
            
            
            newAdvertisement.aDescription = descriptionField.text
            newAPreview.aDescription = descriptionField.text
            if price.text != "" {
                newAdvertisement.aPrice = price.text
                newAPreview.aPrice = "\(price.text!)"
            }
            
            
            
            
            performSegue(withIdentifier: "auditorySegue", sender: true)
        }
        
        
        
    }
    
    @IBAction func selectMedia(_ sender: Any) {
        if newAdvertisement.mediaBase64 !=  nil {
            newAdvertisement.mediaBase64!.removeAll()
            newAPreview.mediaBase64!.removeAll()
        }
        let imagePicker = OpalImagePickerController()
        if newAdvertisement.aTypeID == 1 {
            performSegue(withIdentifier: "backgroundsSegue", sender: true)
        }
        if newAdvertisement.aTypeID == 2{
            self.newAdvertisement.mediaBase64 = Array<String>()
            self.newAPreview.mediaBase64 = Array<String>()
            
            let configuration = OpalImagePickerConfiguration()
            configuration.maximumSelectionsAllowedMessage = NSLocalizedString("Maximum şəkil sayı 10 olmaıdır", comment: "")
            imagePicker.configuration = configuration
            imagePicker.allowedMediaTypes = Set([.image])
            imagePicker.maximumSelectionsAllowed=10
            presentOpalImagePickerController(imagePicker, animated: true,
                                             select: { (assets) in
                                                
                                                
                                                for img in assets {
                                                    
                                                    
                                                    var originalImage = 1
                                                    PHImageManager.default().requestImage(
                                                        for: img,
                                                        targetSize: .init(),
                                                        contentMode: .aspectFit,
                                                        options: nil) { (image, _) in
                                                            // result = image
                                                            if originalImage%2 == 0 {
                                                                
                                                                self.newAdvertisement.mediaBase64?.append((image?.pngData()?.base64EncodedString())!)
                                                                
                                                                self.newAPreview.mediaBase64?.append((image?.pngData()?.base64EncodedString())!)
                                                                //                                                    let strBase64 =  image?.pngData()!.base64EncodedString()
                                                                //                                                    print(strBase64!)
                                                                
                                                            }
                                                            originalImage += 1
                                                    }
                                                }
                                                
                                                self.dismiss(animated: true)
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
        
        //print(newAdvertisement.mediaBase64!)
        price.text = ""
        if noPriceSwitch.isOn
        {
            
            price.isEnabled=false
            price.placeholder = "Razılaşma yolu ilə"
            newAdvertisement.aPrice = price.placeholder
            newAPreview.aPrice = price.placeholder
            //price.text = "Razılaşma yolu ilə"
            
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
