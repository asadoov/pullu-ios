//
//  ArchiveController.swift
//  pullu.test
//
//  Created by Javidan Mirza on 2/25/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Alomofire
import AlamofireImage


class ArchiveController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var viewSegment: UISegmentedControl!
    
    @IBOutlet weak var archiveTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
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
