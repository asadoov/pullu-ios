//
//  ConnectionCheckController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/9/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class ConnectionCheckController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func retryButton(_ sender: Any) {
        if ConnectionCheck.isConnectedToNetwork() {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "logInPage", sender: self)
            }
            print("Connected")
            
        }
        else{
            
            print("disConnected")
        }
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
