//
//  ReklamStoryController.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/24/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class ReklamStoryController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var advertDescriptionLabel: UILabel!
    var advertDescription:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        advertDescriptionLabel.text=advertDescription
var time=0
        // Do any additional setup after loading the view.
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            time+=1
            if time==30{
                self.dismiss(animated: true)
                
            }
            
            DispatchQueue.main.async {
                self.timerLabel.text=String(Int(self.timerLabel.text!)!-1)
            }
            
           
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
