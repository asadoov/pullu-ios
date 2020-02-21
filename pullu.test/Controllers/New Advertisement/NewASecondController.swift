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

  let mediaPicker=UIImagePickerController()
   
    @IBOutlet weak var descriptionTxt: UITextView!
    
    
    @IBOutlet weak var price: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtn(_ sender: Any) {
  
      
//        if (descriptionTxt.text != "" && price.text != "")
//        {
//
//
//        }
    }
    
    @IBAction func selectMedia(_ sender: Any) {
        let imagePicker = OpalImagePickerController()
        presentOpalImagePickerController(imagePicker, animated: true,
            select: { (assets) in
                //Select Assets
            }, cancel: {
                //Cancel
            })
//        mediaPicker.delegate=self
//              mediaPicker.sourceType=UIImagePickerController.SourceType.photoLibrary
//              mediaPicker.mediaTypes = ["public.image", "public.movie"]
//        mediaPicker.
//              self.present(mediaPicker,animated: true,completion: nil)
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
