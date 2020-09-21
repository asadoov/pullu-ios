//
//  SearchController.swift
//  pullu
//
//  Created by Rufat on 9/9/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Alamofire
private let reuseIdentifier = "Cell"

class AdsController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    @IBOutlet var searchCollection: UICollectionView!
    var announcementList = Array<Advertisement>()
     var select = DbSelect()
    
    private let spacing:CGFloat = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(AdsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "adsHeader")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
            /*self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let width = (view.frame.width-20)/3
              let layout = searchCollection.collectionViewLayout as! UICollectionViewFlowLayout
              layout.itemSize = CGSize(width: width, height: width)*/
        let layout = UICollectionViewFlowLayout()
               layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
               layout.minimumLineSpacing = spacing
               layout.minimumInteritemSpacing = spacing
               self.collectionView?.collectionViewLayout = layout
        // Do any additional setup after loading the view.
//        select.SearchAds()
//            {
//                (list)
//                in
//                if list.status == 1{
//                    self.announcementList = list.data
//                    self.searchCollection.reloadData()
//                }
//
//        }
        select.GetAds(isPaid: 3, page: 1, catID: 0)
        {
            
            (list)
            in
             if list.status == 1{
                                self.announcementList = list.data
                                self.searchCollection.reloadData()
                            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "adsHeader", for: indexPath) as! AdsHeader
      
      //  header.balanceLabel = "Hello"
        
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width,height: 200)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return announcementList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath)as! AdCell
        cell.object = announcementList[indexPath.row]
        cell.reloadData()
        if   cell.aImage?.image == nil{
                    do{
                        
                        if announcementList.count > 0{
                            Alamofire.request((announcementList[indexPath.row].thumbnail!)).responseImage { response in
                                
                                self.announcementList[indexPath.row].downloaded=true
                                if let catPicture = response.result.value {
                                    
                                    
                                    if indexPath.row <= self.announcementList.count {
                                        
                                        if catPicture.imageAsset != nil {
                                            
                                            self.announcementList[indexPath.row].photo=catPicture.pngData()!
                                            
                                            
                                        }
                                        else {
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                        
                                        cell.object = self.announcementList[indexPath.row]
                                    }
                                    
                                    
                                }
                                
                                
                                cell.object = self.announcementList[indexPath.row]
                                cell.reloadData()
                            }
                            
                            
                            
                            
                        }
                        
                        
                        
                    }
                    catch
                    {
                        print(indexPath.row)
                    }
                    
                    //cell.delegate = self
                    // cell.reloadData()
                    //cell.object = dataArray[indexPath.row]
                    //     cell.delegate = self
                    
                    
                    // Configure the cell...
                }
            
       // cell.reloadData()
//        if !announcementList.isEmpty{
//            cell.aPriceLabel.text = "\( announcementList[indexPath.row].price ?? "") AZN"
//            cell.aTitle.text = announcementList[indexPath.row].name ?? ""
//          //  cell.aImageLabel
//        }
        // Configure the cell
      
       // cell.layer.cornerRadius = cell.frame.height.self / 28.0
      //  cell.aCategoryLabel.layer.cornerRadius = cell.aCategoryLabel.frame.height.self / 2.0
//        aImage?.layer.borderWidth = 1
//                   aImage?.layer.borderColor = UIColor.gray.cgColor
                   
        cell.cellView?.layer.borderWidth = 1
        cell.cellView?.layer.borderColor = UIColor.gray.cgColor
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 16
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: 248)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
