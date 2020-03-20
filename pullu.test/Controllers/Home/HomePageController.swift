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

class HomePageController: UIViewController{
    
    @IBOutlet weak var isPaidSegment: UISegmentedControl!
    
  
    @IBOutlet weak var categoryScroll: UICollectionView!
    var dataArray: [Advertisement] = [Advertisement]()
    @IBOutlet var ReklamList: UITableView!
    
    @IBOutlet weak var ReklamCount: UILabel!
    
    @IBOutlet weak var srchBar: UISearchBar!
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var headerView: UIView!
    var advertArray: [Advertisement] = [Advertisement]()
    var advertID:Int?
    var catList:Array<CategoryStruct> = []
    override func viewDidLoad() {
        super.viewDidLoad()
//title yoxdu belke?
        //gormedin yazdimda elimnen blablablaaaaaaaa
        //icine pox neter duzeldime bu xiyari
            searchController.searchBar.placeholder = "Search..."
         searchController.obscuresBackgroundDuringPresentation = false
         searchController.searchResultsUpdater = self
         searchController.searchBar.searchBarStyle = .minimal
        // searchController.searchBar.barTintColor = UIColor.white
        // searchController.searchBar.tintColor = UIColor.white
        //searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        //navigationItem.hidesSearchBarWhenScrolling = false
        navItem.hidesSearchBarWhenScrolling = true
        navItem.searchController = searchController
        //navigationItem.searchController = searchController
        
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//mans senin bu kodun title gostermire basha dushursen?
        
        //sen hide eliyirsen navigation bari?
        //yox sen eledin hammisini ag
            //ne eledinki?
        //kele navigtaion itemnen sohbet gedir. men viewda olanlari hide elemishem ama sende umumiyyetce navbar yoxdu
        
        
        
        //he ozum elemishem qesten
        //o kod var ha bax o goturub atir navbarin icine. navbar gorsenmeyene qeder searchbar gorsenmeyecek
        //gozde
        
        //bu adi viewcontrollerdiye mene lazimdiki ele eliende cixsin kategoriyalarnan search
        //mans bu kodda konkret qemor olacaq. men dedim belke adi table viewdu.
      //tamam indi men nece qoshum table view a
        //senin indi searchbarin ishleyir?
        //funksional yox
        //mans onu qosh birde
        //mans bular bir birine bagli deyile. gozle gorum ne fikirleshmek olur. search bar axtarish eliye bilmesi ucun gerek kornevoy classa seach bari qoshmaq olsun. gorursen searchbar qoshmaq isteyende error verir cunki view controllerde seachluq hecne yoxxduama bele baxanda mence  ola
    
        
        //search elemek ucun goturub search bari search bar in methodunun icinde axtarish elemek olar. mans exten
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
        ReklamList.delegate = self
        ReklamList.dataSource = self
        
        
        
        //  self.getProducts()
        let defaults = UserDefaults.standard
        
        // let userData = defaults.string(forKey: "uData")
        let mail = defaults.string(forKey: "mail")
        let pass = defaults.string(forKey: "pass")
        // let udata=defaults.string(forKey: "uData")
        //print("\(mail)\n\(pass)\n\(udata)")
        let  db:dbSelect=dbSelect()
        db.aCategory(){
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
                        DispatchQueue.main.async {
                            self.categoryScroll.reloadData()
                            
                        }
                        
                    }
                    
                    
                    //print("\(self.dataArray.count) \n list count: \(typeCount)")
                    
                    
                    
                    
                    
                    
                    
                    //                    DispatchQueue.main.async {
                    //
                    //
                    //                        self.categoryScroll.reloadData()
                    //
                    //
                    //                    }
                    
                    // DispatchQueue.main.async {
                    
                    
                    //   self.ReklamList.reloadData()
                    
                    
                    // }
                    
                }
                
            }
            //            self.catList.sort {
            //                $0.id! < $1.id!
            //            }
            
        }
        
        
        db.getAds(username: mail!, pass: pass!){
            
            (list) in
            
            var adsWithImage: [Advertisement] = [Advertisement]()
            var k=0
            var i:Int?
            for advert in list {
                
                var typeCount = 0
                for itm in list{
                    if itm.isPaid==1{
                        typeCount += 1
                    }
                }
                
                //if (advert.isPaid==type) {
                var item = advert
                
                //item.photo = UIImage(named: "loading")?.pngData()// Loading photosu lazimdi
                self.dataArray.append(item)
                if  item.isPaid==1{
                    i=0
                    self.advertArray.append(item)
                }
                
                // let item_index = self.dataArray.endIndex
                //  element += 1
                
                Alamofire.request(advert.photoUrl![0]).responseImage { response in
                    if let catPicture = response.result.value {
                        //advert.photo=catPicture.pngData()
                        item.photo = catPicture.pngData()
                        
                        //   print("image downloaded: \(item.photo)")
                        
                        self.dataArray[k]=item
                        if  self.dataArray[k].isPaid==1{
                            self.advertArray[i!]=item
                            i!+=1
                        }
                        // self.dataArray.replaceSubrange( , with: item)
                        k+=1
                        if k == self.dataArray.count {
                            self.dataArray.sorted(by: { $0.cDate! < $1.cDate!})
                            //self.dataArray.sort { $0.cDate! > $1.cDate! }
                        }
                        DispatchQueue.main.async {
                            
                            self.ReklamCount.text="Reklam sayı \(String(typeCount))"
                            self.ReklamList.reloadData()
                            
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                    //print("\(self.dataArray.count) \n list count: \(typeCount)")
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    // DispatchQueue.main.async {
                    
                    
                    //   self.ReklamList.reloadData()
                    
                    
                    // }
                    
                }
                
                
                
                
                
                
                //  }
                /*         DispatchQueue.main.async {
                 
                 
                 //  self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                 //self.tableView.reloadData()
                 self.ReklamList.reloadData()
                 // self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
                 self.ReklamCount.text = String(typeCount)+" yeni reklam"
                 //  self.tableView.rel§oadData()
                 /* self.dismiss(animated: false){
                 
                 
                 
                 
                 
                 }*/
                 
                 }
                 */
                
                //bunu cixardir melumatlar gelir yani- print(advert.name)
            }
            
            
            
            
        }
        
        
        
    }
    

    
    
    

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        super.viewWillAppear(animated)
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.view.backgroundColor = .blue
//        super.viewWillDisappear(animated)
//    }
    
    @IBAction func isPaidChanged(_ sender: Any) {
        
        if (!ReklamList.isTracking && !ReklamList.isDecelerating) {
            if isPaidSegment.selectedSegmentIndex == 0{
                self.advertArray.removeAll()
                // Table was scrolled by user.
                if dataArray.count>0{
                    
                    for item in dataArray{
                        if item.isPaid==1{
                            
                            advertArray.append(item)
                        }
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.ReklamCount.text="Reklam sayı \(String(self.advertArray.count))"
                        self.ReklamList.reloadData()
                        
                        
                    }
                    
                }
            }
            
            if isPaidSegment.selectedSegmentIndex==1{
                
                self.advertArray.removeAll()
                // Table was scrolled by user.
                if dataArray.count>0{
                    for item in dataArray{
                        if item.isPaid==0{
                            
                            advertArray.append(item)
                        }
                        
                    }
                    DispatchQueue.main.async {
                        self.ReklamCount.text="Reklam sayı \(String(self.advertArray.count))"
                        
                        self.ReklamList.reloadData()
                        
                        
                    }
                }
            }
            
        }
        else  {
            
            if isPaidSegment.selectedSegmentIndex == 0{
                
                isPaidSegment.selectedSegmentIndex = 1
                
            }
              if isPaidSegment.selectedSegmentIndex == 1{isPaidSegment.selectedSegmentIndex = 0}
            
        }
        
        
        
        
        
        
    }
    
    
    
    /*   private func getProducts(completionBlock: @escaping (_ result:Array<Advertisement>) ->()) {
     
     /* DispatchQueue.main.async {
     
     let alert = UIAlertController(title: nil, message: "Yüklənir...", preferredStyle: .alert)
     
     let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
     loadingIndicator.hidesWhenStopped = true
     loadingIndicator.style = UIActivityIndicatorView.Style.gray
     loadingIndicator.startAnimating();
     
     alert.view.addSubview(loadingIndicator)
     self.present(alert, animated: true, completion: nil)
     }
     
     */
     let defaults = UserDefaults.standard
     
     // let userData = defaults.string(forKey: "uData")
     let mail = defaults.string(forKey: "mail")
     let pass = defaults.string(forKey: "pass")
     let udata=defaults.string(forKey: "uData")
     //print("\(mail)\n\(pass)\n\(udata)")
     let  db:dbSelect=dbSelect()
     db.getAds(username: mail!, pass: pass!){
     
     (list) in
     
     var adsWithImage: [Advertisement] = [Advertisement]()
     var k=0
     for advert in list {
     
     var typeCount = 0
     /*  for itm in list{
     if itm.isPaid==type{
     typeCount += 1
     }
     } */
     
     //if (advert.isPaid==type) {
     var item = advert
     
     //item.photo = UIImage(named: "loading")?.pngData()// Loading photosu lazimdi
     self.dataArray.append(item)
     
     
     // let item_index = self.dataArray.endIndex
     //  element += 1
     
     Alamofire.request(advert.photoUrl![0]).responseImage { response in
     if let catPicture = response.result.value {
     //advert.photo=catPicture.pngData()
     item.photo = catPicture.pngData()
     
     print("image downloaded: \(item.photo)")
     
     //self.dataArray[element].photo=catPicture.pngData()
     //print(self.dataArray[dataArray.count-1].photo)
     
     }
     
     self.dataArray[k]=item
     // self.dataArray.replaceSubrange( , with: item)
     k+=1
     //adsWithImage.append(item)
     //self.dataArray.append(item)
     print("\(self.dataArray.count) \n list count: \(typeCount)")
     
     DispatchQueue.main.async {
     
     //  self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
     //self.tableView.reloadData()
     self.ReklamList.reloadData()
     // self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
     
     // self.ReklamCount.text = String(typeCount)+" yeni reklam"
     
     }
     /* if adsWithImage.count == typeCount{
     self.dataArray.removeAll()
     self.dataArray=adsWithImage
     
     DispatchQueue.main.async {
     
     //  self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
     //self.tableView.reloadData()
     self.ReklamList.reloadData()
     // self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
     
     // self.ReklamCount.text = String(typeCount)+" yeni reklam"
     
     }
     }
     */
     }
     
     
     
     
     
     
     //  }
     DispatchQueue.main.async {
     
     
     //  self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
     //self.tableView.reloadData()
     self.ReklamList.reloadData()
     // self.ReklamCount.text = String(self.dataArray.count)+" yeni reklam"
     self.ReklamCount.text = String(typeCount)+" yeni reklam"
     //  self.tableView.rel§oadData()
     /* self.dismiss(animated: false){
     
     
     
     
     
     }*/
     
     }
     
     //bunu cixardir melumatlar gelir yani- print(advert.name)
     }
     
     
     
     
     }
     
     
     }*/
    
}
extension HomePageController:UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        //searchbara her defe nese yazanda bu functionu edir
        //menlik bir qullugun tapshirigin?))
        //ishledemmedin?
    //be bu niye itmir??
        //kele sarimisane deyesen))
        print("blablabla")
    }

    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: ReklamCellTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ReklamCellTableViewCell)
        cell.object = advertArray[indexPath.row]
        advertID=cell.object?.id!
        //print(advertID!)
        if cell.object?.aTypeId==2{
            self.performSegue(withIdentifier: "photoReklamPage", sender: self)
            
        }
        if cell.object?.aTypeId==1{
            self.performSegue(withIdentifier: "textReklamPage", sender: self)
            
        }
        if cell.object?.aTypeId==3{
            self.performSegue(withIdentifier: "videoReklamPage", sender: self)
            
        }
        //print(cell.object?.name)
        //cell.delegate = self
        cell.reloadData()
        
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
            cell.object = advertArray[indexPath.row]
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
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "photoReklamPage"){
            let displayVC = segue.destination as! AboutAdvertController
            displayVC.advertID = advertID
        }
        if(segue.identifier == "textReklamPage"){
            let displayVC = segue.destination as! TextReklamController
            displayVC.advertID = advertID
        }
        if(segue.identifier == "videoReklamPage"){
            let displayVC = segue.destination as! VideoReklamController
            displayVC.advertID = advertID
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}


extension HomePageController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(catList.count)
        return catList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryScroll.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryViewCell
        
        
        cell.object=catList[indexPath.row]
        cell.reloadData()
        // print(catList[indexPath.row].name)
        
        return cell
        
        
    }
    
    
    
}

