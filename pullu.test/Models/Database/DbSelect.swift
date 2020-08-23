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
public class DbSelect {
    
    let defaults = UserDefaults.standard
    let security:Security = Security()
    func GetJson(jsonUrlString:String,completionBlock: @escaping (_ result:Data) ->()){
        
        
        guard let url = URL(string: jsonUrlString)else {return}
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(Data,URLResponse,Error)->Void in
            guard let data=Data else{return}
            print(data)
            completionBlock(data)
            
        })
        
        task.resume()
        
        
    }
    
    func SignIn(phone:Int64,pass:String,completionBlock: @escaping (_ result:ResponseStruct<UserStruct>) ->()){
        
        // let PULLULINK="https://pullu.az/api/androidmobileapp/user/login"
        let PULLULINK="http://pullu.az:81/api/androidmobileapp/user/login"
        let Parameters = ["phone": phone,"pass":pass] as [String : Any]
        //var obj:ResponseStruct<Advertisement> = ResponseStruct<Advertisement>(from: )
        request(PULLULINK ,method: .post,parameters: Parameters, encoding: URLEncoding(destination: .queryString),headers: nil).responseJSON
            {
                (response)
                in
                //  print(PULLULINK)
                
                do{
                    
                    
                    let obj:ResponseStruct<UserStruct>  = try
                        JSONDecoder().decode(ResponseStruct<UserStruct>.self, from: response.data!)
                    // userList=list
                    switch obj.status{
                    case 1:
                        self.defaults.set(obj.data[0].userToken, forKey: "userToken")
                        self.defaults.set(obj.requestToken, forKey: "requestToken")
                        break
                    default:
                        break
                        
                    }
                    
                    completionBlock(obj)
                    
                    
                }
                catch let jsonErr{
                    
                    print("Error serializing json:",jsonErr)
                    //completionBlock(obj)
                }
        }
        
        
        
    }
    
    func GetAds(isPaid:Int,page:Int,catID:Int?,progressView:MBProgressHUD,completionBlock: @escaping (_ result:ResponseStruct<Advertisement>) ->()){
        
        
        let usrtkn = defaults.string(forKey: "userToken")
        let reqTkn = defaults.string(forKey: "requestToken")
        //   let PULLULINK = "https://pullu.az/api/androidmobileapp/user/get/Ads"
        let PULLULINK = "http://pullu.az:81/api/androidmobileapp/user/get/Ads"
        // let PULLULINK = "http://127.0.0.1:44301/api/androidmobileapp/user/get/Ads"
        
        let Parameters:[String:Any]
        //var url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)"
        if catID! > 0 {
            Parameters = ["userToken": usrtkn!,"requesttoken":reqTkn!,"pageNo":page,"isPaid":isPaid,"catID":catID!] as [String : Any]
            //          url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)&catID=\(catID!)"
        }else{
            Parameters = ["userToken": usrtkn ?? "","requesttoken":reqTkn ?? "","pageNo":page,"isPaid":isPaid] as [String : Any]
            
        }
        
        request(PULLULINK ,method: .post,parameters: Parameters, encoding: URLEncoding(destination: .queryString),headers: nil).downloadProgress { (progress) in
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
                    
                    
                    let obj:ResponseStruct<Advertisement> = try
                        JSONDecoder().decode(ResponseStruct<Advertisement>.self, from: response.data!)
                    
                    if obj.status == 1{
                        self.security.RefreshToken(requestToken: obj.requestToken)
                        
                    }
                    // userList=list
                    //print(list)
                    //list[0].error = false
                    completionBlock(obj)
                    
                    
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
    
    func GetCounties(completionBlock: @escaping (_ result:Array<Country>) ->()){
        
        let url="http://pullu.az:81/api/androidmobileapp/get/countries"
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
    func GetCities(countryId:Int?,completionBlock: @escaping (_ result:Array<City>) ->()){
        
        let url="http://pullu.az:81/api/androidmobileapp/get/Cities?countryid=" + String(countryId ?? 0)
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
    func GetInterests(completionBlock: @escaping (_ result:Array<Interest>) ->()){
        
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
    func GetProfessions(completionBlock: @escaping (_ result:Array<Profession>) ->()){
        
        let url="http://pullu.az:81/api/androidmobileapp/get/professions"
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
    func GetAdvertById(advertID:Int?, completionBlock: @escaping (_ result:Array<Advertisement>) ->()){
        
        let url="http://pullu.az:81/api/androidmobileapp/user/about?advertID=\(advertID!)"
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
    func GetStatistics(completionBlock: @escaping (_ result:ResponseStruct<Statistics>) ->()){
        let userToken = defaults.string(forKey: "userToken")
        let requestToken = defaults.string(forKey: "requestToken")
        
        let PULLULINK = "http://pullu.az:81/api/androidmobileapp/user/get/statistics"
        let Parameters = ["userToken": userToken ?? "","requestToken":requestToken ?? ""] as [String : Any]
        request(PULLULINK ,method: .post, parameters: Parameters, encoding: URLEncoding(destination: .queryString)).responseJSON
            {
                (response)
                in
                //  print(PULLULINK)
                
                do{
                    
                    
                    let obj  = try
                        JSONDecoder().decode(ResponseStruct<Statistics>.self, from: response.data!)
                    
                    // userList=list
                    if obj.status == 1{
                        self.security.RefreshToken(requestToken: obj.requestToken)
                        
                    }
                    completionBlock(obj)
                    
                }
                catch let jsonErr{
                    print("Error serializing json:",jsonErr)
                }
        }
        
        
        
    }
    
    //Profil
    func GetProfileInfo( completionBlock: @escaping (_ result:ResponseStruct<ProfileModel>) ->()){
        let userToken = defaults.string(forKey: "userToken")
        let requestToken = defaults.string(forKey: "requestToken")
        
        let url="http://pullu.az:81/api/androidmobileapp/user/get/profile"
        let Parameters = ["userToken": userToken ?? "","requestToken":requestToken ?? ""] as [String : Any]
        request(url ,method: .post,parameters: Parameters, encoding: URLEncoding(destination: .queryString)).responseJSON
            {
                (response)
                in
                
                do{
                    
                    
                    let obj  = try
                        JSONDecoder().decode(ResponseStruct<ProfileModel>.self, from: response.data!)
                    if obj.status == 1{
                        self.security.RefreshToken(requestToken: obj.requestToken)
                        
                    }
                    completionBlock(obj)
                    
                    
                }
                catch let jsonErr{
                    print("Error serializing json:",jsonErr)
                }
        }
        
        
        
    }
    
    //
    func ACategory(completionBlock: @escaping (_ result:Array<CategoryStruct>) ->()){
        
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
    func AType(completionBlock: @escaping (_ result:Array<TypeStruct>) ->()){
        
        let url="http://pullu.az:81/api/androidmobileapp/get/atype"
        
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
    func ATariff(completionBlock: @escaping (_ result:Array<TariffStruct>) ->()){
        
        let url="http://pullu.az:81/api/androidmobileapp/get/atariff"
        
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
    func GetAgeRange(completionBlock: @escaping (_ result:Array<AgeRangeStruct>) ->()){
        
        let url="http://pullu.az:81/api/androidmobileapp/get/age/range"
        
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
    
    func GetBackgroundImages(completionBlock: @escaping (_ result:Array<BackroundImageStruct>) ->()){
        
        let url="http://pullu.az:81/api/androidmobileapp/get/backgrounds"
        
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
    func GetFinance(completionBlock: @escaping (_ result:ResponseStruct<FinanceStruct>) ->()){
        
        
        let userToken = defaults.string(forKey: "userToken")
        let requestToken = defaults.string(forKey: "requestToken")
        let PULLULINK = "http://pullu.az:81/api/androidmobileapp/user/get/finance"
        
        
        //var url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)"
        
        let Parameters = ["userToken": userToken!,"requestToken":requestToken!] as [String : Any]
        //          url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)&catID=\(catID!)"
        
        
        
        
        
        
        
        
        request(PULLULINK ,method: .post,parameters: Parameters, encoding: URLEncoding(destination: .queryString),headers: nil).responseJSON
            {
                (response)
                in
                //  print(PULLULINK)
                
                do{
                    
                    
                    let obj  = try
                        JSONDecoder().decode(ResponseStruct<FinanceStruct>.self, from: response.data!)
                    // userList=list
                    //print(list)
                    if obj.status == 1{
                        self.security.RefreshToken(requestToken: obj.requestToken)
                        
                    }
                    completionBlock(obj)
                    
                    
                }
                catch let jsonErr{
                    print("Error serializing json:",jsonErr)
                }
        }
        
        
    }
    func GetMyViews(completionBlock: @escaping (_ result:ResponseStruct<Advertisement>) ->()){
        let userToken = defaults.string(forKey: "userToken")
        let requestToken = defaults.string(forKey: "requestToken")
        let PULLULINK = "http://pullu.az:81/api/androidmobileapp/user/get/views"
        
        
        //var url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)"
        
        let Parameters = ["userToken": userToken!,"requestToken":requestToken!] as [String : Any]
        //          url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)&catID=\(catID!)"
        
        
        
        
        
        
        
        
        request(PULLULINK ,method: .post,parameters: Parameters, encoding: URLEncoding(destination: .queryString),headers: nil).responseJSON
            {
                (response)
                in
                //  print(PULLULINK)
                
                do{
                    
                    
                    let obj  = try
                        JSONDecoder().decode(ResponseStruct<Advertisement>.self, from: response.data!)
                    // userList=list
                    //print(list)
                    if obj.status == 1{
                        self.security.RefreshToken(requestToken: obj.requestToken)
                        
                    }
                    completionBlock(obj)
                    
                    
                }
                catch let jsonErr{
                    print("Error serializing json:",jsonErr)
                }
        }
        
        
    }
    func GetMyAds(completionBlock: @escaping (_ result:ResponseStruct<Advertisement>) ->()){
        
        let userToken = defaults.string(forKey: "userToken")
        let requestToken = defaults.string(forKey: "requestToken")
        
        let PULLULINK = "http://pullu.az:81/api/androidmobileapp/user/get/my/ads"
        
        
        //var url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)"
        
        let Parameters = ["userToken": userToken ?? "","requestToken":requestToken ?? ""] as [String : Any]
        //          url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)&catID=\(catID!)"
        
        
        
        
        
        
        
        
        request(PULLULINK ,method: .post,parameters: Parameters, encoding: URLEncoding(destination: .queryString),headers: nil).responseJSON
            {
                (response)
                in
                //  print(PULLULINK)
                
                do{
                    
                    
                    let obj:ResponseStruct<Advertisement> = try
                        JSONDecoder().decode(ResponseStruct<Advertisement>.self, from: response.data!)
                    // userList=list
                    //print(list)
                    if obj.status == 1{
                        self.security.RefreshToken(requestToken: obj.requestToken)
                        
                    }
                    completionBlock(obj)
                    
                    
                }
                catch let jsonErr{
                    print("Error serializing json:",jsonErr)
                    
                }
        }
        
        
    }
    func VerifyOtp(mobile:Int,otp:Int,completionBlock: @escaping (_ result:Status) ->()){
        
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
    
    func MyAdViewers(aID:Int,completionBlock: @escaping (_ result:ResponseStruct<ViewerStruct>) ->()){
        let userToken = defaults.string(forKey: "userToken")
        let requestToken = defaults.string(forKey: "requestToken")
        //let PULLULINK = "http://pullu.az:81/api/androidmobileapp/accounts/verify/otp"
        let PULLULINK = "http://pullu.az:81/api/androidmobileapp/user/get/my/ads/viewers"
        
        
        //var url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)"
        
        let Parameters = ["userToken": userToken!,"requestToken":requestToken!,"aID":aID] as [String : Any]
        //          url = "https://pullu.az/api/androidmobileapp/user/get/Ads?mail=\(username)&pass=\(pass)&catID=\(catID!)"
        
        
        
        
        
        
        
        
        
        request(PULLULINK ,method: .post,parameters: Parameters, encoding: URLEncoding(destination: .queryString)).responseJSON
            {
                (response)
                in
                //  print(PULLULINK)
                
                do{
                    
                    
                    let obj  = try
                        JSONDecoder().decode(ResponseStruct<ViewerStruct>.self, from: response.data!)
                    // userList=list
                    //print(list)
                    if obj.status == 1{
                        self.security.RefreshToken(requestToken: obj.requestToken)
                        
                    }
                    completionBlock(obj)
                    
                    
                }
                catch let jsonErr{
                    print("Error serializing json:",jsonErr)
                }
        }
        
        
    }
}
