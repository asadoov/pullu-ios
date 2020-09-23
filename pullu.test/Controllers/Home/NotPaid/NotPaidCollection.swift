//
//  NotPaidCollection.swift
//  pullu
//
//  Created by Rufat on 9/10/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
private let reuseIdentifier = "notPaidCell"

class NotPaidCollection: UICollectionViewController {
    var loadingAlert = MBProgressHUD()
       var advertArray: [Advertisement] = [Advertisement]()
       let  select:DbSelect=DbSelect()
       var userToken:String?
       var requestToken:String?
       private let myRefreshControl = UIRefreshControl()
   
       var paginationEnabled=false
       var loading = false
       var advertID:Int?
       var currentPage = 1
       public var catID:Int = 0
       let defaults = UserDefaults.standard
       let spinner = UIActivityIndicatorView(style: .gray)
      
       var catList:Array<CategoryStruct> = []
       var catObject:CategoryStruct?
       let refreshButton = UIButton()
        let warningLabel = UILabel()
    
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet var notPaidCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationitem = UINavigationItem(title: "")    //creates a new item with no title
          navigationitem.titleView = categoryCollection //your collectionview here to display as a view instead of the title that is usually there
          self.navigationController?.navigationBar.items = [navigationitem] //adds the navigation item to the navigationbar
        
        
        DispatchQueue.main.async {
            self.addWarningLabel()
             self.warningLabel.text = "Heç bir elan tapılmadı..."
             
          
         }
         if catID>0{
             
            // categoryScroll.isHidden = true
             
         }
         notPaidCollection.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
         myRefreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
         notPaidCollection.addSubview(myRefreshControl)
         let defaults = UserDefaults.standard
         userToken = defaults.string(forKey: "userToken")
         requestToken = defaults.string(forKey: "requestToken")
        // refreshCat()
      
        
        addResultButtonView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
         // self.collectionView!.register(NotPaidHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "notPaidHeader")

        // Do any additional setup after loading the view.
        
    }
    
