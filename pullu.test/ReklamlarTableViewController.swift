//
//  ReklamlarTableViewController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/10/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class ReklamlarTableViewController: UITableViewController {
    var dataArray: [Advertisement] = [Advertisement]()
    @IBOutlet var ReklamList: UITableView!
    
    @IBOutlet weak var ReklamCount: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    var notPaid:Array<Advertisement>?
    var Paid:Array<Advertisement>?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.layer.backgroundColor = UIColor.white.cgColor
        
        headerView.layer.masksToBounds = false
        headerView.layer.shadowColor = UIColor.gray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        headerView.layer.shadowOpacity = 1.0
        headerView.layer.shadowRadius = 0.0
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        //
        self.getProducts(type:1)
        
    }
    
    
    @IBAction func paidClick(_ sender: Any) {

        self.getProducts(type:1)
        
        
    }
    @IBAction func notPaidClick(_ sender: Any) {
       
        self.dataArray.removeAll()
        self.getProducts(type:0)
        
    }
    
    private func getProducts(type:Int) {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: nil, message: "Yüklənir...", preferredStyle: .alert)
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating();
            
            alert.view.addSubview(loadingIndicator)
            self.present(alert, animated: true, completion: nil)
        }
        
        
        let defaults = UserDefaults.standard
        
        // let userData = defaults.string(forKey: "uData")
        let mail = defaults.string(forKey: "mail")
        let pass = defaults.string(forKey: "pass")
        print("\(mail)\n\(pass)")
        let  db:dbSelect=dbSelect()
        db.getAds(username: mail!, pass: pass!){
            (list) in
            for advert in list{
                if (advert.isPaid==type) {
                    
                    self.dataArray.append(advert)
                    
                    
                }
                
                
                //bunu cixardir melumatlar gelir yani- print(advert.name)
            }
            
            DispatchQueue.main.async {
                self.dismiss(animated: false){
                    self.ReklamList.reloadData()
                    self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                    self.tableView.reloadData()
                    
                    
                    
                }
                
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
        return dataArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReklamCellTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ReklamCellTableViewCell)
        cell.object = dataArray[indexPath.row]
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
