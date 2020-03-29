//
//  AddBalanceController.swift
//  pullu.test
//
//  Created by Javidan Mirza on 2/18/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class AddBalanceController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func paymentButton(_ sender: Any) {
        self.performSegue(withIdentifier: "paymentViewSegue", sender: self)
        
    }
    
    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "paymentViewSegue") {
            let displayVC = segue.destination as! WebViewController
            //displayVC.id =
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
