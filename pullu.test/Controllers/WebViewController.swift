//
//  WebViewController.swift
//  pullu.test
//
//  Created by Javidan Mirza on 2/18/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController {
    let defaults = UserDefaults.standard

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)

        // Do any additional setup after loading the view.
        let usrData = defaults.string(forKey: "usrData")
        do{
        
        //let list  = try
           // JSONDecoder().decode(Array<User>.self, from: usrdata!.data(using: .utf8)!)
            
            
            
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
