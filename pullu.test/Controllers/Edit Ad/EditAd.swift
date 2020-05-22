//
//  EditAd.swift
//  pullu.test
//
//  Created by Rufat Asadov on 5/22/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class EditAd: UIViewController {
    var aName:String?
    var aDescription:String?
    
    @IBOutlet weak var aNameBox: UITextField!
    @IBOutlet weak var aDescriptionBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aNameBox.text=""
        aDescriptionBox.text=""
        aNameBox.text = aName
        aDescriptionBox.text = aDescription
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
