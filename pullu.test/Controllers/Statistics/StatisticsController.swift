//
//  StatisticsController.swift
//  pullu.test
//
//  Created by Rufat on 2/6/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Firebase

class StatisticsController: UIViewController {
    @IBOutlet weak var statisticsTableView: UITableView!
    
    @IBOutlet weak var allUsers: UILabel!
    @IBOutlet weak var allUsersToday: UILabel!
    @IBOutlet weak var allAds: UILabel!
    @IBOutlet weak var myTodayViews: UILabel!
    @IBOutlet weak var allMyViews: UILabel!
    @IBOutlet weak var myPaidViews: UILabel!
    @IBOutlet weak var myNotPaidViews: UILabel!
    @IBOutlet weak var myAds: UILabel!
    @IBOutlet weak var myNotPaidAds: UILabel!
    @IBOutlet weak var myPaidAds: UILabel!
    var select:DbSelect=DbSelect()
    let defaults = UserDefaults.standard
    var statisticsData:Statistics=Statistics()
    let headerTitles = ["Tətbiq statistikası", "İstifadəçi statistikası"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let mail = defaults.string(forKey: "mail")
        let pass = defaults.string(forKey: "pass")
        select.getStatistics(mail: mail!, pass: pass!) {
            (statistics)
            in
            self.statisticsData = statistics
            DispatchQueue.main.async {
                self.statisticsTableView.reloadData()
                //            self.allUsers.text=String(statistics.allUsers!)
                //            self.allUsersToday.text=String(statistics.allUsersToday!)
                //            self.allAds.text=String(statistics.allAds!)
                //            self.myTodayViews.text=String(statistics.myTodayViews!)
                //            self.allMyViews.text=String(statistics.allMyViews!)
                //            self.myPaidViews.text=String(statistics.myPaidViews!)
                //            self.myNotPaidViews.text=String(statistics.myNotPaidViews!)
                //            self.myAds.text=String(statistics.myAds!)
                //            self.myNotPaidAds.text=String(statistics.myNotPaidAds!)
                //            self.myPaidAds.text=String(statistics.myPaidAds!)
            }
            
        }
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
extension StatisticsController:UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating
{
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        //searchbara her defe nese yazanda bu functionu edir
        //menlik bir qullugun tapshirigin?))
        //ishledemmedin?
        //be bu niye itmir??
        //kele sarimisane deyesen))
        print("blablabla")
    }
    
    
    
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let cell: ReklamCellTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ReklamCellTableViewCell)
    //        cell.object = advertArray[indexPath.row]
    //        advertID=cell.object?.id!
    //        //print(advertID!)
    //        if cell.object?.aTypeId==2{
    //            self.performSegue(withIdentifier: "photoReklamPage", sender: self)
    //
    //        }
    //        if cell.object?.aTypeId==1{
    //            self.performSegue(withIdentifier: "textReklamPage", sender: self)
    //
    //        }
    //        if cell.object?.aTypeId==3{
    //            self.performSegue(withIdentifier: "videoReklamPage", sender: self)
    //
    //        }
    //        //print(cell.object?.name)
    //        //cell.delegate = self
    //        cell.reloadData()
    //
    //    }
    
    
    
    // MARK: - Table view data source
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 2
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var count = 0
        switch section {
        case 0:
            count = 3
        case 1:
            count = 6
        default:
            break
        }
        return count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StatisticsCell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! StatisticsCell)
        do{
        
            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    cell.name = "Ümumi istifadəçi sayı"
                    cell.count=statisticsData.allUsers
                case 1:
                    cell.name = "Bugünə istifadəçi sayı"
                    cell.count=statisticsData.allUsersToday
                    case 2:
                                       cell.name = "Yerləşdirilmiş reklam sayı"
                                       cell.count=statisticsData.allAds
                default: break
                    
                }
            case 1:
                switch indexPath.row {
               
                case 0:
                    cell.name = "Bugünə reklam baxışınız"
                    cell.count=statisticsData.myTodayViews
                case 1:
                    cell.name = "Ümumi reklam baxışınız"
                    cell.count=statisticsData.allMyViews
                case 2:
                    cell.name = "Ödənişli reklam baxışınız"
                    cell.count=statisticsData.myPaidViews
                case 3:
                    cell.name = "Ödənişsiz reklam baxışınız"
                    cell.count=statisticsData.myNotPaidViews
                case 4:
                    cell.name = "Əlavə etdiyiniz reklamlar"
                    cell.count=statisticsData.myAds
                case 5:
                    cell.name = "Əlavə etdiyiniz ödənişli reklamlar"
                    cell.count=statisticsData.myPaidAds
                case 6:
                    cell.name = "Əlavə etdiyiniz ödənişsiz reklamlar"
                    cell.count=statisticsData.myNotPaidAds
                default: break
                }
                
            default: break
                
                
                
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
