//
//  HomePageController.swift
//  pullu.test
//
//  Created by Rufat Asadzade on 1/9/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MBProgressHUD
import FirebaseMessaging
import SJSegmentedScrollView
class HomePageController: UIViewController,UISearchBarDelegate{
    
    //  @IBOutlet weak var isPaidSegment: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    let defaults = UserDefaults.standard
    @IBOutlet weak var categoryScroll: UICollectionView!
    
    
    @IBOutlet weak var floatingLabel: UILabel!
    
    @IBOutlet weak var ReklamCount: UILabel!
    
    var advertArray: [Advertisement] = [Advertisement]()
    var isPaid: [Advertisement] = [Advertisement]()
    var isNotPaid: [Advertisement] = [Advertisement]()
    var advertID:Int?
   // var floatingLabel:UILabel?
    private let myRefreshControl = UIRefreshControl()
    let  db:DbSelect=DbSelect()
    var mail:String?
    var pass:String?
    var loadingIsOn = false
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    var loadingView: UIView = UIView()
    var loadingAlert:MBProgressHUD?
    var uInfo:Array<UserStruct> = []
    @IBOutlet weak var segmentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        //        let searchController = UISearchController(searchResultsController: nil)
        //               navigationItem.searchController = searchController
        //        searchController.searchBar.scopeButtonTitles = ["Bütün","Vip","Sadə"]
        
        //myRefreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        //ReklamList.addSubview(myRefreshControl)
        
        // searchController.searchBar.placeholder = "Axtar..."
        //searchController.obscuresBackgroundDuringPresentation = false
        // searchController.searchResultsUpdater = self
        //searchController.searchBar.searchBarStyle = .minimal
        
        if let storyboard = self.storyboard {
            
            let myViewController = storyboard
                .instantiateViewController(withIdentifier: "ads")
            //myViewController.title = "Pulsuz"
            
            
            //            let backgroundImage = UIImageView()
            //                       backgroundImage.frame.size.width = 100
            //                       backgroundImage.image = UIImage(named: "logout")
            //                       backgroundImage.contentMode = .scaleAspectFit
            //                       backgroundImage.backgroundColor = .white
            //                       myViewController.navigationItem.titleView = backgroundImage
            
//            let myShareController = storyboard
//                .instantiateViewController(withIdentifier: "paid")
//            myShareController.title = "Pullu"
            
            let segmentedViewController = SJSegmentedViewController(headerViewController: nil,
                                                                    segmentControllers: [myViewController
                                                                                         ])
//            segmentedViewController.segmentBackgroundColor = UIColor.white
//            segmentedViewController.segmentTitleColor = UIColor.black
            //            catView.layer.borderWidth = 1
            //            catView.layer.borderColor = UIColor.gray.cgColor
            
//            segmentedViewController.segmentTitleFont = UIFont.systemFont(ofSize: 18)
//            segmentedViewController.selectedSegmentViewColor = UIColor.black
//            segmentedViewController.selectedSegmentViewHeight = 3
//            segmentedViewController.segmentViewHeight = 40
//            segmentedViewController.headerViewHeight =  95
//
            addChild(segmentedViewController)
            segmentView.addSubview(segmentedViewController.view)
            segmentedViewController.view.frame = segmentView.bounds
            segmentedViewController.didMove(toParent: self)
            
        }
        
        
        
        navigationItem.hidesSearchBarWhenScrolling = false
        // searchController.searchBar.barTintColor = UIColor.white
        // searchController.searchBar.tintColor = UIColor.white
        //searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        //       let navigationitem = UINavigationItem(title: "")    //creates a new item with no title
        //        navigationitem.titleView = categoryScroll //your collectionview here to display as a view instead of the title that is usually there
        //        self.navigationController?.navigationBar.items = [navigationitem]
        
        //                navItem.hidesSearchBarWhenScrolling = true
        //                navItem.searchController = searchController
        //  navigationItem.searchController = searchController
        
        //        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //        navigationController?.navigationBar.shadowImage = UIImage()
        //        navigationController?.navigationBar.isTranslucent = true
        
        //onun ucun bax gosterim neynemek lazimdi
        
        // navigationItem.hidesBackButton = true;
        
        /*headerView.layer.backgroundColor = UIColor.white.cgColor
         
         headerView.layer.masksToBounds = false
         headerView.layer.shadowColor = UIColor.gray.cgColor
         headerView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
         headerView.layer.shadowOpacity = 1.0
         headerView.layer.shadowRadius = 0.0 */
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        //
        //        ReklamList.delegate = self
        //        ReklamList.dataSource = self
        
        
        
