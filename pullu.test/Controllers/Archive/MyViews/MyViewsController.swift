//
//  MyViewsController.swift
//  pullu.test
//
//  Created by Rufat on 5/7/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class MyViewsController: UIViewController {
    var advertArray: [Advertisement] = [Advertisement]()
    var advertID:Int?
    var loadingAlert:MBProgressHUD?
    var  userToken:String?
    var  requestToken:String?
    var select:DbSelect=DbSelect()
  
    @IBOutlet weak var aTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        
        
        
        // let userData = defaults.string(forKey: "uData")
        userToken = defaults.string(forKey: "userToken")
        requestToken = defaults.string(forKey: "requestToken")
        refresh()
    }
    
    @objc func refresh() {
        
        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert!.mode = MBProgressHUDMode.indeterminate
        
        
        
        if userToken != nil&&requestToken != nil{
          //  var typeCount=0
           
            select.GetMyViews(){
                
                (obj) in
                
                
                
                
                for advert in obj.data {
                    
                    //if (advert.isPaid==type) {
                    let item = advert
            
                        
                         self.advertArray.append(item)
                       
                    
                    
//                    DispatchQueue.main.async {
//
//                        if self.isPaidSegment.selectedSegmentIndex == 0{
//                            self.advertArray = self.isPaid
//                            typeCount=self.isPaid.count
//                        }else {
//                            self.advertArray = self.isNotPaid
//                            typeCount=self.isNotPaid.count
//                        }
//
//
//
//                        self.ReklamCount.text="Reklam sayı \(String(typeCount))"
//                        self.ReklamList.reloadData()
//
//                        self.myRefreshControl.endRefreshing()
//
//                        self.loadingAlert!.hide(animated: true)
//
//                        //
//
//                    }
//
                    
                    
                }
                
                 self.loadingAlert!.hide(animated: true)
                self.aTableView.reloadData()
                
                
            }
        }
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "photoReklamPage"){
            let displayVC = segue.destination as! AboutAdvertController
            displayVC.advertID = advertID
             displayVC.fromArchieve = true
        }
        if(segue.identifier == "textReklamPage"){
            let displayVC = segue.destination as! TextReklamController
            displayVC.advertID = advertID
             displayVC.fromArchieve = true
        }
        if(segue.identifier == "videoReklamPage"){
            let displayVC = segue.destination as! VideoReklamController
            displayVC.advertID = advertID
            displayVC.fromArchieve = true
        }
//        if(segue.identifier == "aCatSegue"){
//            let displayVC = segue.destination as! CategoryViewController
//            displayVC.object = catObject
//        }

        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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
extension MyViewsController:UITableViewDelegate,UITableViewDataSource
{
    
    
//    
//    func updateSearchResults(for searchController: UISearchController) {
//        //searchbara her defe nese yazanda bu functionu edir
//        //menlik bir qullugun tapshirigin?))
//        //ishledemmedin?
//        //be bu niye itmir??
//        //kele sarimisane deyesen))
//        print("blablabla")
//    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        advertID=advertArray[indexPath.row].id!
        //print(advertID!)
        if advertArray[indexPath.row].aTypeId==2{
            self.performSegue(withIdentifier: "photoReklamPage", sender: self)
            
        }
        if advertArray[indexPath.row].aTypeId==1{
            self.performSegue(withIdentifier: "textReklamPage", sender: self)
            
        }
        if advertArray[indexPath.row].aTypeId==3{
            self.performSegue(withIdentifier: "videoReklamPage", sender: self)

        }
        //print(cell.object?.name)
        //cell.delegate = self
     
        
    }
    
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return advertArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReklamCellTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ReklamCellTableViewCell)
        do{
            // cell.imageView?.image = nil
            if advertArray[indexPath.row].photo == nil{
                Alamofire.request((advertArray[indexPath.row].photoUrl![0])).responseImage { response in
                    if let catPicture = response.result.value {
                        //advert.photo=catPicture.pngData()
                        
                        //  item.photo = UIImage(named: "damaged")?.pngData()
                        if indexPath.row <= self.advertArray.count {
                            
                            if catPicture != nil {
                                
                                self.advertArray[indexPath.row].photo=catPicture.pngData()!
                                
                                
                            }
                            else {
                                self.advertArray[indexPath.row].photo=UIImage(named: "damaged")?.pngData()
                                
                            }
                            
                            self.advertArray[indexPath.row].downloaded=true
                            
                            
                            // dataArray[dowloadedCount]=item
                            
                            
                            cell.object = self.advertArray[indexPath.row]
                        }
                        
                        
                        cell.reloadData()
                    }
                    
                    
                    
                }
            }
            cell.object = advertArray[indexPath.row]
            
            
        }
        catch
        {
            print(indexPath.row)
        }
        
        //cell.delegate = self
        cell.reloadData()
        //cell.object = dataArray[indexPath.row]
        //     cell.delegate = self
        
        
        // Configure the cell...
        
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
