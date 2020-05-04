//
//  AlamofireInterface.swift
//  pullu.test
//
//  Created by Rufat on 5/4/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation
import Alamofire
import MBProgressHUD
class AlamofireInterface {
    var dbSelect: dbSelect!
    func getRequest(params:[String:Any]?,url:String?,completionBlock: @escaping (_ result:Data) ->()){
           
           
           
           //let urlTest = "http://13.92.237.16/api/androidmobileapp/user/signUp?name=uuu&surname=uuuu&mail=uu@uu.uu&pass=123&phone=123&username=uuuu&bDate=07-12-1989&gender=Kişi&country=Azərbaycan&city=Naxçıvan&profession=Texnologiya sektoru"
           
           
          // let PULLULINK = "https://pullu.az/api/androidmobileapp/user/signUp"
//           let Parameters = ["name": newUserData.name!, "surname": newUserData.surname!, "mail":newUserData.mail!, "pass": newUserData.pass!,"phone":newUserData.phone!,"bDate":newUserData.bDate!,"gender":newUserData.gender!,"country":newUserData.country!,"city":newUserData.city!,"profession":newUserData.sector!]
//
           
           
        request(url! ,method: .get,parameters: params, encoding: URLEncoding(destination: .queryString)).responseJSON
               {
                   (response)
                   in
                   
                   do{
                       
                     
                       // userList=list
                       //print(list)
                       
                    completionBlock(response.data!)
                       
                       
                   }
                   catch let jsonErr{
                       print("Error serializing json:",jsonErr)
                   }
           }
           
           
           
           
           
           
       }
    
    
}
