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
import AVKit
class PaidController: UITableViewController {
    var loadingAlert:MBProgressHUD = MBProgressHUD()
    var advertArray: [Advertisement] = [Advertisement]()
    let  select:DbSelect=DbSelect()
    var userToken:String?
    var requestToken:String?
    
    @IBOutlet var paidTableView: UITableView!
    var paginationEnabled=false
    var loading = false
    var advertID:Int?
    var currentPage = 1
    var catID = 0
    let defaults = UserDefaults.standard
    private let myRefreshControl = UIRefreshControl()
    let spinner = UIActivityIndicatorView(style: .gray)
    var home:HomePageController = HomePageController()
    var catList:Array<CategoryStruct> = []
    var catObject:CategoryStruct?
    @IBOutlet weak var categoryScroll: UICollectionView!
    @IBOutlet weak var refreshCatButton: UIButton!
    let warningLabel = UILabel()
    let refreshButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addWarningLabel()
        warningLabel.text = "Heç bir elan tapılmadı..."
        DispatchQueue.main.async {
            
            self.refreshCatButton.layer.cornerRadius = self.refreshCatButton.frame.height.self / 2.0
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if catID>0{
            
            categoryScroll.isHidden = true
            
        }
        
        paidTableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        myRefreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        paidTableView.addSubview(myRefreshControl)
        
        userToken = defaults.string(forKey: "userToken")
        requestToken = defaults.string(forKey: "requestToken")
        refreshCat()
        addResultButtonView()
        //        select.SignIn(mail: mail!, pass: pass!){
        //            (user)
        //            in
        //            if !user.isEmpty{
        //                self.refresh()
        //            }
        //            else{
        //
        //                self.dismiss(animated: true)
        //            }
        //
        //
        //
        //        }
        
    }
    
