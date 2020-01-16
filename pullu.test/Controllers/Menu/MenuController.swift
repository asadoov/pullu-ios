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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let udata=defaults.string(forKey: "uData")
        do{
            
            
            let list  = try
                JSONDecoder().decode(Array<User>.self, from: udata!.data(using: .utf8)!)
            
            // userList=list
            nameSurname.text = "\(list[0].name!) \(list[0].surname!)"
            balance.text = "Balans: \(list[0].balance!) AZN"
            earning.text = "Qazanc: \(list[0].earning!) AZN"
            
            
            
        }
        catch let jsonErr{
            print("Error serializing json:",jsonErr)
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        self.defaults.set(nil, forKey: "mail")
        self.defaults.set(nil, forKey: "pass")
        self.defaults.set(nil, forKey: "uData")
        self.performSegue(withIdentifier: "signOutSegue", sender: self)
        
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
