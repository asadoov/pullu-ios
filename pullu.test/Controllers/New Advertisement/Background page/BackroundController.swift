//
//  BackroundController.swift
//  pullu.test
//
//  Created by Rufat on 3/13/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class BackroundController: UIViewController {
    var select:dbSelect = dbSelect()
     var backgroundImageList:Array<BackroundImageStruct> = []
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        select.getBackgroundImages(){
            
            (list)
            in
            self.backgroundImageList = list
            
            
        }

        // Do any additional setup after loading the view.
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
extension BackroundController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(catList.count)
        return catList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             let cell = categoryScroll.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryViewCell


        cell.object=catList[indexPath.row]
        cell.reloadData()
       // print(catList[indexPath.row].name)
      
        return cell
            
    
    }
    
    
    
}
