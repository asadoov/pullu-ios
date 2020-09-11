//
//  notPaidHeader.swift
//  pullu
//
//  Created by Rufat on 9/10/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//
//
//import UIKit
//import Alamofire
//class NotPaidHeader: UICollectionReusableView,UICollectionViewDelegate,UICollectionViewDataSource {
//    
//    @IBOutlet weak var categoriesCollection: UICollectionView!
//    @IBOutlet weak var refreshCatButton: UIButton!
//    var catList = Array<CategoryStruct>()
//    var select = DbSelect()
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        catList.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//     let cell = categoriesCollection.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath) as! CategoryViewCell
//               
//               
//               cell.object=catList[indexPath.row]
//               cell.reloadData()
//               // print(catList[indexPath.row].name)
//               
//               return cell
//    }
//    var catHeader: Photo
//    
////    func reloadData(){
////        //self.refreshCatButton.layer.cornerRadius = self.refreshCatButton.frame.height.self / 2.0
////        refreshCat()
////    }
////    func refreshCat(){
////            
////         
////          }
//}
