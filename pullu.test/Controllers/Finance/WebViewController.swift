//
//  WebViewController.swift
//  pullu.test
//
//  Created by Javidan Mirza on 2/18/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController, WKUIDelegate {
    let defaults = UserDefaults.standard
    var User:User?
    var id: Int?
    var MainUrl = "https://test.smartpay.az/keeper-sl/payment/service/588?iframe=true&im_id1="
    

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        let uData = defaults.string(forKey: "uData")
        do{
        
        let list = try!
            JSONDecoder().decode(Array<User>.self, from: uData!.data(using: .utf8)!)
            
            id=list[0].id

        }
        
        let myURL = URL(string:"\(MainUrl)\(id!)")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        
        
        
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