    @IBAction func refreshCategoriesBtnClick(_ sender: Any) {
        refreshCat()
        
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReklamCellTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ReklamCellTableViewCell)
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
        return cell
    }
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    private func createVideoThumbnail(from url: URL) -> UIImage? {
        
        let asset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        // assetImgGenerate.maximumSize = CGSize(width: self.frame.width, height: frame.height)
        
        let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    private func addResultButtonView() {
        
        
        self.refreshButton.backgroundColor = .orange
        self.refreshButton.setTitle("Yenilə", for: .normal)
        
        self.paidTableView.addSubview(self.refreshButton)
        
        // set position
        self.refreshButton.translatesAutoresizingMaskIntoConstraints = false
        self.refreshButton.centerXAnchor.constraint(equalTo: self.paidTableView.centerXAnchor).isActive = true
        self.refreshButton.centerYAnchor.constraint(equalTo: self.paidTableView.centerYAnchor).isActive = true
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
    func pagination(page:Int){
        
        
        
        
        if paginationEnabled{
            //                loading = true
            //                       var loadingAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
            //                        loadingAlert.mode = MBProgressHUDMode.indeterminate
            //                        loadingAlert.label.text="Gözləyin"
            //                        loadingAlert.detailsLabel.text = "Reklamları yeniləyirik..."
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.paidTableView.tableFooterView = spinner
            self.paidTableView.tableFooterView?.isHidden = false
            var typeCount=0
            
            select.GetAds(isPaid: 0,page: page, catID: catID,progressView: loadingAlert){
                
                (obj) in
                self.spinner.stopAnimating()
                self.paidTableView.tableFooterView = nil
                switch obj.status {
                case 1:
                    if obj.data.count>0 {
                        //self.defaults.set(obj.requestToken, forKey: "requestToken")
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
                                self.paidTableView.reloadData()
                                
                                self.myRefreshControl.endRefreshing()
                                
                                
                                
                                //
                                
                            }
                            
                            
                            
                        }
                        
                        self.currentPage += 1
                    }
                    else   { DispatchQueue.main.async {
                        self.warningLabel.isHidden = false
                        }
                        
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
                    let alert = UIAlertController(title: "Diqqət!", message: "PULLU elanlara baxmaq üçün, qeydiyyatdan keçməniz vacibdir", preferredStyle: UIAlertController.Style.alert)
                              
                              alert.addAction(UIAlertAction(title: "Qeydiyyat", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                                  self.defaults.set(nil, forKey: "userToken")
                                  self.defaults.set(nil, forKey: "requestToken")
                                  self.defaults.set(nil, forKey: "uData")
                                  let menu:MenuController = MenuController()
                                  menu.updateRootVC(status: false)
                              }))
                              self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                    
                    break
                default:
                    let alert = UIAlertController(title: "Xəta", message: "Zəhmət olmasa biraz sonra yenidən cəhd edin", preferredStyle: UIAlertController.Style.alert)
                    
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
    
    private func addWarningLabel() {
        
        
        //self.notFoundLabel.backgroundColor = .orange
        // self.notFoundLabel.center = viewersTable.center
        
        self.paidTableView.addSubview(self.warningLabel)
        
        // set position
        self.warningLabel.translatesAutoresizingMaskIntoConstraints = false
        self.warningLabel.centerXAnchor.constraint(equalTo: self.paidTableView.centerXAnchor).isActive = true
        self.warningLabel.centerYAnchor.constraint(equalTo: self.paidTableView.centerYAnchor).isActive = true
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
        
        
        
        //  paginationEnabled = true
        loading = true
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        self.myRefreshControl.beginRefreshing()
        var typeCount=0
        
        select.GetAds(isPaid: 1,page: 1, catID: catID,progressView: loadingAlert){
            
            (obj) in
            UIApplication.shared.endIgnoringInteractionEvents()
            self.myRefreshControl.endRefreshing()
            self.loading = false
            switch obj.status {
            case 1:
                
                if obj.data.count>0{
                    self.warningLabel.isHidden = true
                    
                    self.advertArray.removeAll()
                    
                    for advert in obj.data {
                        
                        //if (advert.isPaid==type) {
                        let item = advert
                        
                        
                        
                        self.advertArray.append(item)
                        
                        
                        
                        
                        
                        DispatchQueue.main.async {
                            
                            
                            //                            if self.isPaidSegment.selectedSegmentIndex == 0{
                            //                                self.advertArray = self.isPaid
                            //                                typeCount=self.isPaid.count
                            //                            }else {
                            //                                self.advertArray = self.isNotPaid
                            //                                typeCount=self.isNotPaid.count
                            //                            }
                            //
                            
                            
                            //self.ReklamCount.text="Reklam sayı \(String(typeCount))"
                            //  self.loadingAlert!.hide(animated: true)
                            self.myRefreshControl.endRefreshing()
                            self.paidTableView.reloadData()
                            
                            
                        }
                        
                        
                        
                    }
                    
                    
                    if self.advertArray.count>9 {
                        self.paginationEnabled = true
                    }
                    
                    
                    
                    
                    
                    
                    //
                    
                    
                    
                }
                else  {
                    
                    self.warningLabel.isHidden = false
                    //                    // self.loadingAlert!.hide(animated: true)
                    //                    let warningAlert = MBProgressHUD.showAdded(to: self.view, animated: true)
                    //                    warningAlert.mode = MBProgressHUDMode.text
                    //                    //            warningAlert.isSquare=true
                    //                    warningAlert.label.text = "Bildiriş"
                    //                    warningAlert.detailsLabel.text = "Heç bir pullu reklam taapılmadı"
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
                 
                    let alert = UIAlertController(title: "Diqqət!", message: "PULLU elanlara baxmaq üçün, qeydiyyatdan keçməniz vacibdir", preferredStyle: UIAlertController.Style.alert)
                                                
                                                alert.addAction(UIAlertAction(title: "Qeydiyyat", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                                                    self.defaults.set(nil, forKey: "userToken")
                                                    self.defaults.set(nil, forKey: "requestToken")
                                                    self.defaults.set(nil, forKey: "uData")
                                                    let menu:MenuController = MenuController()
                                                    menu.updateRootVC(status: false)
                                                }))
                                                self.present(alert, animated: true, completion: nil)
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
    
    override func viewWillAppear(_ animated: Bool) {
        userToken = defaults.string(forKey: "userToken")
        requestToken = defaults.string(forKey: "requestToken")
        if  (defaults.string(forKey: "aID") != nil) {
            refresh()
        }
        
        //            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //            navigationController?.navigationBar.shadowImage = UIImage()
        //            navigationController?.navigationBar.isTranslucent = true
        //            navigationController?.view.backgroundColor = .clear
        //            super.viewWillAppear(animated)
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


extension PaidController:UICollectionViewDelegate,UICollectionViewDataSource{
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