        //  self.getProducts()
        //        let defaults = UserDefaults.standard
        //
        //        Messaging.messaging().subscribe(toTopic: "\(defaults.string(forKey: "uID")!)"){ error in
        //            if error == nil{
        //                print("Subscribed to topic")
        //            }
        //            else{
        //                print("Not Subscribed to topic")
        //            }
        //        }
        //
        //        // let userData = defaults.string(forKey: "uData")
        //        mail = defaults.string(forKey: "mail")
        //        pass = defaults.string(forKey: "pass")
        // let udata=defaults.string(forKey: "uData")
        //print("\(mail)\n\(pass)\n\(udata)")
           
        
//        let udata=defaults.string(forKey: "uData")
//      
//        if udata != nil {
//            do{
//                      
//                      
//                      uInfo  = try
//                          JSONDecoder().decode(Array<UserStruct>.self, from: udata!.data(using: .utf8)!)
//                  }
//                  catch{
//                      
//                  }
//           // addFloatingLabel()
//            DispatchQueue.main.async {
//                self.floatingLabel?.text = "Balans: \(self.uInfo[0].balance!) AZN"
//                self.floatingLabel.layer.cornerRadius = self.floatingLabel!.frame.height.self / 1.0
//                self.floatingLabel.isHidden = false
//            }
//        }
//        else
//        {floatingLabel.isHidden = true}
                
        
    }
  

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(searchBar.text)")
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       if searchText == "" {
        let sQuery:[String: String] = ["searchQuery": searchBar.text!]
        
        // post a notification
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: sQuery)
          // print("UISearchBar.text cleared!")
       }
   }
    @IBAction func searchClicked(_ sender: Any) {
        let sQuery:[String: String] = ["searchQuery": searchBar.text!]
              
              // post a notification
              NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: sQuery)
    }
    
    @IBAction func menuClick(_ sender: Any) {
        self.performSegue(withIdentifier: "menuSeque", sender: self)
    }
    
    
    func addFloatingLabel(){
        floatingLabel = UILabel()
       floatingLabel?.frame = CGRect(x: 285, y: 485, width: 200, height: 15)
        floatingLabel?.backgroundColor = .orange
        floatingLabel!.layer.cornerRadius = floatingLabel!.frame.height.self / 2.0
        floatingLabel?.text = "Balans: \(uInfo[0].balance!) AZN"
        self.view.addSubview(floatingLabel!)
        
    }
    
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
            self.loadingAlert!.mode = MBProgressHUDMode.indeterminate
            self.loadingAlert?.show(animated: true)
            //            self.loadingView = UIView()
            //            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            //            self.loadingView.center = self.view.center
            //            self.loadingView.backgroundColor = UIColor.black
            //            self.loadingView.alpha = 0.7
            //            self.loadingView.clipsToBounds = true
            //            self.loadingView.layer.cornerRadius = 10
            //
            //            self.spinner = UIActivityIndicatorView(style: .whiteLarge)
            //            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            //            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            //
            //            self.loadingView.addSubview(self.spinner)
            //            self.view.addSubview(self.loadingView)
            //            self.spinner.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingAlert?.hide(animated: true)
            //            self.spinner.stopAnimating()
            //            self.loadingView.removeFromSuperview()
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //refresh()
        //            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //            navigationController?.navigationBar.shadowImage = UIImage()
        //            navigationController?.navigationBar.isTranslucent = true
        //            navigationController?.view.backgroundColor = .clear
        //            super.viewWillAppear(animated)
    }
    
    //    override func viewWillDisappear(_ animated: Bool) {
    //        navigationController?.navigationBar.isTranslucent = false
    //        navigationController?.view.backgroundColor = .blue
    //        super.viewWillDisappear(animated)
    //    }
    
    
    
    
    
    
    //    @IBAction func isPaidChanged(_ sender: Any) {
    //        self.advertArray.removeAll()
    //
    //        if (!ReklamList.isTracking && !ReklamList.isDecelerating) {
    //            if isPaidSegment.selectedSegmentIndex == 0{
    //                if  isPaid != nil{
    //                    advertArray = isPaid
    //                    DispatchQueue.main.async {
    //                        self.ReklamCount.text="Reklam sayı \(String(self.advertArray.count))"
    //
    //                        self.ReklamList.reloadData()
    //
    //
    //                    }
    //                }
    //                // Table was scrolled by user.
    //                //                if dataArray.count>0{
    //                //
    //                //                    for item in dataArray{
    //                //                        if item.isPaid==1{
    //                //
    //                //                            advertArray.append(item)
    //                //                        }
    //                //
    //                //                    }
    //                //
    //                //                    DispatchQueue.main.async {
    //                //                        self.ReklamCount.text="Reklam sayı \(String(self.advertArray.count))"
    //                //                        self.ReklamList.reloadData()
    //                //
    //                //
    //                //                    }
    //                //
    //                //                }
    //            }
    //
    //            if isPaidSegment.selectedSegmentIndex==1{
    //                if  isNotPaid != nil{
    //                    advertArray = isNotPaid
    //                    DispatchQueue.main.async {
    //                        self.ReklamCount.text="Reklam sayı \(String(self.advertArray.count))"
    //
    //                        self.ReklamList.reloadData()
    //
    //
    //                    }
    //                }
    //
    //                // Table was scrolled by user.
    //                //                if dataArray.count>0{
    //                //                    for item in dataArray{
    //                //                        if item.isPaid==0{
    //                //
    //                //                            advertArray.append(item)
    //                //                        }
    //                //
    //                //                    }
    //                //                    DispatchQueue.main.async {
    //                //                        self.ReklamCount.text="Reklam sayı \(String(self.advertArray.count))"
    //                //
    //                //                        self.ReklamList.reloadData()
    //                //
    //                //
    //                //                    }
    //                //                }
    //            }
    //
    //        }
    //        else  {
    //
    //            if isPaidSegment.selectedSegmentIndex == 0{
    //
    //                isPaidSegment.selectedSegmentIndex = 1
    //
    //            }
    //            if isPaidSegment.selectedSegmentIndex == 1{isPaidSegment.selectedSegmentIndex = 0}
    //
    //        }
    //
    //
    //
    //
    //
    //
    //    }
    
    
    
    
    //    @objc func refresh() {
    //
    //        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
    //               loadingAlert!.mode = MBProgressHUDMode.indeterminate
    //               loadingAlert!.label.text="Gözləyin"
    //               loadingAlert!.detailsLabel.text = "Reklamları yeniləyirik..."
    //
    //        isPaid.removeAll()
    //        isNotPaid.removeAll()
    //        if mail != nil&&pass != nil{
    //            var typeCount=0
    //
    //            db.getAds(username: mail!, pass: pass!, catID: 0,progressView: loadingAlert!){
    //
    //                (list) in
    //
    //
    //
    //
    //                for advert in list {
    //
    //                    //if (advert.isPaid==type) {
    //                    let item = advert
    //
    //
    //
    //                    if  item.isPaid==1{
    //
    //
    //                        // self.advertArray.append(item)
    //                        self.isPaid.append(item)
    //
    //
    //
    //                    }
    //                    if  item.isPaid==0{
    //
    //
    //                        // self.advertArray.append(item)
    //                        self.isNotPaid.append(item)
    //
    //
    //
    //                    }
    //
    //
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
    //                                                self.loadingAlert!.hide(animated: true)
    //
    //                        //
    //
    //                    }
    //
    //
    //
    //                }
    //
    //
    //
    //
    //            }
    //        }
    //
    //    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}

