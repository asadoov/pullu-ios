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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func profilButton(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "profSegue", sender: self)
        }
        
        }
    
    @IBAction func statisticsButton(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "statiSegue", sender: self)
        }
    }
    
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
