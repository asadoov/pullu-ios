//
//  AdsHeader.swift
//  pullu
//
//  Created by Rufat Asadov on 9/20/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Alamofire
class AdsHeader: UICollectionReusableView {
    @IBOutlet weak var categoriesCollection: UICollectionView!
    
    @IBOutlet weak var categoryScroll: UICollectionView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var balanceLabel: UILabel!
      var catList:Array<CategoryStruct> = []
    var select = DbSelect()
//    private let label:UILabel = {
//        let label = UILabel()
//        label.text = "Balans:"
//        label.textAlignment = .natural
//        label.textColor = .black
//        return label
//    }()
//    private let filterButton:UIButton = {
//          let filterButton = UIButton()
//
//          return filterButton
//      }()
    
    public func configure(){
        categoryScroll.delegate = self
        categoryScroll.dataSource = self
        filterButton.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
        refreshCat()
       // addSubview(label)
//        addSubview(filterButton)
//        addSubview(balanceLabel)
    }
    @objc func didButtonClick(_ sender: UIButton) {
        // your code goes here
       // print("HELLO DON JUAN")
        
         let sQuery:[String: Bool] = ["clicked": true]
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filterClicked"), object: nil, userInfo: sQuery)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        label.frame = bounds
//    }
    func refreshCat(){
          
          select.ACategory(){
              (list)
              in
              self.catList=list
              var catIndex=0
              for item in self.catList{
                  
                  Alamofire.request(item.catImage!).responseImage { response in
                      if let catPicture = response.result.value {
                          //advert.photo=catPicture.pngData()
                          item.downloadedIco = catPicture.pngData()
                          
                          print("image downloaded: \(item.downloadedIco)")
                          
                          // self.catList[item.id!-1]=item
                          //self.catList[catIndex]=item
                          // self.dataArray.replaceSubrange( , with: item)
                          catIndex+=1
                          if catIndex == self.catList.count {
                              self.catList.sort { $0.id! < $1.id! }
                              
                              
                          }
                          if self.catList.count>0{
                              DispatchQueue.main.async {
                               //   self.refreshCatButton?.isHidden=true
                                  self.categoryScroll.reloadData()
                                 // self.refreshCatButton.isHidden=true
                              }
                          }
//                          else
//                          {
//                              self.refreshCatButton?.isHidden=false
//                          }
                      }
                      
                      
                      
                      
                  }
                  
              }
              //            self.catList.sort {
              //                $0.id! < $1.id!
              //            }
              
          }
      }
}
extension AdsHeader:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // print(catList.count)
        return catList.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = categoryScroll.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath) as! CategoryViewCell
//        cell.object = catList[indexPath.row]
//        // print(cell.object?.name)
//        catObject=cell.object
//        self.performSegue(withIdentifier: "aCatSegue", sender: self)
//        
//        cell.reloadData()
//    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryScroll.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath) as! CategoryViewCell
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.object=catList[indexPath.row]
        cell.reloadData()
        // print(catList[indexPath.row].name)
        
        return cell
        
        
    }
    
    
    
    
}

