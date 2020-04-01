//
//  ArchiveController.swift
//  pullu.test
//
//  Created by Javidan Mirza on 2/25/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
//import Alomofire
import AlamofireImage


class ArchiveController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    var viewwModel: [ViewsModel] = [ViewsModel]()
    let db: dbSelect = dbSelect()
    
    @IBOutlet weak var atableView: UITableView!
    
    @IBOutlet weak var elanBshligi: UILabel!
    @IBOutlet weak var price: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
        
        
     
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewwModel.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return 95
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
