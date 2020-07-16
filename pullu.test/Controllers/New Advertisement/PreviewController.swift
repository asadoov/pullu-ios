//
//  PreviewController.swift
//  pullu.test
//
//  Created by Rufat on 3/31/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import ImageSlideshow
import MBProgressHUD
import AVKit
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
    var player: AVPlayer!
    var loadingAlert:MBProgressHUD?
    var imageSource: [ImageSource] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch newAdvertisement.aTypeID {
        case 3:
            //let videoURL = URL(string: newAPreview.mediaBase64![0])
            self.player = AVPlayer(url: newAPreview.videoUrl!)
            //                vc.player = self.player/
            
            
          //  self.player = AVPlayer(url: videoURL!)
            
            let playerLayer = AVPlayerLayer(player:self.player )
            
            DispatchQueue.main.async {
                playerLayer.frame = self.aImages.bounds
                self.aImages.layer.addSublayer(playerLayer)
                //                          self.player?.play()
            }
                                         let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
                                           self.aImages.addGestureRecognizer(gesture)
            
        default:
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
        }
        
        aCategory.text = newAPreview.aCategory
        aName.text = newAPreview.aTitle
        aPrice.text = "\(newAPreview.aPrice ?? "")"
        aDescription.text = newAPreview.aDescription
        aTariff.text = newAPreview.aTrf
        aType.text = newAPreview.aType
        //        aCountry.text = "Hədəf ölkə: \(newAPreview.aCountry ?? "")"
        //        aCity.text = "Hədəf şəhər: \(newAPreview.aCity ?? "")"
        //        switch newAPreview.aGender {
        //        case 0:
        //            aGender.text = "Hədəf şəhər: Hamısı"
        //        case 1:
        //            aGender.text = "Hədəf şəhər: Kişi"
        //            break
        //        case 2:
        //            aGender.text = "Hədəf şəhər: Qadın"
        //            break
        //
        //        default:  break
        //
        //        }
        //        aAgeRange.text = "Hədəf yaş aralığı: \(newAPreview.aAgeRange ?? "")"
        //        aProfession.text = "Hədəf ixtisas: \(newAPreview.aProfession ?? "")"
        // Do any additional setup after loading the view.
    }
        @objc func tapped(_ sender: UITapGestureRecognizer) {
            //updateStatus()
            let vc = AVPlayerViewController()
            vc.player = player
    
            present(vc, animated: true) {
                vc.player?.play()
            }
        }
    
    @IBAction func finishClicked(_ sender: Any) {
        
        
        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert!.mode = MBProgressHUDMode.annularDeterminate
        
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(newAdvertisement)
            let jsonString = String(data: jsonData, encoding: .utf8)
            // self.defaults.set(jsonString, forKey: "uData")
            
            //  print("JSON String : " + jsonString!)
            
            //            insert.addAdvertisement(jsonBody: jsonString!)
            insert.addAdvertisement(newAdvertisement: newAdvertisement,progressView: loadingAlert!)
            {
                (status)
                
                in
                self.loadingAlert!.hide(animated: true)
                switch (status.response){
                    
                case 0:
                    let alert = UIAlertController(title: "Uğurludur", message: "Bizi seçdiyiniz üçün təşəkkür edirik. Sizin reklamınız təsdiqləndikdən sonra yayımlanacaq. Daha sonra arxivim bölməsindən əlavə etdiyiniz reklamlarınıza baxa bilərsiniz.", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        _ = self.tabBarController?.selectedIndex = 0
                        _ = self.navigationController?.popToRootViewController(animated: true)
                        
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                case 4:
                    let alert = UIAlertController(title: "Bildiriş", message: "Balansınızda kifayət qədər vəsait yoxdur, lütfən balansınızı 'Maliyyə' bölməsinə keçid edərək artırın", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                default:
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

extension PreviewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    
    
    
    
    
    
    
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let cell: ReklamCellTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ReklamCellTableViewCell)
    //        cell.object = advertArray[indexPath.row]
    //        advertID=cell.object?.id!
    //        //print(advertID!)
    //        if cell.object?.aTypeId==2{
    //            self.performSegue(withIdentifier: "photoReklamPage", sender: self)
    //
    //        }
    //        if cell.object?.aTypeId==1{
    //            self.performSegue(withIdentifier: "textReklamPage", sender: self)
    //
    //        }
    //        if cell.object?.aTypeId==3{
    //            self.performSegue(withIdentifier: "videoReklamPage", sender: self)
    //
    //        }
    //        //print(cell.object?.name)
    //        //cell.delegate = self
    //        cell.reloadData()
    //
    //    }
    
    
    
    // MARK: - Table view data source
    //    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    //        return 2
    //    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        var count = 0
    //        switch section {
    //        case 0:
    //            count = 3
    //        case 1:
    //            count = 6
    //        default:
    //            break
    //        }
    //        return count
    //    }
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        if section < headerTitles.count {
    //            return headerTitles[section]
    //        }
    //
    //        return nil
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell: StatisticsCell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! StatisticsCell)
        //        do{
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell?)!
        
        
        
        
        
        switch indexPath.row {
        case 0:
            
            cell.textLabel?.text = "Hədəf ölkə: \(newAPreview.aCountry ?? "")"
        case 1:
            cell.textLabel?.text = "Hədəf şəhər: \(newAPreview.aCity ?? "")"
            
        case 2:
            var genderTxt:String?
            switch newAPreview.aGender {
            case 0:
                genderTxt = "Hədəf cins: Hamısı"
            case 1:
                genderTxt = "Hədəf cins: Kişi"
                
            case 2:
                genderTxt = "Hədəf cins: Qadın"
                
                
            default:  break
                
            }
            cell.textLabel?.text = genderTxt
        case 3:
            cell.textLabel?.text =  "Hədəf yaş aralığı: \(newAPreview.aAgeRange ?? "")"
        case 4:
            cell.textLabel?.text = "Hədəf ixtisas: \(newAPreview.aProfession ?? "")"
        default: break
            
        }
        
        
        return cell
        
        
        
        
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    
    
    
}

