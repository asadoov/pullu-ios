//
//  SearchController.swift
//  pullu
//
//  Created by Rufat on 9/9/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SearchController: UICollectionViewController {
    @IBOutlet var searchCollection: UICollectionView!
    var announcementList = Array<Advertisement>()
     var select = DbSelect()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let width = (view.frame.width-20)/3
              let layout = searchCollection.collectionViewLayout as! UICollectionViewFlowLayout
              layout.itemSize = CGSize(width: width, height: width)
        // Do any additional setup after loading the view.
        select.SearchAds()
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


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return announcementList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath)as! SearchCell
        
        if !announcementList.isEmpty{
            cell.aPriceLabel.text = announcementList[indexPath.row].price ?? ""
            cell.aDescriptionLabel.text = announcementList[indexPath.row].description ?? ""
          //  cell.aImageLabel
        }
        // Configure the cell
      
        cell.layer.cornerRadius = cell.frame.height.self / 7.0
        cell.aCategoryLabel.layer.cornerRadius = cell.aCategoryLabel.frame.height.self / 2.0
        return cell
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
