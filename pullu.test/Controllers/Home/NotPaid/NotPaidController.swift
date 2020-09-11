//
//  PaidController.swift
//  pullu.test
//
//  Created by Rufat on 5/8/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class NotPaidController: UITableViewController {
    var loadingAlert:MBProgressHUD?
    var advertArray: [Advertisement] = [Advertisement]()
    let  select:DbSelect=DbSelect()
    var userToken:String?
    var requestToken:String?
    private let myRefreshControl = UIRefreshControl()
    @IBOutlet var notPaidTableView: UITableView!
    var paginationEnabled=false
    var loading = false
    var advertID:Int?
    var currentPage = 1
    public var catID:Int = 0
    let defaults = UserDefaults.standard
    let spinner = UIActivityIndicatorView(style: .gray)
    @IBOutlet weak var refreshCatButton: UIButton!
    @IBOutlet weak var catView: UIView!
    @IBOutlet weak var categoryScroll: UICollectionView!
    var catList:Array<CategoryStruct> = []
    var catObject:CategoryStruct?
    let refreshButton = UIButton()
    let warningLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.addWarningLabel()
            self.warningLabel.text = "Heç bir elan tapılmadı..."
            
            self.refreshCatButton.layer.cornerRadius = self.refreshCatButton.frame.height.self / 2.0
        }
        if catID>0{
            
            categoryScroll.isHidden = true
            
        }
        notPaidTableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        myRefreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        notPaidTableView.addSubview(myRefreshControl)
        let defaults = UserDefaults.standard
        
        refreshCat()
        refresh()
        
        
        
        //        if (view.window != nil) {
        //            refresh()
        //
        //        }
        //        do{
        //            sleep(4)
        //            refresh()
        //        }
    }
    @IBAction func refreshCategoriesBtnClick(_ sender: Any) {
        refreshCat()
        
    }
    
    
    
    private func addResultButtonView() {
        
        
        self.refreshButton.backgroundColor = .orange
        self.refreshButton.setTitle("Yenilə", for: .normal)
        
        self.notPaidTableView.addSubview(self.refreshButton)
        
        // set position
        self.refreshButton.translatesAutoresizingMaskIntoConstraints = false
        self.refreshButton.centerXAnchor.constraint(equalTo: self.notPaidTableView.centerXAnchor).isActive = true
        self.refreshButton.centerYAnchor.constraint(equalTo: self.notPaidTableView.centerYAnchor).isActive = true
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
    func refreshCat(){
        
        select.ACategory(){
            (list)
            in
            self.catList=list
            var catIndex=0
            for item in self.catList{
                
                Alamofire.request(item.catImage!).responseImage { response in
                    if let catPicture = response.result.value {
                        //advert.photo=catPicture.pngData()
                        item.downloadedIco = catPicture.pngData()
                        
                        print("image downloaded: \(item.downloadedIco)")
                        
                        // self.catList[item.id!-1]=item
                        //self.catList[catIndex]=item
                        // self.dataArray.replaceSubrange( , with: item)
                        catIndex+=1
                        if catIndex == self.catList.count {
                            self.catList.sort { $0.id! < $1.id! }
                            
                            
                        }
                        if self.catList.count>0{
                            DispatchQueue.main.async {
                                self.refreshCatButton?.isHidden=true
                                self.categoryScroll.reloadData()
                                self.refreshCatButton.isHidden=true
                            }
                        }
                        else
                        {
                            self.refreshCatButton?.isHidden=false
                        }
                    }
                    
                    
                    
                    
                }
                
            }
            //            self.catList.sort {
            //                $0.id! < $1.id!
            //            }
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return advertArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        advertID=advertArray[indexPath.row].id!
        
        if advertArray[indexPath.row].aTypeId==2{
            self.performSegue(withIdentifier: "photoReklamPage", sender: self)
            
        }
        if advertArray[indexPath.row].aTypeId==1{
            self.performSegue(withIdentifier: "textReklamPage", sender: self)
            
        }
        if advertArray[indexPath.row].aTypeId==3{
            self.performSegue(withIdentifier: "videoReklamPage", sender: self)
            
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = self.advertArray.count - 1
        if indexPath.row == lastItem {
            //print("IndexRow\(indexPath.row)")
            
            
            
            
            
            pagination(page: currentPage)
            //        if currentPage < totalPage {
            //            currentPage += 1
            //           //Get data from Server
            //        }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReklamCellTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ReklamCellTableViewCell)
        do{
            if loading == false  {
                // cell.imageView?.image = nil
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
            
            
            
        }
        catch
        {
            print(indexPath.row)
        }
        
        //cell.delegate = self
        //  cell.reloadData()
        //cell.object = dataArray[indexPath.row]
        //     cell.delegate = self
        
        
        // Configure the cell...
        
        return cell
    }
    private func addWarningLabel() {
        
        
        //self.notFoundLabel.backgroundColor = .orange
        // self.notFoundLabel.center = viewersTable.center
        
        self.notPaidTableView.addSubview(self.warningLabel)
        
        // set position
        self.warningLabel.translatesAutoresizingMaskIntoConstraints = false
        self.warningLabel.centerXAnchor.constraint(equalTo: self.notPaidTableView.centerXAnchor).isActive = true
        self.warningLabel.centerYAnchor.constraint(equalTo: self.notPaidTableView.centerYAnchor).isActive = true
        self.warningLabel.isHidden = true
        
        //       DispatchQueue.main.async {
        //              // self.notFoundLabel.layer.cornerRadius = self.notFoundLabel.frame.height.self / 2.0
        //        self.notFoundLabel.numberOfLines = 0
        //        self.notFoundLabel.lineBreakMode = .byWordWrapping
        //        self.notFoundLabel.adjustsFontSizeToFitWidth = true
        //              }
        //              self.notFoundLabel.clipsToBounds = true
        
    }
    func pagination(page:Int){
        
        
        
        
        if paginationEnabled{
            
            //                loading = true
            //                       var loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
            //                        loadingAlert.mode = MBProgressHUDMode.indeterminate
            //                        loadingAlert.label.text="Gözləyin"
            //                        loadingAlert.detailsLabel.text = "Reklamları yeniləyirik..."
            
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.notPaidTableView.tableFooterView = spinner
            self.notPaidTableView.tableFooterView?.isHidden = false
            
            var typeCount=0
            
            select.GetAds(isPaid: 0,page: page, catID: catID,progressView: loadingAlert!){
                
                (obj) in
                self.spinner.stopAnimating()
                self.notPaidTableView.tableFooterView = nil
                switch obj.status {
                case 1:
                    if obj.data.count>0 {
                        // self.defaults.set(obj.requestToken, forKey: "requestToken")
                        for advert in obj.data {
                            
                            //if (advert.isPaid==type) {
                            let item = advert
                            
                            
                            
                            self.advertArray.append(item)
                            
                            
                            
                            
                            
                            DispatchQueue.main.async {
                                self.warningLabel.isHidden = true
                                
                                //                            if self.isPaidSegment.selectedSegmentIndex == 0{
                                //                                self.advertArray = self.isPaid
                                //                                typeCount=self.isPaid.count
                                //                            }else {
                                //                                self.advertArray = self.isNotPaid
                                //                                typeCount=self.isNotPaid.count
                                //                            }
                                //
                                
                                
                                //self.ReklamCount.text="Reklam sayı \(String(typeCount))"
                                self.notPaidTableView.reloadData()
                                
                                self.myRefreshControl.endRefreshing()
                                
                                
                                
                                //
                                
                            }
                            
                            
                            
                        }
                        
                        self.currentPage += 1
                    }
                    else   {
                        self.warningLabel.isHidden = false
                        self.paginationEnabled = false
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
                        if obj.data.count>0 {
                            // self.defaults.set(obj.requestToken, forKey: "requestToken")
                            for advert in obj.data {
                                
                                //if (advert.isPaid==type) {
                                let item = advert
                                
                                
                                
                                self.advertArray.append(item)
                                
                                
                                
                                
                                
                                DispatchQueue.main.async {
                                    self.warningLabel.isHidden = true
                                    
                                    //                            if self.isPaidSegment.selectedSegmentIndex == 0{
                                    //                                self.advertArray = self.isPaid
                                    //                                typeCount=self.isPaid.count
                                    //                            }else {
                                    //                                self.advertArray = self.isNotPaid
                                    //                                typeCount=self.isNotPaid.count
                                    //                            }
                                    //
                                    
                                    
                                    //self.ReklamCount.text="Reklam sayı \(String(typeCount))"
                                    self.notPaidTableView.reloadData()
                                    
                                    self.myRefreshControl.endRefreshing()
                                    
                                    
                                    
                                    //
                                    
                                }
                                
                                
                                
                            }
                            
                            self.currentPage += 1
                        }
                        else   {
                            self.warningLabel.isHidden = false
                            self.paginationEnabled = false
                        }
                        
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
                
                
                
                
                
                
                
                //loadingAlert.hide(animated: true)
                self.loading = false
            }
        }
        
    }
    @objc func refresh() {
        
        // paginationEnabled = true
        loading = true
        advertArray.removeAll()
        loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingAlert!.mode = MBProgressHUDMode.indeterminate
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        // var typeCount=0
        
        
        select.GetAds(isPaid: 0,page: 1, catID: catID,progressView: loadingAlert!){
            
            (obj) in
            UIApplication.shared.endIgnoringInteractionEvents()
            self.myRefreshControl.endRefreshing()
            self.loading = false
            self.loadingAlert!.hide(animated: true)
            switch obj.status {
            case 1:
                
                if obj.data.count>0{
                    self.warningLabel.isHidden = true
                    //self.defaults.set(obj.requestToken, forKey: "requestToken")
                    //                    if obj.status != 3{
                    
                    
                    for advert in obj.data {
                        
                        //if (advert.isPaid==type) {
                        let item = advert
                        
                        
                        
                        self.advertArray.append(item)
                        
                        
                        
                        
                        
                        DispatchQueue.main.async {
                            
                            
                            //                            if self.isPaidSegment.selectedSegmentIndex == {
                            //                                self.advertArray = self.isPaid
                            //                                typeCount=self.isPaid.count
                            //                            }else {
                            //                                self.advertArray = self.isNotPaid
                            //                                typeCount=self.isNotPaid.count
                            //                            }
                            //
                            
                            
                            //self.ReklamCount.text="Reklam sayı \(String(typeCount))"
                            self.notPaidTableView.reloadData()
                            
                            self.myRefreshControl.endRefreshing()
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                    if self.advertArray.count>9 {
                        self.paginationEnabled = true
                    }
                    
                    //                        self.paginationEnabled = true
                    //                    }
                    //
                    //
                    //                    else {
                    ////                        self.myRefreshControl.endRefreshing()
                    ////                        self.loadingAlert!.hide(animated: true)
                    ////                        let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                    ////                        warningAlert.mode = MBProgressHUDMode.text
                    ////                        //            warningAlert.isSquare=true
                    ////                        warningAlert.label.text = "Xəta"
                    ////                        warningAlert.detailsLabel.text = "Zəhmət olmasa biraz sonra yenidən cəht edin"
                    ////                        warningAlert.hide(animated: true,afterDelay: 3)
                    //
                    //                    }
                }
                else
                {
                    
                    self.warningLabel.isHidden = false
                    
                    //                    let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                    //
                    //                    warningAlert.mode = MBProgressHUDMode.text
                    //                    //            warningAlert.isSquare=true
                    //                    warningAlert.label.text = "Bildiriş"
                    //                    warningAlert.detailsLabel.text = "Heç bir pulsuz reklam taapılmadı"
                    //                    warningAlert.hide(animated: true,afterDelay: 3)
                    
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
                    if obj.data.count>0 {
                        // self.defaults.set(obj.requestToken, forKey: "requestToken")
                        for advert in obj.data {
                            
                            //if (advert.isPaid==type) {
                            let item = advert
                            
                            
                            
                            self.advertArray.append(item)
                            
                            
                            
                            
                            
                            DispatchQueue.main.async {
                                self.warningLabel.isHidden = true
                                
                                //                            if self.isPaidSegment.selectedSegmentIndex == 0{
                                //                                self.advertArray = self.isPaid
                                //                                typeCount=self.isPaid.count
                                //                            }else {
                                //                                self.advertArray = self.isNotPaid
                                //                                typeCount=self.isNotPaid.count
                                //                            }
                                //
                                
                                
                                //self.ReklamCount.text="Reklam sayı \(String(typeCount))"
                                self.notPaidTableView.reloadData()
                                
                                self.myRefreshControl.endRefreshing()
                                
                                
                                
                                //
                                
                            }
                            
                            
                            
                        }
                        
                        self.currentPage += 1
                    }
                    else   {
                        self.warningLabel.isHidden = false
                        self.paginationEnabled = false
                    }
                    
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
        
        if(segue.identifier == "aCatSegue"){
            
            if let navController = segue.destination as? UINavigationController {
                
                if let chidVC = navController.topViewController as? CategoryViewController {
                    //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                    chidVC.object  = catObject
                    
                }
                
            }
            
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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

extension NotPaidController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // print(catList.count)
        return catList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = categoryScroll.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath) as! CategoryViewCell
        cell.object = catList[indexPath.row]
        // print(cell.object?.name)
        catObject=cell.object
        self.performSegue(withIdentifier: "aCatSegue", sender: self)
        
        cell.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryScroll.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath) as! CategoryViewCell
        
        
        cell.object=catList[indexPath.row]
        cell.reloadData()
        // print(catList[indexPath.row].name)
        
        return cell
        
        
    }
    
    
    
    
}

