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
import MBProgressHUD
class NewASecondController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate{
    
    
    let defaults = UserDefaults.standard
    @IBOutlet weak var noPriceSwitch: UISwitch!
    var newAdvertisement:NewAdvertisementStruct=NewAdvertisementStruct()
    var newAPreview:NewAPreviewStruct = NewAPreviewStruct()
    let mediaPicker=UIImagePickerController()
    
    @IBOutlet weak var chooseMediaBtn: UIButton!
    
    
    
    @IBOutlet weak var descriptionField: UITextView!
    
    
    @IBOutlet weak var price: UITextField!
    
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    var loadingView: UIView = UIView()
    var filesAsset:[PHAsset] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //descriptionField.delegate = self
        descriptionField.layer.borderWidth = 1.0
        descriptionField.text = "Ətraflı məlumat"
        descriptionField.layer.borderColor = UIColor.gray.cgColor
        
        
        self.defaults.set(nil, forKey: "backgroundUrl")
        self.defaults.set(nil, forKey: "previewImg")
        if newAdvertisement.isPaid==1{
            print(newAdvertisement.aTrfID!)
            
        }
        
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        let backgroundUrl = defaults.string(forKey: "backgroundUrl")
        let previewImg = defaults.data(forKey: "previewImg")
        if (backgroundUrl != nil && previewImg != nil)
        {
            
            //   newAdvertisement.files = Array<Data>()
            newAdvertisement.aBackgroundUrl = backgroundUrl!
            
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
        if ((price.text != "" || newAdvertisement.aPrice != "") && descriptionField.text != "" && descriptionField.text != "Ətraflı məlumat" && (filesAsset.count > 0 || newAdvertisement.aBackgroundUrl != nil) ){
            
            
            
            newAdvertisement.aDescription = descriptionField.text
            newAPreview.aDescription = descriptionField.text
            if price.text != "" {
                newAdvertisement.aPrice = price.text
                newAPreview.aPrice = "\(price.text!) AZN"
            }
            
            
            
            if filesAsset.count > 0 {
                self.fileChooser(assets: filesAsset)
                {
                    (completed)
                    in
                    if completed == true
                    {
                        
                        self.hideActivityIndicator()
                        // self.dismiss(animated: true)
                        
                        self.performSegue(withIdentifier: "auditorySegue", sender: true)
                    }
                }
                
            }
            else
            {
                self.performSegue(withIdentifier: "auditorySegue", sender: true)
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
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor.black
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
            self.spinner = UIActivityIndicatorView(style: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            
            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    func fileChooser(assets:[PHAsset],completionBlock: @escaping (_ result:Bool) ->()){
        showActivityIndicator()
        self.newAdvertisement.files = Array<Data>()
        self.newAPreview.mediaBase64 = Array<String>()
        var a = 1
        for img in assets {
            
            
            
            var originalImage = 1
            PHImageManager.default().requestImage(
                for: img,
                targetSize: .init(),
                contentMode: .aspectFit,
                options: nil) { (image, _) in
                    // result = image
                    if originalImage%2 == 0 {
                        
                        self.newAdvertisement.files?.append((image?.jpeg(.lowest))!)
                        
                        self.newAPreview.mediaBase64?.append((image?.jpeg(.lowest)!.base64EncodedString())!)
                        //                                                    let strBase64 =  image?.pngData()!.base64EncodedString()
                        //                                                    print(strBase64!)
                        
                    }
                    
                    originalImage += 1
            }
            
            
            if a == assets.count
            {
                completionBlock(true)
                
            }
            a+=1
            
            
            
        }
        
        
        
    }
    
    @IBAction func selectMedia(_ sender: Any) {
        if newAdvertisement.files !=  nil {
            newAdvertisement.files!.removeAll()
            newAPreview.mediaBase64!.removeAll()
        }
        let imagePicker = OpalImagePickerController()
        if newAdvertisement.aTypeID == 1 {
            performSegue(withIdentifier: "backgroundsSegue", sender: true)
        }
        if newAdvertisement.aTypeID == 2{
            
            
            let configuration = OpalImagePickerConfiguration()
            configuration.maximumSelectionsAllowedMessage = NSLocalizedString("Maximum şəkil sayı 10 olmaıdır", comment: "")
            imagePicker.configuration = configuration
            imagePicker.allowedMediaTypes = Set([.image])
            imagePicker.maximumSelectionsAllowed=10
            presentOpalImagePickerController(imagePicker, animated: true,
                                             select: { (assets) in
                                                
                                                
                                                self.filesAsset = assets
                                                self.dismiss(animated:true)
                                                
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
             newAPreview.aPrice = ""
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
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
