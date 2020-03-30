//
//  TariffController.swift
//  pullu.test
//
//  Created by Rufat on 2/20/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import UIKit

class TariffController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var select:dbSelect=dbSelect()
    
    var tariffList:Array<TariffStruct>=[]
 var newAdverisement:NewAdvertisementStruct=NewAdvertisementStruct()
    
    @IBOutlet weak var tariffTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tariffTable.delegate = self
        tariffTable.dataSource = self
        select.aTariff(){
            (list)
            in
            self.tariffList=list
            DispatchQueue.main.async {
                self.tariffTable.reloadData()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tariffList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TariffViewCell = (tableView.dequeueReusableCell(withIdentifier: "cell") as! TariffViewCell)
        
        do{
            cell.object = tariffList[indexPath.row]
        }
        catch
        {
            print(indexPath.row)
        }
        
        //cell.delegate = self
        cell.reloadData()
        //cell.object = dataArray[indexPath.row]
        //     cell.delegate = self
        
        
        // Configure the cell...
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 60
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      for indexPath in tableView.indexPathsForSelectedRows ?? [] {
          tableView.deselectRow(at: indexPath, animated: true)
      }
         let cell: TariffViewCell = (tableView.dequeueReusableCell(withIdentifier: "cell") as! TariffViewCell)
         cell.object = tariffList[indexPath.row]
              // cell.object = tariffList[indexPath.row]
        newAdverisement.trfID=cell.object!.id!
      //  print(cell.object!.id!)
               cell.reloadData()
        self.performSegue(withIdentifier: "newASecond", sender: true)
        
    }

        
 
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="newASecond"{
            let displayVC = segue.destination as! NewASecondController
                                 displayVC.newAdverisement = newAdverisement
            
        }
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     
    
}
