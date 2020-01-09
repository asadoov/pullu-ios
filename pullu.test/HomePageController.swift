//
//  HomePageController.swift
//  pullu.test
//
//  Created by Javidan Mirza on 1/9/20.
//  Copyright © 2020 Javidan Mirza. All rights reserved.
//

import UIKit

class HomePageController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if let mail = defaults.string(forKey: "mail") {
            //print(stringOne) // Some String Value
        }
        if let pass = defaults.string(forKey: "pass") {
            //print(stringTwo) // Some String Value
        }
        if let userData = defaults.string(forKey: "uData") {
            let data = Data(userData.utf8)
            
            do{
                
                
                var list  = try
                    JSONDecoder().decode(Array<User>.self, from: data)
                print(list[0].phone)
                
                
            }
            catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
        }
        // Do any additional setup after loading the view.
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

