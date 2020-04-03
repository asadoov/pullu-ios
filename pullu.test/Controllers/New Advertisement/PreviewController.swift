//
//  PreviewController.swift
//  pullu.test
//
//  Created by Rufat on 3/31/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import ImageSlideshow
class PreviewController: UIViewController {
    let defaults = UserDefaults.standard
    var newAdvertisement:NewAdvertisementStruct = NewAdvertisementStruct()
    var newAPreview:NewAPreviewStruct = NewAPreviewStruct()
    var insert:DbInsert = DbInsert()
    @IBOutlet weak var aImages: ImageSlideshow!
    @IBOutlet weak var aCategory: UILabel!
    @IBOutlet weak var aName: UILabel!
    @IBOutlet weak var aPrice: UILabel!
    @IBOutlet weak var aDescription: UILabel!
    @IBOutlet weak var aTariff: UILabel!
    @IBOutlet weak var aType: UILabel!
    @IBOutlet weak var aCountry: UILabel!
    @IBOutlet weak var aCity: UILabel!
    @IBOutlet weak var aGender: UILabel!
    @IBOutlet weak var aAgeRange: UILabel!
    @IBOutlet weak var aProfession: UILabel!
    var imageSource: [ImageSource] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AboutAdvertController.didTap))
        aImages.addGestureRecognizer(gestureRecognizer)
        
        aImages.pageIndicatorPosition = .init(horizontal: .center,vertical: .under)
        aImages.contentScaleMode=UIViewContentMode.scaleAspectFill
        let pageControl=UIPageControl()
        pageControl.currentPageIndicatorTintColor=UIColor.darkGray
        pageControl.pageIndicatorTintColor=UIColor.lightGray
        aImages.pageIndicator=pageControl
        
        //    print("""
        //        PROFESIYA - \(newAdvertisement.aProfessionID!)
        //
        //
        // """)
        //let previewImg = defaults.string(forKey: "previewImg")
        // aImage.image=UIImage(data: Data(newAPreview.mediaBase64![0].utf8))
        
        
        //aImage.image=UIImage(data:newAPreview.mediaBase64![0])
        for image in newAPreview.mediaBase64!{
            imageSource.append(ImageSource(image: UIImage(data: Data(base64Encoded: image)!)!))
            
        }
        self.aImages.setImageInputs(imageSource)
        aCategory.text = newAPreview.aCategory
        aName.text = newAPreview.aTitle
        aPrice.text = "Qiymət: \(newAPreview.aPrice!)"
        aDescription.text = newAPreview.aDescription
        aTariff.text = newAPreview.aTrf
        aType.text = newAPreview.aType
        aCountry.text = "Hədəf ölkə: \(newAPreview.aCountry!)"
        aCity.text = "Hədəf şəhər: \(newAPreview.aCity!)"
        switch newAPreview.aGender {
        case 0:
            aGender.text = "Hədəf şəhər: Hamısı"
        case 1:
            aGender.text = "Hədəf şəhər: Kişi"
            break
        case 2:
            aGender.text = "Hədəf şəhər: Qadın"
            break
            
        default:  break
            
        }
        aAgeRange.text = "Hədəf yaş aralığı: \(newAPreview.aAgeRange!)"
        aProfession.text = "Hədəf ixtisas: \(newAPreview.aProfession!)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func finishClicked(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Yüklənir...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(newAdvertisement)
            let jsonString = String(data: jsonData, encoding: .utf8)
            // self.defaults.set(jsonString, forKey: "uData")
            
          //  print("JSON String : " + jsonString!)
            
            insert.addAdvertisement(jsonBody: jsonString!)
            {
                (status)
                
                in
                self.dismiss(animated: true)
                if status.response == 0 {
                    
                    let alert = UIAlertController(title: "Uğurludur", message: "Bizi seçdiyiniz üçün təşəkkür edirik. Sizin reklamınız tısdiqləndikdən sonra yayımlanacaq. Daha sonra arxivim bölməsindən əlavə etdiyiniz reklamlarınıza baxa bilərsiniz.", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        _ = self.tabBarController?.selectedIndex = 0
                        _ = self.navigationController?.popToRootViewController(animated: true)
                        
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    
                    let alert = UIAlertController(title: "Xəta", message: "Zəhmət olmasa biraz sonra yenidən cəht edin.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
            
        }
        catch {
        }
    }
    
    @objc func didTap() {
        aImages.presentFullScreenController(from: self)
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
