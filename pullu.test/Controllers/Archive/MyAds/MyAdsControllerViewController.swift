//
//  MyAdsControllerViewController.swift
//  pullu.test
//
//  Created by Rufat on 5/8/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

//Delegate help : https://stackoverflow.com/a/39585749
import UIKit
import Alamofire
import MBProgressHUD
class MyAdsController: UIViewController,ReklamCellDelegate{
    func showViewersClick(cell: ReklamCellTableViewCell) {
        let indexPath = self.aTableView.indexPath(for: cell)
        advertID = advertArray[indexPath!.row].id
        performSegue(withIdentifier: "myAdViewersSegue", sender: self)
              // print(indexPath!.row)
    }
    
    var advertArray: [Advertisement] = [Advertisement]()
     var ad: Advertisement = Advertisement()
    var advertID:Int?
    var loadingAlert:MBProgressHUD?
    var  usertoken:String?
    var  requesttoken:String?
    var select:DbSelect=DbSelect()
   let defaults = UserDefaults.standard
     private let myRefreshControl = UIRefreshControl()
    @IBOutlet weak var aTableView: UITableView!
   let refreshButton =  UIButton()
    let warningLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        myRefreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
              aTableView.addSubview(myRefreshControl)
        addResultButtonView()
        addWarningLabel()
          warningLabel.text = "Heç bir elan tapılmadı..."
        // Do any additional setup after loading the view.
       
        
       // let defaults = UserDefaults.standard
                   
        
        // let userData = defaults.string(forKey: "uData")
     
    }
    private func addResultButtonView() {
            

        self.refreshButton.backgroundColor = .orange
        self.refreshButton.setTitle("Yenilə", for: .normal)
        
        self.aTableView.addSubview(self.refreshButton)

            // set position
        self.refreshButton.translatesAutoresizingMaskIntoConstraints = false
        self.refreshButton.centerXAnchor.constraint(equalTo: self.aTableView.centerXAnchor).isActive = true
        self.refreshButton.centerYAnchor.constraint(equalTo: self.aTableView.centerYAnchor).isActive = true
    //          resultButton.topAnchor.constraint(equalTo: notPaidTableView.safeAreaLayoutGuide.topAnchor).isActive = true
    //        resultButton.leftAnchor.constraint(equalTo: notPaidTableView.safeAreaLayoutGuide.leftAnchor).isActive = true
    //        resultButton.rightAnchor.constraint(equalTo: notPaidTableView.safeAreaLayoutGuide.rightAnchor).isActive = true
    //        resultButton.bottomAnchor.constraint(equalTo: notPaidTableView.safeAreaLayoutGuide.bottomAnchor).isActive = true
    //        resultButton.widthAnchor.constraint(equalTo: notPaidTableView.safeAreaLayoutGuide.widthAnchor).isActive = true
        self.refreshButton.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.refreshButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        self.refreshButton.heightAnchor.constraint(equalToConstant: 50).isActive = true // specify the height of the view
       DispatchQueue.main.async {
               self.refreshButton.layer.cornerRadius = self.refreshButton.frame.height.self / 2.0
              }
              self.refreshButton.clipsToBounds = true
            
        }
        @objc func buttonAction(sender: UIButton!) {
            refresh()
            refreshButton.isHidden = true
           //print("Button tapped")
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
        
//        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
//        loadingAlert!.mode = MBProgressHUDMode.indeterminate
       
         UIApplication.shared.beginIgnoringInteractionEvents()
        
         self.myRefreshControl.beginRefreshing()
          //  var typeCount=0
            advertArray.removeAll()
            select.GetMyAds(){
                
                (obj) in
                 UIApplication.shared.endIgnoringInteractionEvents()
                switch obj.status{
                case 1:
                    if obj.data.count>0
                    {
                     for advert in obj.data {
                                        
                                        //if (advert.isPaid==type) {
                        self.warningLabel.isHidden = true
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
                                                    let alert = UIAlertController(title: "Sessiyanız başa çatıb", message: "Zəhmət olmasa yenidən giriş edin", preferredStyle: UIAlertController.Style.alert)
                                                                                                                           
                                                                                                                           alert.addAction(UIAlertAction(title: "Giriş et", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                                                                                                                             self.defaults.set(nil, forKey: "userToken")
                                                                                                                               self.defaults.set(nil, forKey: "requestToken")
                                                                                                                               self.defaults.set(nil, forKey: "uData")
                                                                                                                            let menu:MenuController = MenuController()
                                                                                                                               menu.updateRootVC(status: false)

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
                
                
                
               
                
                 //self.loadingAlert!.hide(animated: true)
                self.myRefreshControl.endRefreshing()
                self.aTableView.reloadData()
                
                
            }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
                
     
             // refresh()
        
        
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
            if(segue.identifier == "editSegue"){
                let displayVC = segue.destination as! EditAd
                displayVC.ad = ad
              
            }
       
        if(segue.identifier == "myAdViewersSegue"){
            let displayVC = segue.destination as! MyViewers
            displayVC.aID = advertID
          
        }
    }
//        if(segue.identifier == "photoReklamPage"){
//            let displayVC = segue.destination as! AboutAdvertController
//            displayVC.advertID = advertID
//        }
//        if(segue.identifier == "textReklamPage"){
//            let displayVC = segue.destination as! TextReklamController
//            displayVC.advertID = advertID
//        }
//        if(segue.identifier == "videoReklamPage"){
//            let displayVC = segue.destination as! VideoReklamController
//            displayVC.advertID = advertID
//        }
//        if(segue.identifier == "aCatSegue"){
//            let displayVC = segue.destination as! CategoryViewController
//            displayVC.object = catObject
//        }
//
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
    

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

}
extension MyAdsController:UITableViewDelegate,UITableViewDataSource
{
    
    
    
//    func updateSearchResults(for searchController: UISearchController) {
//        //searchbara her defe nese yazanda bu functionu edir
//        //menlik bir qullugun tapshirigin?))
//        //ishledemmedin?
//        //be bu niye itmir??
//        //kele sarimisane deyesen))
//        print("blablabla")
//    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell: ReklamCellTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ReklamCellTableViewCell)
//        cell.object = advertArray[indexPath.row]
//        advertID=cell.object?.id!
ad = advertArray[indexPath.row]
              
          self.performSegue(withIdentifier: "editSegue", sender: self)
       
        //print(advertID!)
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
        //print(cell.object?.name)
        //cell.delegate = self
        //cell.reloadData()
        
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
        cell.delegate = self
        
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
