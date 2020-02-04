//
//  dbSelect.swift
//  pullu.test
//
//  Created by Rufat Asadzade on 1/7/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation
class dbSelect {
    
    
    func GetJson(jsonUrlString:String,completionBlock: @escaping (_ result:Data) ->()){
        
        
        guard let url = URL(string: jsonUrlString)else {return}
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(Data,URLResponse,Error)->Void in
            guard let data=Data else{return}
            completionBlock(data)
            
        })
        
        task.resume()
        
        
    }
    
    func SignIn(username:String,pass:String,completionBlock: @escaping (_ result:Array<User>) ->()){
        
        let url="http://13.92.237.16/api/androidmobileapp/user/login?username="+username+"&pass="+pass
        GetJson(jsonUrlString: url){
            (json) in
            do{
                
                
                var list  = try
                    JSONDecoder().decode(Array<User>.self, from: json)
                // userList=list
                
                completionBlock(list)
                
            }
            catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
            
            
        }
        
    }
    
    func getAds(username:String,pass:String,completionBlock: @escaping (_ result:Array<Advertisement>) ->()){
        
        let url="http://13.92.237.16/api/androidmobileapp/user/getAds?username="+username+"&pass="+pass
        GetJson(jsonUrlString: url){
            (json) in
            do{
                
                
                var list  = try
                    JSONDecoder().decode(Array<Advertisement>.self, from: json)
                
                // userList=list
                
                completionBlock(list)
                
            }
            catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
            
        }
        
    }
    
    func getCounties(completionBlock: @escaping (_ result:Array<Country>) ->()){
        
        let url="http://13.92.237.16/api/androidmobileapp/getCountries"
        GetJson(jsonUrlString: url){
            (json) in
            do{
                
                
                let list  = try
                    JSONDecoder().decode(Array<Country>.self, from: json)
                
                // userList=list
                
                completionBlock(list)
                
            }
            catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
            
        }
        
    }
    func getCities(countryId:Int,completionBlock: @escaping (_ result:Array<City>) ->()){
           
           let url="http://13.92.237.16/api/androidmobileapp/getCities?countryid=" + String(countryId)
           GetJson(jsonUrlString: url){
               (json) in
               do{
                   
                   
                   let list  = try
                       JSONDecoder().decode(Array<City>.self, from: json)
                   
                   // userList=list
                   
                   completionBlock(list)
                   
               }
               catch let jsonErr{
                   print("Error serializing json:",jsonErr)
               }
               
           }
           
       }
       
    func getProfessions(completionBlock: @escaping (_ result:Array<Profession>) ->()){
           
           let url="http://13.92.237.16/api/androidmobileapp/getprofessions"
           GetJson(jsonUrlString: url){
               (json) in
               do{
                   
                   
                   let list  = try
                       JSONDecoder().decode(Array<Profession>.self, from: json)
                   
                   // userList=list
                   
                   completionBlock(list)
                   
               }
               catch let jsonErr{
                   print("Error serializing json:",jsonErr)
               }
               
           }
           
       }
    func getAdvertById(advertID:Int?,mail:String?,pass:String?, completionBlock: @escaping (_ result:Array<Advertisement>) ->()){
           
           let url="http://13.92.237.16/api/androidmobileapp/user/about?advertID=\(advertID!)&mail=\(mail!)&pass=\(pass!)"
           GetJson(jsonUrlString: url){
               (json) in
               do{
                   
                   
                   let list  = try
                       JSONDecoder().decode(Array<Advertisement>.self, from: json)
                   
                   // userList=list
                   
                   completionBlock(list)
                   
               }
               catch let jsonErr{
                   print("Error serializing json:",jsonErr)
               }
               
           }
           
       }
    
}