func cancelSpecificTask(byUrl url:URL) {
    Alamofire.SessionManager.default.session.getAllTasks{sessionTasks in
        for task in sessionTasks {
            if task.originalRequest?.url == url {
                task.cancel()
            }
        }
        
    }
}


//extension HomePageController:UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating
//{
//
//
//
//    func updateSearchResults(for searchController: UISearchController) {
//        //searchbara her defe nese yazanda bu functionu edir
//        //menlik bir qullugun tapshirigin?))
//        //ishledemmedin?
//        //be bu niye itmir??
//        //kele sarimisane deyesen))
//        print("blablabla")
//    }
//
//
//
//
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
//
//
//
//    // MARK: - Table view data source
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return advertArray.count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: ReklamCellTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ReklamCellTableViewCell)
//        do{
//            // cell.imageView?.image = nil
//            if advertArray[indexPath.row].photo == nil{
//                Alamofire.request((advertArray[indexPath.row].photoUrl![0])).responseImage { response in
//                    if let catPicture = response.result.value {
//                        //advert.photo=catPicture.pngData()
//
//                        //  item.photo = UIImage(named: "damaged")?.pngData()
//                        if indexPath.row <= self.advertArray.count {
//
//                            if catPicture != nil {
//
//                                self.advertArray[indexPath.row].photo=catPicture.pngData()!
//
//
//                            }
//                            else {
//                                self.advertArray[indexPath.row].photo=UIImage(named: "damaged")?.pngData()
//
//                            }
//
//                             self.advertArray[indexPath.row].downloaded=true
//
//
//                            // dataArray[dowloadedCount]=item
//
//
//                            cell.object = self.advertArray[indexPath.row]
//                        }
//
//
//                        cell.reloadData()
//                    }
//
//
//
//                }
//            }
//            cell.object = advertArray[indexPath.row]
//
//
//        }
//        catch
//        {
//            print(indexPath.row)
//        }
//
//        //cell.delegate = self
//        cell.reloadData()
//        //cell.object = dataArray[indexPath.row]
//        //     cell.delegate = self
//
//
//        // Configure the cell...
//
//        return cell
//    }
//
//
//    /*
//     // Override to support conditional editing of the table view.
//     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//     // Return false if you do not want the specified item to be editable.
//     return true
//     }
//     */
//
//    /*
//     // Override to support editing the table view.
//     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//     if editingStyle == .delete {
//     // Delete the row from the data source
//     tableView.deleteRows(at: [indexPath], with: .fade)
//     } else if editingStyle == .insert {
//     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//     }
//     }
//     */
//
//    /*
//     // Override to support rearranging the table view.
//     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//     }
//     */
//
//    /*
//     // Override to support conditional rearranging of the table view.
//     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//     // Return false if you do not want the item to be re-orderable.
//     return true
//     }
//     */
//
//
//
//
//
//}


