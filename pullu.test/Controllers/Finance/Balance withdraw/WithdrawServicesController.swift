//
//  WithdrawServicesController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 7/19/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
class WithdrawServicesController: UITableViewController {
    var loadingAlert:MBProgressHUD=MBProgressHUD()
    var wServiceList:Array<WithdrawService> = Array<WithdrawService>()
    var earningValue:Double?
    var serviceName:String?
    var serviceID:Int?
    @IBOutlet var servicesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        servicesTable.dataSource = self
        servicesTable.delegate = self
        
        
        
        
        
        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert.mode = MBProgressHUDMode.indeterminate
        let operations:PaymentOperation = PaymentOperation()
        operations.GetWithdrawServices(){
            (obj)
            in
            self.loadingAlert.hide(animated: true)
            switch obj.status{
            case 1:
                self.wServiceList = obj.data
                self.servicesTable.reloadData()
                break
            case 2:
                let alert = UIAlertController(title: "Bildiriş", message: "Heç bir servis tapılmadı", preferredStyle: UIAlertController.Style.alert)
                                          alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                          self.present(alert, animated: true, completion: nil)
                           
                break
            case 3:
                let alert = UIAlertController(title: "Xəta", message: "Biraz sonra yenidən cəht edin", preferredStyle: UIAlertController.Style.alert)
                                          alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                          self.present(alert, animated: true, completion: nil)
                           
                break
            default:break
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wServiceList.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if wServiceList[indexPath.row].serviceCatID == 6 {
            serviceName = wServiceList[indexPath.row].serviceName
            serviceID = wServiceList[indexPath.row].serviceID
            performSegue(withIdentifier: "operatorPaySegue", sender: self)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = servicesTable.dequeueReusableCell(withIdentifier: "serviceCell")!
        // Configure the cell...
        Alamofire.request(wServiceList[indexPath.row].serviceImgURL!).responseImage { response in
            if let catPicture = response.result.value {
                //advert.photo=catPicture.pngData()
                
                //  item.photo = UIImage(named: "damaged")?.pngData()
               
                    
                    if catPicture != nil {
                        
                        cell.imageView!.image=catPicture
                        self.servicesTable.reloadData()
//                        self.loadingIndicator.stopAnimating()
                        
                    }
                    else {
                        cell.imageView!.image=UIImage(named: "damaged")
                        
                    }
                    
                  
                
                
                
               
            }
            
            
            
        }
        cell.textLabel?.text=wServiceList[indexPath.row].serviceName
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "operatorPaySegue") {
        let displayVC = segue.destination as! OperatorsController
            displayVC.serviceName = serviceName
            displayVC.serviceID = serviceID
            displayVC.earningValue = earningValue
        //displayVC.id =
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
