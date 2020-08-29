//
//  InterestsController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 7/15/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class MyViewers: UITableViewController {
    let defaults = UserDefaults.standard
    var viewerList:Array<ViewerStruct> =  Array<ViewerStruct>()
    var select:DbSelect = DbSelect()
    @IBOutlet var viewersTable: UITableView!
    var loadingAlert:MBProgressHUD?
    var aID:Int?
    private let myRefreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewersTable.dataSource = self
        viewersTable.delegate = self
        myRefreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        viewersTable.addSubview(myRefreshControl)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //self.navigationItem.hidesBackButton = true
        //        let newBackButton = UIBarButtonItem(title: "Geri", style: UIBarButtonItem.Style.plain, target: self, action: #selector(InterestsController.back(sender:)))
        //self.navigationItem.leftBarButtonItem = newBackButton
        refresh()
    }
    
    @objc func refresh() {
        viewerList.removeAll()
        myRefreshControl.beginRefreshing()
        
        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert!.mode = MBProgressHUDMode.indeterminate
        loadingAlert?.show(animated: true)
        
        select.MyAdViewers(aID: aID!)
        {
            (obj)
            in
            self.loadingAlert?.hide(animated: true)
            self.myRefreshControl.endRefreshing()
            switch (obj.status)
            {
            case 1:
                for item in obj.data{
                    self.viewerList.append(item)
                    DispatchQueue.main.async {
                        self.viewersTable.reloadData();
                    }
                }
                break
            case 2:
                
                let alert = UIAlertController(title: "Bildiriş", message: "Reklama hələki heç kəs baxmayıb", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                break
            case  3:
                
                let alert = UIAlertController(title: "Bildiriş", message: "Sizin bu reklamın statistikasına baxmağa icazəniz yoxdur", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                break
                
            case  4:
                self.dismiss(animated: false)
                break
                
            default:
                let alert = UIAlertController(title: "Xəta", message: "Xidmət səviyyəsinin yüksəldilməsi məqsədi ilə bizimlə bu xəta barədə bölüşməyiniz xahiş olunur", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                break
            }
            
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewerList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ViewerCell = (tableView.dequeueReusableCell(withIdentifier: "viewerCell", for: indexPath) as! ViewerCell)
        do{
            // cell.imageView?.image = nil
            if viewerList.count > 0{
                
                Alamofire.request(viewerList[indexPath.row].photoURL!).responseImage { response in
                    if let catPicture = response.result.value {
                        //advert.photo=catPicture.pngData()
                        
                        //  item.photo = UIImage(named: "damaged")?.pngData()
                        
                        
                        if catPicture != nil {
                            
                            cell.userImage?.image=catPicture
                            cell.loadingIndicator.stopAnimating()
                            
                        }
                        else {
                            cell.userImage?.image=UIImage(named: "damaged")
                            
                        }
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                }
                
                cell.userNameSurname?.text = " \(viewerList[indexPath.row].name!) \(viewerList[indexPath.row].surname!)"
            }
            
            
            
        }
        catch
        {
            print(indexPath.row)
        }
        
        
        
        return cell
    }
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //    }
    
    
    
    
    
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
