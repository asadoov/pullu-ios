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
    let defaults = UserDefaults.standard
    private let myRefreshControl = UIRefreshControl()
    @IBOutlet weak var aTableView: UITableView!
    let warningLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        myRefreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        aTableView.addSubview(myRefreshControl)
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        
        addWarningLabel()
        warningLabel.text = "Heç bir elan tapılmadı..."
        
        // let userData = defaults.string(forKey: "uData")
        userToken = defaults.string(forKey: "userToken")
        requestToken = defaults.string(forKey: "requestToken")
        refresh()
    }
    private func addWarningLabel() {
        
        
        //self.notFoundLabel.backgroundColor = .orange
        // self.notFoundLabel.center = viewersTable.center
        
        self.aTableView.addSubview(self.warningLabel)
        
        // set position
        self.warningLabel.translatesAutoresizingMaskIntoConstraints = false
        self.warningLabel.centerXAnchor.constraint(equalTo: self.aTableView.centerXAnchor).isActive = true
        self.warningLabel.centerYAnchor.constraint(equalTo: self.aTableView.centerYAnchor).isActive = true
        self.warningLabel.isHidden = true
        //       DispatchQueue.main.async {
        //              // self.notFoundLabel.layer.cornerRadius = self.notFoundLabel.frame.height.self / 2.0
        //        self.notFoundLabel.numberOfLines = 0
        //        self.notFoundLabel.lineBreakMode = .byWordWrapping
        //        self.notFoundLabel.adjustsFontSizeToFitWidth = true
        //              }
        //              self.notFoundLabel.clipsToBounds = true
        
    }
    
    @objc func refresh() {
        
        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert!.mode = MBProgressHUDMode.indeterminate
        //
        self.myRefreshControl.beginRefreshing()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        //  var typeCount=0
        
        select.GetMyViews(){
            
            (obj) in
            UIApplication.shared.endIgnoringInteractionEvents()
            switch obj.status{
                
            case 1:
                if obj.data.count > 0 {
                    self.warningLabel.isHidden = true
                    
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
                }
                else {
                    self.warningLabel.isHidden = false
                }
                break
            case 2:
                self.userToken = self.defaults.string(forKey: "userToken")
                self.requestToken = self.defaults.string(forKey: "requestToken")
                if self.userToken != nil && self.requestToken != nil {
                    
                    let alert = UIAlertController(title: "Sessiyanız başa çatıb", message: "Zəhmət olmasa yenidən giriş edin", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "Giriş et", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                        self.defaults.set(nil, forKey: "userToken")
                        self.defaults.set(nil, forKey: "requestToken")
                        self.defaults.set(nil, forKey: "uData")
                        let menu:MenuController = MenuController()
                        menu.updateRootVC(status: false)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                 let alert = UIAlertController(title: "Diqqət!", message: "Arxiv bölümünə daxil olmaq üçün, qeydiyyatdan keçməniz vacibdir", preferredStyle: UIAlertController.Style.alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Qeydiyyat", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                                        self.defaults.set(nil, forKey: "userToken")
                                        self.defaults.set(nil, forKey: "requestToken")
                                        self.defaults.set(nil, forKey: "uData")
                                        let menu:MenuController = MenuController()
                                        menu.updateRootVC(status: false)
                                    }))
                                    self.present(alert, animated: true, completion: nil)
                }
                break
            default:
                let alert = UIAlertController(title: "Xəta", message: "Zəhmət olmasa biraz sonra yenidən cəht edin", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                    //logout
                }))
                self.present(alert, animated: true, completion: nil)
                break
                
                
                
                
            }
            
            
            
            self.loadingAlert!.hide(animated: true)
            self.myRefreshControl.endRefreshing()
            self.aTableView.reloadData()
            
            
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
            
            
            if   cell.imageView?.image == nil{
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
