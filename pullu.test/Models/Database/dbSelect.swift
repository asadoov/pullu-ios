//
//  dbSelect.swift
//  pullu.test
//
//  Created by Rufat Asadzade on 1/7/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation
import Alamofire
import MBProgressHUD
public class dbSelect {
    
    
    func GetJson(jsonUrlString:String,completionBlock: @escaping (_ result:Data) ->()){
        
        
        guard let url = URL(string: jsonUrlString)else {return}
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(Data,URLResponse,Error)->Void in
            guard let data=Data else{return}
            print(data)
            completionBlock(data)
            
        })
        
        task.resume()
        
        
    }
    
    func signIn(phone:Int,pass:String,completionBlock: @escaping (_ result:Array<User>) ->()){
        
       // let PULLULINK="https://pullu.az/api/androidmobileapp/user/login"
         let PULLULINK="http://pullu.az:81/api/androidmobileapp/user/login"
         let Parameters = ["phone": phone,"pass":pass] as [String : Any]
         var list:Array<User> = Array<User>()
        request(PULLULINK ,method: .post,parameters: Parameters, encoding: URLEncoding(destination: .queryString),headers: nil).responseJSON
                           {
                               (response)
                               in
                               //  print(PULLULINK)
                               
                               do{
                                   
                                   
                                     list = try
                                        JSONDecoder().decode(Array<User>.self, from: response.data!)
                                                  // userList=list
                                                  
                                completionBlock(list)
                                   
                                   
                               }
                               catch{
                                   //print("Error serializing json:",jsonErr)
                                completionBlock(list)
                               }
                       }
                       
   
        
    }
    
    func getAds(username:String,pass:String,isPaid:Int,page:Int,catID:Int?,progressView:MBProgressHUD,completionBlock: @escaping (_ result:ResponseStruct<Advertisement>) ->()){
      //   let PULLULINK = "https://pullu.az/api/androidmobileapp/user/get/Ads"
         let PULLULINK = "http://pullu.az:81/api/androidmobileapp/user/get/Ads"
        // let PULLULINK = "http://127.0.0.1:44301/api/androidmobileapp/user/get/Ads"
              
         let Parameters:[String:Any]
         //var url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)"
         if catID! > 0 {
             Parameters = ["mail": username,"pass":pass,"pageNo":page,"isPaid":isPaid,"catID":catID!] as [String : Any]
             //          url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)&catID=\(catID!)"
         }else{
             Parameters = ["mail": username,"pass":pass,"pageNo":page,"isPaid":isPaid] as [String : Any]
             
         }
      
         request(PULLULINK ,method: .get,parameters: Parameters, encoding: URLEncoding(destination: .queryString),headers: nil).downloadProgress { (progress) in
                 DispatchQueue.main.async {
             progressView.progress = Float(progress.fractionCompleted)
             }
             print("progess!", Float(progress.fractionCompleted))
         }
             
             
             
             
             .responseJSON
             {
                 (response)
                 in
               
                 
                 do{
                     
                     
                     let list:ResponseStruct<Advertisement> = try
                         JSONDecoder().decode(ResponseStruct<Advertisement>.self, from: response.data!)
                     // userList=list
                     //print(list)
                     //list[0].error = false
                     completionBlock(list)
                     
                     
                 }
                 catch let jsonErr {
                     print("Error serializing json:",jsonErr)
                    
                    
                 }
         }
         
     
         
         //        GetJson(jsonUrlString: url){
         //            (json) in
         //            do{
         //
         //
         //
         //
         //                // userList=list
         //
         //
         //
         //            }
         //            catch let jsonErr{
         //                print("Error serializing json:",jsonErr)
         //            }
         //
         //        }
         
     }
    
    func getCounties(completionBlock: @escaping (_ result:Array<Country>) ->()){
        
        let url="https://pullu.az/api/androidmobileapp/get/countries"
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
    func getCities(countryId:Int?,completionBlock: @escaping (_ result:Array<City>) ->()){
        
        let url="https://pullu.az/api/androidmobileapp/get/Cities?countryid=" + String(countryId!)
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
    func getInterests(completionBlock: @escaping (_ result:Array<Interest>) ->()){
        
     let PULLULINK = "http://pullu.az:81/api/androidmobileapp/get/interests"
                          
                         
                          //var url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)"

                            //let Parameters = ["mobile": mobile,"code":otp] as [String : Any]
                              //          url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)&catID=\(catID!)"
                         
                          
                          
                          
                          
                          
                 
                         
                         
                         request(PULLULINK ,method: .get, encoding: URLEncoding(destination: .queryString)).responseJSON
                             {
                                 (response)
                                 in
                                 //  print(PULLULINK)
                                 
                                 do{
                                     
                                     
                                     let list  = try
                                        JSONDecoder().decode(Array<Interest>.self, from: response.data!)
                                     
                                     // userList=list
                                     
                                     completionBlock(list)
                                     
                                     
                                 }
                                 catch let jsonErr{
                                     print("Error serializing json:",jsonErr)
                                 }
                         }
                          
                          
        
    }
    func getProfessions(completionBlock: @escaping (_ result:Array<Profession>) ->()){
        
        let url="https://pullu.az/api/androidmobileapp/get/professions"
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
        
        let url="https://pullu.az/api/androidmobileapp/user/about?advertID=\(advertID!)&mail=\(mail!)&pass=\(pass!)"
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
    func getStatistics(mail:String?,pass:String?, completionBlock: @escaping (_ result:Statistics) ->()){
        
        let url="https://pullu.az/api/androidmobileapp/user/get/statistics?mail=\(mail!)&pass=\(pass!)"
        GetJson(jsonUrlString: url){
            (json) in
            do{
                
                
                let statistics  = try
                    JSONDecoder().decode(Statistics.self, from: json)
                
                // userList=list
                
                completionBlock(statistics)
                
            }
            catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
            
        }
        
    }
    
    //Profil
    func getProfileInfo(mail:String? , pass:String?, completionBlock: @escaping (_ result:Array<ProfileModel>) ->()){
        
        let url="https://pullu.az/api/androidmobileapp/user/get/profile?mail=\(mail!)&pass=\(pass!)"
        GetJson(jsonUrlString: url){
            (json) in
            do{
                
                
                let profile  = try
                    JSONDecoder().decode(Array<ProfileModel>.self, from: json)
                
                // userList=list
                
                completionBlock(profile)
                
            }
            catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
        }
    }
    
    //
    func aCategory(completionBlock: @escaping (_ result:Array<CategoryStruct>) ->()){
        
        let url="https://pullu.az/api/androidmobileapp/get/aCategory"
        GetJson(jsonUrlString: url){
            (json) in
            do{
                
                
                let aCatList  = try
                    JSONDecoder().decode(Array<CategoryStruct>.self, from: json)
                
                // userList=list
                
                completionBlock(aCatList)
                
            }
            catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
            
        }
        
    }
    func aType(completionBlock: @escaping (_ result:Array<TypeStruct>) ->()){
        
        let url="https://pullu.az/api/androidmobileapp/get/atype"
        
        GetJson(jsonUrlString: url){
            (json) in
            do{
                
                
                let aTypeList  = try
                    JSONDecoder().decode(Array<TypeStruct>.self, from: json)
                
                // userList=list
                
                completionBlock(aTypeList)
                
            }
            catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
            
        }
        
    }
    func aTariff(completionBlock: @escaping (_ result:Array<TariffStruct>) ->()){
        
        let url="https://pullu.az/api/androidmobileapp/get/atariff"
        
        request(url ,method: .get,encoding: URLEncoding(destination: .queryString)).responseJSON
            {
                (response)
                in
                
                do{
                    
                    
                    let aTariffStruct  = try
                        JSONDecoder().decode(Array<TariffStruct>.self, from: response.data!)
                    completionBlock(aTariffStruct)
                    
                    
                }
                catch let jsonErr{
                    print("Error serializing json:",jsonErr)
                }
        }
        
        
        //           GetJson(jsonUrlString: url){
        //               (json) in
        //               do{
        //
        //
        //                   let aTariffStruct  = try
        //                       JSONDecoder().decode(Array<TariffStruct>.self, from: json)
        //
        //                   // userList=list
        //
        //                   completionBlock(aTariffStruct)
        //
        //               }
        //               catch let jsonErr{
        //                   print("Error serializing json:",jsonErr)
        //               }
        //
        //           }
        
    }
    func getAgeRange(completionBlock: @escaping (_ result:Array<AgeRangeStruct>) ->()){
        
        let url="https://pullu.az/api/androidmobileapp/get/age/range"
        
        GetJson(jsonUrlString: url){
            (json) in
            do{
                
                
                let backroundImageList  = try
                    JSONDecoder().decode(Array<AgeRangeStruct>.self, from: json)
                
                // userList=list
                
                completionBlock(backroundImageList)
                
            }
            catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
            
        }
        
    }
    
    func getBackgroundImages(completionBlock: @escaping (_ result:Array<BackroundImageStruct>) ->()){
        
        let url="https://pullu.az/api/androidmobileapp/get/backgrounds"
        
        GetJson(jsonUrlString: url){
            (json) in
            do{
                
                
                let backroundImageList  = try
                    JSONDecoder().decode(Array<BackroundImageStruct>.self, from: json)
                
                // userList=list
                
                completionBlock(backroundImageList)
                
            }
            catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
            
        }
        
    }
    func getFinance(mail:String,pass:String,completionBlock: @escaping (_ result:Array<FinanceStruct>) ->()){
  
           let PULLULINK = "https://pullu.az/api/androidmobileapp/user/get/finance"
           
          
           //var url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)"

              let Parameters = ["mail": mail,"pass":pass] as [String : Any]
               //          url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)&catID=\(catID!)"
          
           
           
           
           
           
           
           
           request(PULLULINK ,method: .post,parameters: Parameters, encoding: URLEncoding(destination: .queryString),headers: nil).responseJSON
               {
                   (response)
                   in
                   //  print(PULLULINK)
                   
                   do{
                       
                       
                       var list  = try
                           JSONDecoder().decode(Array<FinanceStruct>.self, from: response.data!)
                       // userList=list
                       //print(list)
                       
                       completionBlock(list)
                       
                       
                   }
                   catch let jsonErr{
                       print("Error serializing json:",jsonErr)
                   }
           }
           
           
       }
     func getMyViews(mail:String,pass:String,completionBlock: @escaping (_ result:Array<Advertisement>) ->()){
    
             let PULLULINK = "https://pullu.az/api/androidmobileapp/user/get/views"
             
            
             //var url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)"

                let Parameters = ["mail": mail,"pass":pass] as [String : Any]
                 //          url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)&catID=\(catID!)"
            
             
             
             
             
             
             
             
             request(PULLULINK ,method: .get,parameters: Parameters, encoding: URLEncoding(destination: .queryString),headers: nil).responseJSON
                 {
                     (response)
                     in
                     //  print(PULLULINK)
                     
                     do{
                         
                         
                         var list  = try
                             JSONDecoder().decode(Array<Advertisement>.self, from: response.data!)
                         // userList=list
                         //print(list)
                         
                         completionBlock(list)
                         
                         
                     }
                     catch let jsonErr{
                         print("Error serializing json:",jsonErr)
                     }
             }
             
             
         }
    func getMyAds(mail:String,pass:String,completionBlock: @escaping (_ result:Array<Advertisement>) ->()){
       
                let PULLULINK = "https://pullu.az/api/androidmobileapp/user/get/my/ads"
                
               
                //var url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)"

                   let Parameters = ["mail": mail,"pass":pass] as [String : Any]
                    //          url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)&catID=\(catID!)"
               
                
                
                
                
                
        var list:Array<Advertisement> = Array <Advertisement>()
                
                request(PULLULINK ,method: .get,parameters: Parameters, encoding: URLEncoding(destination: .queryString),headers: nil).responseJSON
                    {
                        (response)
                        in
                        //  print(PULLULINK)
                        
                        do{
                            
                            
                             list  = try
                                JSONDecoder().decode(Array<Advertisement>.self, from: response.data!)
                            // userList=list
                            //print(list)
                            
                            completionBlock(list)
                            
                            
                        }
                        catch{
                            //print("Error serializing json:",jsonErr)
                            completionBlock(list)
                        }
                }
                
                
            }
    func verifyOtp(mobile:Int,otp:Int,completionBlock: @escaping (_ result:Status) ->()){
          
                   let PULLULINK = "http://pullu.az:81/api/androidmobileapp/accounts/verify/otp"
                   
                  
                   //var url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)"

                      let Parameters = ["mobile": mobile,"code":otp] as [String : Any]
                       //          url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)&catID=\(catID!)"
                  
                   
                   
                   
                   
                   
          
                  
                  
                  request(PULLULINK ,method: .post,parameters: Parameters, encoding: URLEncoding(destination: .queryString)).responseJSON
                      {
                          (response)
                          in
                          //  print(PULLULINK)
                          
                          do{
                              
                              
                              let statusCode  = try
                                  JSONDecoder().decode(Status.self, from: response.data!)
                              // userList=list
                              //print(list)
                              
                              completionBlock(statusCode)
                              
                              
                          }
                          catch let jsonErr{
                              print("Error serializing json:",jsonErr)
                          }
                  }
                   
                   
               }
    
    func myAdViewers(phone:Int,pass:String,aID:Int,completionBlock: @escaping (_ result:ResponseStruct<ViewerStruct>) ->()){
             
                      //let PULLULINK = "http://pullu.az:81/api/androidmobileapp/accounts/verify/otp"
                      let PULLULINK = "http://pullu.az:81/api/androidmobileapp/user/get/my/ads/viewers"
                      
                     
                      //var url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)"

        let Parameters = ["phone": phone,"pass":pass,"aID":aID] as [String : Any]
                          //          url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)&catID=\(catID!)"
                     
                      
                      
                      
                      
                      
             
                     
                     
                     request(PULLULINK ,method: .get,parameters: Parameters, encoding: URLEncoding(destination: .queryString)).responseJSON
                         {
                             (response)
                             in
                             //  print(PULLULINK)
                             
                             do{
                                 
                                 
                                 let statusCode  = try
                                     JSONDecoder().decode(ResponseStruct<ViewerStruct>.self, from: response.data!)
                                 // userList=list
                                 //print(list)
                                 
                                 completionBlock(statusCode)
                                 
                                 
                             }
                             catch let jsonErr{
                                 print("Error serializing json:",jsonErr)
                             }
                     }
                      
                      
                  }
}
