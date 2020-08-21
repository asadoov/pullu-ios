//
//  PaidController.swift
//  pullu.test
//
//  Created by Rufat on 5/8/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class NotPaidController: UITableViewController {
    var loadingAlert:MBProgressHUD?
    var advertArray: [Advertisement] = [Advertisement]()
    let  select:DbSelect=DbSelect()
    var userToken:String?
    var requestToken:String?
    private let myRefreshControl = UIRefreshControl()
    @IBOutlet var notPaidTableView: UITableView!
    var paginationEnabled=true
    var loading = false
    var advertID:Int?
    var currentPage = 1
    public var catID:Int = 0
     let defaults = UserDefaults.standard
     let spinner = UIActivityIndicatorView(style: .gray)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        notPaidTableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        myRefreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        notPaidTableView.addSubview(myRefreshControl)
        let defaults = UserDefaults.standard
        userToken = defaults.string(forKey: "userToken")
        requestToken = defaults.string(forKey: "requestToken")
        refresh()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return advertArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = self.advertArray.count - 1
        if indexPath.row == lastItem {
            //print("IndexRow\(indexPath.row)")
            
            
           
            
            currentPage += 1
            pagination(page: currentPage)
            //        if currentPage < totalPage {
            //            currentPage += 1
            //           //Get data from Server
            //        }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReklamCellTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ReklamCellTableViewCell)
        do{
            if loading == false  {
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
    
    func pagination(page:Int){
        
        
        
        
        if paginationEnabled{
            //                loading = true
            //                       var loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
            //                        loadingAlert.mode = MBProgressHUDMode.indeterminate
            //                        loadingAlert.label.text="Gözləyin"
            //                        loadingAlert.detailsLabel.text = "Reklamları yeniləyirik..."
            
            spinner.startAnimating()
                       spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

                       self.notPaidTableView.tableFooterView = spinner
                       self.notPaidTableView.tableFooterView?.isHidden = false
            
            var typeCount=0
            
            select.GetAds(isPaid: 0,page: page, catID: catID,progressView: loadingAlert!){
                
                (obj) in
                 self.spinner.stopAnimating()
                 self.notPaidTableView.tableFooterView = nil
                switch obj.status {
                case 1:
                    if !obj.data.isEmpty {
                         // self.defaults.set(obj.requestToken, forKey: "requestToken")
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
                                self.notPaidTableView.reloadData()
                                
                                self.myRefreshControl.endRefreshing()
                                
                                
                                
                                //
                                
                            }
                            
                            
                            
                        }
                    
                        
                    }
                    else   {
                        
                        self.paginationEnabled = false
                    }
                    break
                case 2:
                    let alert = UIAlertController(title: "Sessiyanız başa çatıb", message: "Zəhmət olmasa yenidən giriş edin", preferredStyle: UIAlertController.Style.alert)
                                                                        
                                                                        alert.addAction(UIAlertAction(title: "Giriş et", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                                                                            //logout
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
                
                
                
                
                
                   
                
                //loadingAlert.hide(animated: true)
                self.loading = false
            }
        }
        
    }
    @objc func refresh() {
        paginationEnabled = true
        loading = true
        advertArray.removeAll()
        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert!.mode = MBProgressHUDMode.indeterminate
        
        
        
     
            // var typeCount=0
            
            
            select.GetAds(isPaid: 0,page: 1, catID: catID,progressView: loadingAlert!){
                
                (obj) in
                switch obj.status {
                case 1:
                  
                if !obj.data.isEmpty{
                      //self.defaults.set(obj.requestToken, forKey: "requestToken")
//                    if obj.status != 3{
                        if obj.data.count > 0{
                            
                            for advert in obj.data {
                                                      
                                                      //if (advert.isPaid==type) {
                                                      let item = advert
                                                      
                                                      
                                                      
                                                      self.advertArray.append(item)
                                                      
                                                      
                                                      
                                                      
                                                      
                                                      DispatchQueue.main.async {
                                                          
                                                          //                            if self.isPaidSegment.selectedSegmentIndex == {
                                                          //                                self.advertArray = self.isPaid
                                                          //                                typeCount=self.isPaid.count
                                                          //                            }else {
                                                          //                                self.advertArray = self.isNotPaid
                                                          //                                typeCount=self.isNotPaid.count
                                                          //                            }
                                                          //
                                                          
                                                          
                                                          //self.ReklamCount.text="Reklam sayı \(String(typeCount))"
                                                          self.notPaidTableView.reloadData()
                                                          
                                                          self.myRefreshControl.endRefreshing()
                                                          
                                                          
                                                          
                                                          
                                                          
                                                      }
                                                      
                                                      
                                                      
                                                  }
                        }
                       
                         self.myRefreshControl.endRefreshing()
                        self.loading = false
                        self.loadingAlert!.hide(animated: true)
//                        self.paginationEnabled = true
//                    }
//
//
//                    else {
////                        self.myRefreshControl.endRefreshing()
////                        self.loadingAlert!.hide(animated: true)
////                        let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
////                        warningAlert.mode = MBProgressHUDMode.text
////                        //            warningAlert.isSquare=true
////                        warningAlert.label.text = "Xəta"
////                        warningAlert.detailsLabel.text = "Zəhmət olmasa biraz sonra yenidən cəht edin"
////                        warningAlert.hide(animated: true,afterDelay: 3)
//
//                    }
                }
                else
                {
                                                              let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                                                              
                                                              warningAlert.mode = MBProgressHUDMode.text
                                                              //            warningAlert.isSquare=true
                                                              warningAlert.label.text = "Bildiriş"
                                                              warningAlert.detailsLabel.text = "Heç bir pulsuz reklam taapılmadı"
                                                              warningAlert.hide(animated: true,afterDelay: 3)
                                                              
                                                          }
                
                break
                case 2:
                let alert = UIAlertController(title: "Sessiyanız başa çatıb", message: "Zəhmət olmasa yenidən giriş edin", preferredStyle: UIAlertController.Style.alert)
                                                                                       
                                                                                       alert.addAction(UIAlertAction(title: "Giriş et", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                                                                                           //logout
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
                self.myRefreshControl.endRefreshing()
                                                  self.loadingAlert!.hide(animated: true)
                           
                
            }
            
            
           
            
            
        
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "photoReklamPage"){
            let displayVC = segue.destination as! AboutAdvertController
            displayVC.advertID = advertID
        }
        if(segue.identifier == "textReklamPage"){
            let displayVC = segue.destination as! TextReklamController
            displayVC.advertID = advertID
        }
        if(segue.identifier == "videoReklamPage"){
            let displayVC = segue.destination as! VideoReklamController
            displayVC.advertID = advertID
        }
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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
    
}

