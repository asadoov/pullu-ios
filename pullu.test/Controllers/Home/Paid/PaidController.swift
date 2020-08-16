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
class PaidController: UITableViewController {
    var loadingAlert:MBProgressHUD = MBProgressHUD()
    var advertArray: [Advertisement] = [Advertisement]()
    let  select:DbSelect=DbSelect()
    var mail:String?
    var pass:String?
    
    @IBOutlet var paidTableView: UITableView!
    var paginationEnabled=true
    var loading = false
    var advertID:Int?
    var currentPage = 1
    var catID = 0
    let defaults = UserDefaults.standard
    private let myRefreshControl = UIRefreshControl()
    let spinner = UIActivityIndicatorView(style: .gray)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        paidTableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        myRefreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        paidTableView.addSubview(myRefreshControl)
        
        mail = defaults.string(forKey: "mail")
        pass = defaults.string(forKey: "pass")
        self.refresh()
//        select.SignIn(mail: mail!, pass: pass!){
//            (user)
//            in
//            if !user.isEmpty{
//                self.refresh()
//            }
//            else{
//
//                self.dismiss(animated: true)
//            }
//
//
//
//        }
        
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReklamCellTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ReklamCellTableViewCell)
        do{
            // cell.imageView?.image = nil
            if advertArray.count > 0{
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
            
            self.paidTableView.tableFooterView = spinner
            self.paidTableView.tableFooterView?.isHidden = false
            var typeCount=0
            
            select.getAds(username: mail ?? "", pass: pass ?? "",isPaid: 0,page: page, catID: catID,progressView: loadingAlert){
                
                (list) in
                self.spinner.stopAnimating()
                self.paidTableView.tableFooterView = nil
                if !list.data.isEmpty {
                    for advert in list.data {
                        
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
                            self.paidTableView.reloadData()
                            
                            self.myRefreshControl.endRefreshing()
                            
                            
                            
                            //
                            
                        }
                        
                        
                        
                    }
                    
                    
                }
                else   {
                    
                    self.paginationEnabled = false
                }
                
                
                
                
                
                
                //loadingAlert.hide(animated: true)
                self.loading = false
            }
        }
        
    }
    
    @objc func refresh() {
        
        
      
            paginationEnabled = true
            loading = true
            
            

            self.myRefreshControl.beginRefreshing()
            var typeCount=0
            
            select.getAds(username: mail ?? "", pass: pass ?? "",isPaid: 1,page: 1, catID: catID,progressView: loadingAlert){
                
                (list) in
                
                
                
                if !list.data.isEmpty{
                    if list.status != 3{
                        self.advertArray.removeAll()
                        
                        for advert in list.data {
                            
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
                                self.paidTableView.reloadData()
                                
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                        self.myRefreshControl.endRefreshing()
                        self.loading = false
                        
                        self.paginationEnabled = true
                    }
                    else {
                        
                        self.myRefreshControl.endRefreshing()
                        //self.loadingAlert!.hide(animated: true)
                        let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                        warningAlert.mode = MBProgressHUDMode.text
                        //            warningAlert.isSquare=true
                        warningAlert.label.text = "Xəta"
                        warningAlert.detailsLabel.text = "Zəhmət olmasa biraz sonra yenidən cəht edin"
                        warningAlert.hide(animated: true,afterDelay: 3)
                    }
                    
                    
                    
                }
                else  {
                    
                    self.myRefreshControl.endRefreshing()
                   // self.loadingAlert!.hide(animated: true)
                    let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                    warningAlert.mode = MBProgressHUDMode.text
                    //            warningAlert.isSquare=true
                    warningAlert.label.text = "Bildiriş"
                    warningAlert.detailsLabel.text = "Heç bir pullu reklam taapılmadı"
                    warningAlert.hide(animated: true,afterDelay: 3)
                    
                }
                
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
    
    override func viewWillAppear(_ animated: Bool) {
        mail = defaults.string(forKey: "mail")
        pass = defaults.string(forKey: "pass")
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
    
}

