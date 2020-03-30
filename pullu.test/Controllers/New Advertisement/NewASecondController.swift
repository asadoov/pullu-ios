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
 var newAdverisement:NewAdvertisementStruct=NewAdvertisementStruct()
  let mediaPicker=UIImagePickerController()
  
    @IBOutlet weak var descriptionTxt: UITextView!
    
    
    @IBOutlet weak var price: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if newAdverisement.isPaid==1{
            print(newAdverisement.trfID!)
            
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtn(_ sender: Any) {
  performSegue(withIdentifier: "auditorySegue", sender: true)
      
//        if (descriptionTxt.text != "" && price.text != "")
//        {
//
//
//        }
    }
    
    @IBAction func selectMedia(_ sender: Any) {
      let imagePicker = OpalImagePickerController()
        if newAdverisement.aTypeID == 1 {
            
            performSegue(withIdentifier: "chooseBackground", sender: true)
        }
        if newAdverisement.aTypeID == 2{
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
        if newAdverisement.aTypeID == 3 {
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="chooseBackground"{
                         let displayVC = segue.destination as! BackroundController
                                              displayVC.newAdverisement = newAdverisement
                         
                     }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
