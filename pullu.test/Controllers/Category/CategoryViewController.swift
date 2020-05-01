//
//  CategoryViewController.swift
//  pullu.test
//
//  Created by Rufat on 3/25/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MBProgressHUD
class CategoryViewController: UIViewController {
    @IBOutlet weak var aTableView: UITableView!
    var advertArray: [Advertisement] = [Advertisement]()
    var isPaid: [Advertisement] = [Advertisement]()
    var isNotPaid: [Advertisement] = [Advertisement]()
    var object:CategoryStruct?
    var mail:String?
    var pass:String?
    var aID:Int?
    let  db:dbSelect=dbSelect()
    var loadingAlert:MBProgressHUD?
    @IBOutlet weak var isPaidSegment: UISegmentedControl!
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    var loadingView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //showActivityIndicator()
        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert!.mode = MBProgressHUDMode.annularDeterminate
        loadingAlert!.label.text="Gözləyin"
        loadingAlert!.detailsLabel.text = "Reklamları gətirirk..."
        let defaults = UserDefaults.standard
        // Do any additional setup after loading the view.
        mail = defaults.string(forKey: "mail")
        pass = defaults.string(forKey: "pass")
        self.title=object?.name
        db.getAds(username: mail!, pass: pass!, catID: object?.id!,progressView: loadingAlert!){
            
            (list) in
            
            
            
            for advert in list {
                var typeCount = 0
                
                for itm in list{
                    if itm.isPaid==1{
                        typeCount += 1
                    }
                }
                
                
                var item = advert
                
                
                
                
                
                if  item.isPaid==1{
                    
                    self.isPaid.append(item)
                    
                    
                }
                if  item.isPaid==0{
                    
                    self.isNotPaid.append(item)
                    
                    
                    
                    
                }
                
                
                self.advertArray = self.isPaid
                
                DispatchQueue.main.async {
                    
                    //self.ReklamCount.text="Reklam sayı \(String(typeCount))"
                    self.aTableView.reloadData()
                    //                    self.hideActivityIndicator()
                    DispatchQueue.main.async {
                        self.loadingAlert!.hide(animated: true)
                        
                    }
                    
                }
                
                
                
            }
            
            
            
        }
    }
    
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor.black
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
            self.spinner = UIActivityIndicatorView(style: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            
            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    
    @IBAction func isPaidSegmentChanged(_ sender: Any) {
        
        self.advertArray.removeAll()
        
        if (!aTableView.isTracking && !aTableView.isDecelerating) {
            if isPaidSegment.selectedSegmentIndex == 0{
                if  isPaid != nil{
                    advertArray = isPaid
                    DispatchQueue.main.async {
                        self.aTableView.reloadData()
                        
                        
                    }
                }
                // Table was scrolled by user.
                //                if dataArray.count>0{
                //
                //                    for item in dataArray{
                //                        if item.isPaid==1{
                //
                //                            advertArray.append(item)
                //                        }
                //
                //                    }
                //
                //                    DispatchQueue.main.async {
                //                        self.ReklamCount.text="Reklam sayı \(String(self.advertArray.count))"
                //                        self.ReklamList.reloadData()
                //
                //
                //                    }
                //
                //                }
            }
            
            if isPaidSegment.selectedSegmentIndex==1{
                if  isNotPaid != nil{
                    advertArray = isNotPaid
                    DispatchQueue.main.async {
                        self.aTableView.reloadData()
                        
                        
                    }
                }
                
                // Table was scrolled by user.
                //                if dataArray.count>0{
                //                    for item in dataArray{
                //                        if item.isPaid==0{
                //
                //                            advertArray.append(item)
                //                        }
                //
                //                    }
                //                    DispatchQueue.main.async {
                //                        self.ReklamCount.text="Reklam sayı \(String(self.advertArray.count))"
                //
                //                        self.ReklamList.reloadData()
                //
                //
                //                    }
                //                }
            }
            
        }
        else  {
            
            if isPaidSegment.selectedSegmentIndex == 0{
                
                isPaidSegment.selectedSegmentIndex = 1
                
            }
            if isPaidSegment.selectedSegmentIndex == 1{isPaidSegment.selectedSegmentIndex = 0}
            
        }
        
        
        
        
        
        
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "photoReklamPage"){
            let displayVC = segue.destination as! AboutAdvertController
            displayVC.advertID = aID
        }
        if(segue.identifier == "textReklamPage"){
            let displayVC = segue.destination as! TextReklamController
            displayVC.advertID = aID
        }
        if(segue.identifier == "videoReklamPage"){
            let displayVC = segue.destination as! VideoReklamController
            displayVC.advertID = aID
        }
        //          if(segue.identifier == "aCatSegue"){
        //              let displayVC = segue.destination as! CategoryViewController
        //              displayVC.object = catObject
        //          }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    
}
extension CategoryViewController:UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: ReklamCellTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ReklamCellTableViewCell)
        cell.object = advertArray[indexPath.row]
        aID=cell.object?.id!
        //print(advertID!)
        if cell.object?.aTypeId==2{
            self.performSegue(withIdentifier: "photoReklamPage", sender: self)
            
        }
        if cell.object?.aTypeId==1{
            self.performSegue(withIdentifier: "textReklamPage", sender: self)
            
        }
        if cell.object?.aTypeId==3{
            self.performSegue(withIdentifier: "videoReklamPage", sender: self)
            
        }
        //print(cell.object?.name)
        //cell.delegate = self
        cell.reloadData()
        
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
                            
                            
                            
                            
                            // dataArray[dowloadedCount]=item
                            
                            
                            
                        }
                        
                        cell.object = self.advertArray[indexPath.row]
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
