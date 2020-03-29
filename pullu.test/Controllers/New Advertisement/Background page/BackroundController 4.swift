//
//  BackroundController.swift
//  pullu.test
//
//  Created by Rufat on 3/13/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Alamofire
class BackroundController: UIViewController {
    var newAdverisement:NewAdvertisementStruct=NewAdvertisementStruct()
    @IBOutlet weak var backgroundsCollection: UICollectionView!
    
    var select:dbSelect = dbSelect()
    var backgroundImageList:Array<BackroundImageStruct> = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        select.getBackgroundImages(){
            
            (list)
            in
            self.backgroundImageList = list
            var imageIndex = 0
            for item in self.backgroundImageList{
                Alamofire.request(item.imgUrl!).responseImage { response in
                    if let picture = response.result.value {
                        //advert.photo=catPicture.pngData()
                        item.downloadedImg = picture.pngData()!
                        
                        print("image downloaded: \(item.downloadedImg)")
                        
                        
                    }
                    
                    self.backgroundImageList[imageIndex]=item
                    
                    // self.dataArray.replaceSubrange( , with: item)
                    imageIndex+=1
                    
                    //print("\(self.dataArray.count) \n list count: \(typeCount)")
                    
                    
                    
                    
                    
                    
                    
                    DispatchQueue.main.async {
                        
                        
                        self.backgroundsCollection.reloadData()
                        
                        
                    }
                    
                    // DispatchQueue.main.async {
                    
                    
                    //   self.ReklamList.reloadData()
                    
                    
                    // }
                    
                }
            }
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="backToPublish"{
                   let displayVC = segue.destination as! NewASecondController
                                        displayVC.newAdverisement = newAdverisement
                   
               }
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     
    
}
extension BackroundController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(catList.count)
        return backgroundImageList.count
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = backgroundsCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BackgroundCell
        
        
        cell.backgroundImage=backgroundImageList[indexPath.row]
        cell.reloadData()
        // print(catList[indexPath.row].name)
        
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        newAdverisement.mediaBase64?.removeAll()
      let cell = backgroundsCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BackgroundCell
        cell.backgroundImage =  backgroundImageList[indexPath.row]
                // cell.object = tariffList[indexPath.row]
          //newAdverisement.trfID=cell.object!.id!
        newAdverisement.mediaBase64?.append(String(cell.backgroundImage!.id!))
      //  print(cell.backgroundImage!.id!)
                 cell.reloadData()
       
        self.performSegue(withIdentifier: "backToPublish", sender: true)
    }
    
    
}
