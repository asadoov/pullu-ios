//
//  ArchiveController.swift
//  pullu.test
//
//  Created by Javidan Mirza on 5/6/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit
import Foundation
import SJSegmentedScrollView

class ArchiveController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let storyboard = self.storyboard {
            
            let myViewController = storyboard
                .instantiateViewController(withIdentifier: "myView")
            myViewController.title = "Izlədiklərim"
            
            let myShareController = storyboard
                .instantiateViewController(withIdentifier: "myShare")
            myShareController.title = "Paylaşdıqlarım"
            
            let segmentedViewController = SJSegmentedViewController(headerViewController: nil,
                                                                    segmentControllers: [myViewController,
                                                                        myShareController])
            segmentedViewController.segmentBackgroundColor = UIColor.white
            segmentedViewController.segmentTitleColor = UIColor.black
            segmentedViewController.selectedSegmentViewColor = UIColor.black
            segmentedViewController.selectedSegmentViewHeight = 3
            segmentedViewController.segmentViewHeight = 80
            segmentedViewController.headerViewHeight = 95
            
            addChild(segmentedViewController)
            self.view.addSubview(segmentedViewController.view)
            segmentedViewController.view.frame = self.view.bounds
            segmentedViewController.didMove(toParent: self)
        
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
