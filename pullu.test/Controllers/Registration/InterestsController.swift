//
//  InterestsController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 7/15/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class InterestsController: UITableViewController {
    var interestList:Array<Interest> =  Array<Interest>()
    var select:DbSelect = DbSelect()
    @IBOutlet var interestsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //self.navigationItem.hidesBackButton = true
//        let newBackButton = UIBarButtonItem(title: "Geri", style: UIBarButtonItem.Style.plain, target: self, action: #selector(InterestsController.back(sender:)))
               //self.navigationItem.leftBarButtonItem = newBackButton
        select.GetInterests()
            {
                (list)
                in
                for item in list{
                    self.interestList.append(item)
                    DispatchQueue.main.async {
                        self.interestsTable.reloadData();
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
        return interestList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
         let cell = tableView.dequeueReusableCell(withIdentifier: "interestCell")!
           do{
               // cell.imageView?.image = nil
               if interestList.count > 0{
                
                 cell.textLabel?.text = interestList[indexPath.row].name
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
 
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedRows = tableView.indexPathsForSelectedRows?.filter({ $0.section == indexPath.section }) {
            if selectedRows.count > 3 {
                let alert = UIAlertController(title: "Bildiriş", message: "Maximum 4 maraq dairəsi seçmək mümkündür", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return nil
                
            }
//            else
//            {
//               let cell = tableView.cellForRow(at: indexPath)!
//        cell.contentView.superview?.backgroundColor = UIColor.orange
//            
//            }
         
            
        }

        return indexPath
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        var values : Array<Interest> = Array<Interest>()
           let selected_indexPaths = tableView.indexPathsForSelectedRows
        if selected_indexPaths != nil{
            
        
           for indexPath in selected_indexPaths! {
              
               values.append(interestList[indexPath.row])
               //print(interestList[indexPath.row].name!)
           }
       
    }
        else
        {
//            var defaultInterest:Interest = Interest()
//            defaultInterest.name = "Maraqlarınızı seçin..."
//            defaultInterest.id = 0
//            values.append(defaultInterest)
        }
        let imageDataDict:[String: Array<Interest>] = ["interests": values]

               // post a notification
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: imageDataDict)
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
