//
//  MenuController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/16/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var nameSurname: UILabel!
    
    @IBOutlet weak var balance: UILabel!
    
    @IBOutlet weak var earning: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var userID: UILabel!
    
    var select:dbSelect=dbSelect()
    var profM = ProfileModel()
    var menuItems:Array<MenuStruct> = Array<MenuStruct>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logOutBtn:MenuStruct = MenuStruct()
        logOutBtn.ID=0
        logOutBtn.name="Çıxış"
        logOutBtn.icon = UIImage(named: "logout")?.pngData()
           let profileBtn:MenuStruct = MenuStruct()
        profileBtn.ID=1
           profileBtn.name="Profil"
         menuItems.append(profileBtn)
        menuItems.append(logOutBtn)
        
        
        
        //
        //        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //        navigationController?.navigationBar.shadowImage = UIImage()
        //        navigationController?.navigationBar.isTranslucent = true
        
        /*     headerView.layer.backgroundColor = UIColor.white.cgColor
         
         headerView.layer.masksToBounds = false
         headerView.layer.shadowColor = UIColor.gray.cgColor
         headerView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
         headerView.layer.shadowOpacity = 1.0
         headerView.layer.shadowRadius = 0.0
         */
        
        
        let udata=defaults.string(forKey: "uData")
        do{
            
            
            let list  = try
                JSONDecoder().decode(Array<User>.self, from: udata!.data(using: .utf8)!)
            
            // userList=list
            nameSurname.text = "\(list[0].name!) \(list[0].surname!)"
            balance.text = "Yüklənən məbləğ\n\(list[0].balance!) AZN"
            earning.text = "Qazanılan məbləğ\n\(list[0].earning!) AZN"
            userID.text = "İstifadəci nömrəniz: \(list[0].id!)"
            
            
        }
        catch let jsonErr{
            print("Error serializing json:",jsonErr)
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        super.viewWillAppear(animated)
    }
    
//    @IBAction func profilButton(_ sender: Any) {
//        DispatchQueue.main.async {
//            self.performSegue(withIdentifier: "profSegue", sender: self)
//        }
//
//    }
//
//    @IBAction func statisticsButton(_ sender: Any) {
//        DispatchQueue.main.async {
//            self.performSegue(withIdentifier: "statiSegue", sender: self)
//        }
//    }
    
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    
    
 

    
    
    
    
    @IBAction func signOut(_ sender: Any) {
        self.defaults.set(nil, forKey: "mail")
        self.defaults.set(nil, forKey: "pass")
        self.defaults.set(nil, forKey: "uData")
        self.dismiss(animated: true)
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    
}
extension MenuController:UITableViewDelegate,UITableViewDataSource
{
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: MenuCell = (tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell)
        cell.object = menuItems[indexPath.row]
        // advertID=cell.object?.id!
        //print(advertID!)
        if cell.object?.ID==0{
            self.dismiss(animated: true){
                self.defaults.set(nil, forKey: "mail")
                self.defaults.set(nil, forKey: "pass")
                self.defaults.set(nil, forKey: "uData")}
          
        }
        
        // print(cell.object?.name)
        //cell.delegate = self
        
        
        if cell.object?.ID==1{
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "profSegue", sender: self)
                        }
        }
        cell.reloadData()
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuCell = (tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell)
        do{
            // cell.imageView?.image = nil
            
            cell.object = menuItems[indexPath.row]
            
            
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