//    @IBAction func refreshCategoriesBtnClick(_ sender: Any) {
//           refreshCat()
//
//       }
    
    
     private func addResultButtonView() {
            

        self.refreshButton.backgroundColor = .orange
        self.refreshButton.setTitle("Yenilə", for: .normal)
        
        self.notPaidCollection.addSubview(self.refreshButton)

            // set position
        self.refreshButton.translatesAutoresizingMaskIntoConstraints = false
        self.refreshButton.centerXAnchor.constraint(equalTo: self.notPaidCollection.centerXAnchor).isActive = true
        self.refreshButton.centerYAnchor.constraint(equalTo: self.notPaidCollection.centerYAnchor).isActive = true
    //          resultButton.topAnchor.constraint(equalTo: notPaidTableView.safeAreaLayoutGuide.topAnchor).isActive = true
    //        resultButton.leftAnchor.constraint(equalTo: notPaidTableView.safeAreaLayoutGuide.leftAnchor).isActive = true
    //        resultButton.rightAnchor.constraint(equalTo: notPaidTableView.safeAreaLayoutGuide.rightAnchor).isActive = true
    //        resultButton.bottomAnchor.constraint(equalTo: notPaidTableView.safeAreaLayoutGuide.bottomAnchor).isActive = true
    //        resultButton.widthAnchor.constraint(equalTo: notPaidTableView.safeAreaLayoutGuide.widthAnchor).isActive = true
        self.refreshButton.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.refreshButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        self.refreshButton.heightAnchor.constraint(equalToConstant: 50).isActive = true // specify the height of the view
       DispatchQueue.main.async {
               self.refreshButton.layer.cornerRadius = self.refreshButton.frame.height.self / 2.0
              }
              self.refreshButton.clipsToBounds = true
            
        }
        @objc func buttonAction(sender: UIButton!) {
            refresh()
            refreshButton.isHidden = true
           //print("Button tapped")
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
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "notPaidHeader", for: indexPath) as! NotPaidHeader
//        header.reloadData()
//        return heade
//    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return advertArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        advertID=advertArray[indexPath.row].id!
              
              if advertArray[indexPath.row].aTypeId==2{
                  self.performSegue(withIdentifier: "photoReklamPage", sender: self)
                  
              }
              if advertArray[indexPath.row].aTypeId==1{
                  self.performSegue(withIdentifier: "textReklamPage", sender: self)
                  
              }
              if advertArray[indexPath.row].aTypeId==3{
                  self.performSegue(withIdentifier: "videoReklamPage", sender: self)
                  
              }
              
    }
   override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let lastItem = self.advertArray.count - 1
           if indexPath.row == lastItem {
               //print("IndexRow\(indexPath.row)")
               
               
               
               
               
               pagination(page: currentPage)
               //        if currentPage < totalPage {
               //            currentPage += 1
               //           //Get data from Server
               //        }
           }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = notPaidCollection.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)as! aCollectionViewCell
    
        // Configure the cell
        do{
            if loading == false  {
                // cell.imageView?.image = nil
                
                    do{
                        
                        if advertArray.count > 0{
                            Alamofire.request((advertArray[indexPath.row].thumbnail!)).responseImage { response in

                                 self.advertArray[indexPath.row].downloaded=true
                                if let catPicture = response.result.value {
                                     
                                  
                                    if indexPath.row <= self.advertArray.count {
                                        
                                        if catPicture.imageAsset != nil {
                                            
                                            self.advertArray[indexPath.row].photo=catPicture.pngData()!
                                            
                                            
                                        }
                                        else {
                                           
                                        }
                                        
                                      
                                        
                                        
                                        
                                        
                                        cell.object = self.advertArray[indexPath.row]
                                    }
                                    
                                   
                                }
          
                                
                                cell.object = self.advertArray[indexPath.row]
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
            
            
            
        }
        catch
        {
            print(indexPath.row)
        }
        return cell
    }
     @objc func refresh() {
            
            
            
            //  paginationEnabled = true
            loading = true
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            
            self.myRefreshControl.beginRefreshing()
            var typeCount=0
            
            select.GetAds(page: 1,searchQuery: ""){
                
                (obj) in
                UIApplication.shared.endIgnoringInteractionEvents()
                self.myRefreshControl.endRefreshing()
                self.loading = false
                switch obj.status {
                case 1:
                    
                    if obj.data.count>0{
                        self.warningLabel.isHidden = true
                        
                        self.advertArray.removeAll()
                        
                        for advert in obj.data {
                            
                            //if (advert.isPaid==type) {
                            let item = advert
                            
                            
                            
                            self.advertArray.append(item)
                            
                            
                            
                            
                            
                            DispatchQueue.main.async {
                                
                                
                                //                            if self.isPaidSegment.selectedSegmentIndex == 0{
                                //                                self.advertArray = self.isPaid
                                //                                typeCount=self.isPaid.count
                                //                            }else {
                                //                                self.advertArray = self.isNotPaid
                                //                                typeCount=self.isNotPaid.count
                                //                            }
                                //
                                
                                
                                //self.ReklamCount.text="Reklam sayı \(String(typeCount))"
                                //  self.loadingAlert!.hide(animated: true)
                                self.myRefreshControl.endRefreshing()
                                self.notPaidCollection.reloadData()
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                        if self.advertArray.count>9 {
                            self.paginationEnabled = true
                        }
                        
                        
                        
                        
                        
                        
                        //
                        
                        
                        
                    }
                    else  {
                        
                        self.warningLabel.isHidden = false
                        //                    // self.loadingAlert!.hide(animated: true)
                        //                    let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                        //                    warningAlert.mode = MBProgressHUDMode.text
                        //                    //            warningAlert.isSquare=true
                        //                    warningAlert.label.text = "Bildiriş"
                        //                    warningAlert.detailsLabel.text = "Heç bir pullu reklam taapılmadı"
                        //                    warningAlert.hide(animated: true,afterDelay: 3)
                        
                    }
                    break
                case 2:
                    let alert = UIAlertController(title: "Sessiyanız başa çatıb", message: "Zəhmət olmasa yenidən giriş edin", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "Giriş et", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                        let menu:MenuController = MenuController()
                        menu.updateRootVC(status: false)
                        self.defaults.set(nil, forKey: "userToken")
                        self.defaults.set(nil, forKey: "requestToken")
                        self.defaults.set(nil, forKey: "uData")
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    break
                default:
                    let alert = UIAlertController(title: "Xəta", message: "Zəhmət olmasa biraz sonra yenidən cəht edin", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                        //logout
                    }))
                    self.present(alert, animated: true, completion: nil)
                    break
                    
                    
                    
                }
                
                
            }
        }
        
        
        
        
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if(segue.identifier == "photoReklamPage"){
                if let navController = segue.destination as? UINavigationController {
                    
                    if let chidVC = navController.topViewController as? AboutAdvertController {
                        //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                        chidVC.advertID  = advertID
                        
                    }
                    
                }
                
                
            }
            if(segue.identifier == "textReklamPage"){
                
                if let navController = segue.destination as? UINavigationController {
                    
                    if let chidVC = navController.topViewController as? TextReklamController {
                        //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                        chidVC.advertID  = advertID
                        
                    }
                    
                }
                
                
            }
            if(segue.identifier == "videoReklamPage"){
                if let navController = segue.destination as? UINavigationController {
                    
                    if let chidVC = navController.topViewController as? VideoReklamController {
                        //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                        chidVC.advertID  = advertID
                        
                    }
                    
                }
                
                
            }
            
            if(segue.identifier == "aCatSegue"){
                
                if let navController = segue.destination as? UINavigationController {
                    
                    if let chidVC = navController.topViewController as? CategoryViewController {
                        //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                        chidVC.object  = catObject
                        
                    }
                    
                }
                
                
            }
            
            
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        
        override func viewWillAppear(_ animated: Bool) {
            userToken = defaults.string(forKey: "userToken")
            requestToken = defaults.string(forKey: "requestToken")
            if  (defaults.string(forKey: "aID") != nil) {
                refresh()
            }
            
            //            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            //            navigationController?.navigationBar.shadowImage = UIImage()
            //            navigationController?.navigationBar.isTranslucent = true
            //            navigationController?.view.backgroundColor = .clear
            //            super.viewWillAppear(animated)
        }
        
        
        /*
         override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
         
         // Configure the cell...
         
         return cell
         }
         */
        
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
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    
func pagination(page:Int){
     
     
     
     
     if paginationEnabled{
         //                loading = true
         //                       var loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
         //                        loadingAlert.mode = MBProgressHUDMode.indeterminate
         //                        loadingAlert.label.text="Gözləyin"
         //                        loadingAlert.detailsLabel.text = "Reklamları yeniləyirik..."
         spinner.startAnimating()
         spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: notPaidCollection.bounds.width, height: CGFloat(44))
         
//         self.notPaidCollection.tableFooterView = spinner
//         self.notPaidCollection.tableFooterView?.isHidden = false
         var typeCount=0
         
         select.GetAds(page: page,searchQuery: ""){
             
             (obj) in
             self.spinner.stopAnimating()
            // self.notPaidCollection.tableFooterView = nil
             switch obj.status {
             case 1:
                 if obj.data.count>0 {
                     //self.defaults.set(obj.requestToken, forKey: "requestToken")
                     for advert in obj.data {
                         
                         //if (advert.isPaid==type) {
                         let item = advert
                         
                         
                         
                         self.advertArray.append(item)
                         
                         
                         
                         
                         
                         DispatchQueue.main.async {
                             self.warningLabel.isHidden = true
                             
                             //                            if self.isPaidSegment.selectedSegmentIndex == 0{
                             //                                self.advertArray = self.isPaid
                             //                                typeCount=self.isPaid.count
                             //                            }else {
                             //                                self.advertArray = self.isNotPaid
                             //                                typeCount=self.isNotPaid.count
                             //                            }
                             //
                             
                             
                             //self.ReklamCount.text="Reklam sayı \(String(typeCount))"
                             self.notPaidCollection.reloadData()
                             
                             self.myRefreshControl.endRefreshing()
                             
                             
                             
                             //
                             
                         }
                         
                         
                         
                     }
                     
                     self.currentPage += 1
                 }
                 else   { DispatchQueue.main.async {
                     self.warningLabel.isHidden = false
                     }
                     
                     self.paginationEnabled = false
                 }
                 break
                 
             case 2:
                 let alert = UIAlertController(title: "Sessiyanız başa çatıb", message: "Zəhmət olmasa yenidən giriş edin", preferredStyle: UIAlertController.Style.alert)
                 
                 alert.addAction(UIAlertAction(title: "Giriş et", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                     self.defaults.set(nil, forKey: "userToken")
                     self.defaults.set(nil, forKey: "requestToken")
                     self.defaults.set(nil, forKey: "uData")
                     let menu:MenuController = MenuController()
                     menu.updateRootVC(status: false)
                 }))
                 self.present(alert, animated: true, completion: nil)
                 break
             default:
                 let alert = UIAlertController(title: "Xəta", message: "Zəhmət olmasa biraz sonra yenidən cəhd edin", preferredStyle: UIAlertController.Style.alert)
                 
                 alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                     //logout
                 }))
                 self.present(alert, animated: true, completion: nil)
                 break
                 
             }
             
             
             
             
             
             //loadingAlert.hide(animated: true)
             self.loading = false
         }
     }
     
 }
 private func addWarningLabel() {
        
        
        //self.notFoundLabel.backgroundColor = .orange
        // self.notFoundLabel.center = viewersTable.center
        
        self.notPaidCollection.addSubview(self.warningLabel)
        
        // set position
        self.warningLabel.translatesAutoresizingMaskIntoConstraints = false
        self.warningLabel.centerXAnchor.constraint(equalTo: self.notPaidCollection.centerXAnchor).isActive = true
        self.warningLabel.centerYAnchor.constraint(equalTo: self.notPaidCollection.centerYAnchor).isActive = true
          self.warningLabel.isHidden = true
        //       DispatchQueue.main.async {
        //              // self.notFoundLabel.layer.cornerRadius = self.notFoundLabel.frame.height.self / 2.0
        //        self.notFoundLabel.numberOfLines = 0
        //        self.notFoundLabel.lineBreakMode = .byWordWrapping
        //        self.notFoundLabel.adjustsFontSizeToFitWidth = true
        //              }
        //              self.notFoundLabel.clipsToBounds = true
        
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
