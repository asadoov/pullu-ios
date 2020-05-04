//
//  MenuController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/16/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import FirebaseMessaging
class MenuController: UIViewController {
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var nameSurname: UILabel!
    
    
    
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
        profileBtn.icon  =  UIImage(named: "logout")?.pngData()
        
        let staticsBtn:MenuStruct = MenuStruct()
        staticsBtn.ID=2
        staticsBtn.name="Statistik Məlumatlar"
        staticsBtn.icon  =  UIImage(named: "logout")?.pngData()
        
        let ruleBtn:MenuStruct = MenuStruct()
        ruleBtn.ID=3
        ruleBtn.name="Qayda və şərtlər"
        ruleBtn.icon  =  UIImage(named: "logout")?.pngData()
        
        let aboutBtn:MenuStruct = MenuStruct()
        aboutBtn.ID=4
        aboutBtn.name="Proqram haqqında"
        aboutBtn.icon  =  UIImage(named: "logout")?.pngData()
        
        let financeBtn:MenuStruct = MenuStruct()
        financeBtn.ID=5
        financeBtn.name="Maliyə"
        financeBtn.icon  =  UIImage(named: "logout")?.pngData()
        
        menuItems.append(profileBtn)
        menuItems.append(staticsBtn)
        menuItems.append(financeBtn)
//        menuItems.append(ruleBtn)
//        menuItems.append(aboutBtn)
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
        
        //ay qardash onun ucun mene yigmisan?)) sualin nedi onu de basha salimda
        //qacmamagi ucun constrainler lazimdi onnanda elave sen dediyin ucbucaq deyil. heresi ucun ayri olmur constrain eliyende butun devicelar ucun olur. girib youtubeda da baxa bilerse constrain derslerine. bele neyi deyirsen gosterim qeydiyyati duzeltmeliyem. he constrain hemishe lazimdi. onsuz olmur. goster birini gorum. nastroykada button deyil tableviewdu. he. yox ancaq duzgun komponentler istifade elemelisen. burda tableview qoymaliydin. demeliydin yigsinlar ios ucun. neyi gosterim man? tezleshdirecek hecne yoxdu. ancaq qacmamasi ucun constrainler qoymalisan. ala blaaaaa bu nediye bele. sencani bunu normal yig. bir dene tableview controller at ya da collection view at headerine goy olanlari at shekil qarishiq. yox mans collection view at. mans konrek pizdecdi. gozle gorume. javani neylediz?)) duzelde bilir? sen static sectionlar verib her sectionuda elnen yigirsan. he. bildin? bu headernende ola biler belede. ama heydernen elesen daha yaxhidi
        //headernen elemishemde constreinler vermemisen neye el vurursan qarishir bir birine. buna bax. image secirsen gedir qiraqda nebilim hara. ay bla ala bu neteri sheydi bele. bunu tezeden gosterdiyim kimi yig. davam ele bele. view ucun background image qoyarsan kodda
        //statik nece yigaq? ashagini
        //nese e brat bosh ver sikib uje bu
        //ozum baxim gorum neynirem
        //arashdir asantdi ama constrain qoymasan qacacaq yene
        //constraint yoxe bu xiyar ios nie vermir mene sirf xml nen yazim. ay qardash koddada constrain qoymalisan
        //burda kodda yazmga baxdim ozun kodda button = new button eliirsen budu bunlarda kodnan view yazmax
        // men dediim sirf front laizmdi
        //bax kele ama constrain onsuzda lazimdi. men cixdim
        //yaxshi cox sag ol )) ))
        
        
        
        
        let udata=defaults.string(forKey: "uData")
        do{
            
            
            let list  = try
                JSONDecoder().decode(Array<User>.self, from: udata!.data(using: .utf8)!)
            
            // userList=list
            nameSurname.text = "\(list[0].name!) \(list[0].surname!)"
          
            userID.text = "İstifadəci nömrəniz: \(list[0].id!)"
            
            
        }
        catch let jsonErr{
            print("Error serializing json:",jsonErr)
        }
        // Do any additional setup after loading the view.
    }
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.view.backgroundColor = .clear
//        super.viewWillAppear(animated)
//    }
    

    
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    
    
    
    

    @IBAction func signOut(_ sender: Any) {
      
     
        self.defaults.set(nil, forKey: "uID")
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
                do {
                    let uID = self.defaults.string(forKey: "uID")!
                                   Messaging.messaging().unsubscribe(fromTopic: "\(uID)")
                    
                }
                catch{
                    
                    
                }
               
                self.defaults.set(nil, forKey: "mail")
                self.defaults.set(nil, forKey: "pass")
                self.defaults.set(nil, forKey: "uData")}
            
            
        }
        
        else if cell.object?.ID == 1{
            self.performSegue(withIdentifier: "profSegue", sender: self)
            
        }
            
        else if cell.object?.ID == 2{
            self.performSegue(withIdentifier: "statiSegue", sender: self)
            
        }
        
        else if cell.object?.ID == 5{
            self.performSegue(withIdentifier: "finanSegue", sender: self)
            
        }
        // print(cell.object?.name)
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
