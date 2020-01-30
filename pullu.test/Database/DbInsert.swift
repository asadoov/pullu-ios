//
//  DbInsert.swift
//  pullu.test
//
//  Created by Rufat Asadov on 1/12/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation
import Alamofire

class DbInsert {
    var dbSelect: dbSelect!
    
    
    
    /* func getJson(link: String, param: Any, completion: @escaping (_ result: String) -> ()){
     
     request(self.PULLULINK + link,method: .get,parameters: (param as! Parameters), encoding: URLEncoding(destination: .queryString)).responseJSON
     
     
     {
     (response) in
     
     switch(response.result)
     {
     case .success(let result):
     completion(response.result.value)
     break
     case .failure:
     completion(response.response?.statusCode ?? 666)
     break
     }
     }
     }
     */
    
    
    
    func SignUp(newUserData:NewUser,completionBlock: @escaping (_ result:Array<User>) ->()){
        
        let url="http://13.92.237.16/api/androidmobileapp/user/signUp?name=\(newUserData.name ?? "")&surname=\(newUserData.surname ?? "")&mail=\(newUserData.mail ?? "")&pass=\(newUserData.pass ?? "")&phone=\(newUserData.phone ?? "")&bDate=\(newUserData.bDate ?? "")&gender=\( newUserData.gender ?? "")&country=\(newUserData.country ?? "")&city=\(newUserData.city ?? "")&profession=\(newUserData.sector ?? "")"
        
        let urlTest = "http://13.92.237.16/api/androidmobileapp/user/signUp?name=uuu&surname=uuuu&mail=uu@uu.uu&pass=123&phone=123&username=uuuu&bDate=07-12-1989&gender=Kişi&country=Azərbaycan&city=Naxçıvan&profession=Texnologiya sektoru"
        
        
        let PULLULINK = "http://13.92.237.16/api/androidmobileapp/user/signUp"
        let Parameters = ["name": newUserData.name!, "surname": newUserData.surname!, "mail":newUserData.mail!, "pass": newUserData.pass!,"phone":newUserData.phone!,"bDate":newUserData.bDate!,"gender":newUserData.gender!,"country":newUserData.country!,"city":newUserData.city!,"profession":newUserData.sector!]
        
        
        
        request(PULLULINK ,method: .get,parameters: Parameters, encoding: URLEncoding(destination: .queryString)).responseJSON
            {
                (response)
                in
                
                do{
                    
                    
                    let list  = try
                        JSONDecoder().decode(Array<User>.self, from: response.data!)
                    // userList=list
                    print(list)
                    
                    completionBlock(list)
                    
                    
                }
                catch let jsonErr{
                    print("Error serializing json:",jsonErr)
                }
        }
        
        
        
        
        
        
    }
    func earnMoney(advertID:Int?,mail:String?,pass:String?,completionBlock: @escaping (_ result:EarnMoney) ->()){
        
        
        
        let PULLULINK = "http://13.92.237.16/api/androidmobileapp/earnMoney"
        let Parameters = ["advertID": advertID!,"mail":mail!, "pass":pass!] as [String : Any]
        
        
        
        request(PULLULINK ,method: .get,parameters: Parameters, encoding: URLEncoding(destination: .queryString)).responseJSON
            {
                (response)
                in
                
                do{
                    
                    
                    let status  = try
                        JSONDecoder().decode(EarnMoney.self, from: response.data!)
                    // userList=list
                    print(status)
                    
                    completionBlock(status)
                    
                    
                }
                catch let jsonErr{
                    print("Error serializing json:",jsonErr)
                }
        }
        
        
        
        
        
        
    }
}
