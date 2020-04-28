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
    
    
    
    func SignUp(newUserData:NewUser,completionBlock: @escaping (_ result:Status) ->()){
        
        
        
        let urlTest = "http://13.92.237.16/api/androidmobileapp/user/signUp?name=uuu&surname=uuuu&mail=uu@uu.uu&pass=123&phone=123&username=uuuu&bDate=07-12-1989&gender=Kişi&country=Azərbaycan&city=Naxçıvan&profession=Texnologiya sektoru"
        
        
        let PULLULINK = "https://pullu.az/api/androidmobileapp/user/signUp"
        let Parameters = ["name": newUserData.name!, "surname": newUserData.surname!, "mail":newUserData.mail!, "pass": newUserData.pass!,"phone":newUserData.phone!,"bDate":newUserData.bDate!,"gender":newUserData.gender!,"country":newUserData.country!,"city":newUserData.city!,"profession":newUserData.sector!]
        
        
        
        request(PULLULINK ,method: .get,parameters: Parameters, encoding: URLEncoding(destination: .queryString)).responseJSON
            {
                (response)
                in
                
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
    func earnMoney(advertID:Int?,mail:String?,pass:String?,completionBlock: @escaping (_ result:EarnMoney) ->()){
        
        
        
        let PULLULINK = "https://pullu.az/api/androidmobileapp/earnMoney"
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
    
    // forgot pass / mail yoxlanishi
    func sendPassChangeMail(mail:String ,completionBlock: @escaping (_ result:Status) ->()){
        
        
        
        
        let PULLULINK = "https://pullu.az/api/androidmobileapp/accounts/password/reset/send/mail"
        let Parameters = ["mail": mail] as [String : Any]
        
        
        
        request(PULLULINK ,method: .get,parameters: Parameters, encoding: URLEncoding(destination: .queryString)).responseJSON
            {
                (response)
                in
                
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
    // forgot pass / 4 regemli shifre yoxlanishi
    func checkSendCode(mail:String, code:String ,completionBlock: @escaping (_ result:Status) ->()){
        
        
        
        
        let PULLULINK = "https://pullu.az/api/androidmobileapp/accounts/password/reset/confirm"
        let Parameters = ["mail": mail,"code": code] as [String : Any]
        
        
        request(PULLULINK ,method: .get,parameters: Parameters, encoding: URLEncoding(destination: .queryString)).responseJSON
            {
                (response)
                in
                
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
    // forgot pass/ yeni şifrə yaratmaq
    func createNewPass(newpass:String ,mail:String, code:String ,completionBlock: @escaping (_ result:Status) ->()){
        
        
        
        
        let PULLULINK = "https://pullu.az/api/androidmobileapp/accounts/password/reset/newpass"
        let Parameters = ["newpass":newpass, "mail": mail,"code": code] as [String : Any]
        
        
        
        request(PULLULINK ,method: .get,parameters: Parameters, encoding: URLEncoding(destination: .queryString)).responseJSON
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
    
    
    
    
    //    jsonBody:String
    
    
    func mimeType(for data: Data) -> String {
        
        var b: UInt8 = 0
        data.copyBytes(to: &b, count: 1)
        
        switch b {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x4D, 0x49:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        case 0x46:
            return "text/plain"
        default:
            return "application/octet-stream"
        }
    }
    
    //profil uptade
    func profilUptade(newpass:String ,mail:String, code:String ,completionBlock: @escaping (_ result:Status) ->()){
        
        
        
        
        let PULLULINK = "https://pullu.az/api/androidmobileapp/user/uptade/profile"
        let Parameters = ["newpass":newpass, "mail": mail,"code": code] as [String : Any]
        
        
        
        request(PULLULINK ,method: .get,parameters: Parameters, encoding: URLEncoding(destination: .queryString)).responseJSON
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
    
    func addAdvertisement(newAdvertisement:NewAdvertisementStruct?,progressView:UIProgressView, completionBlock: @escaping (_ result:Status) ->()){
        
        
        
        
        let PULLULINK = "https://pullu.az/api/androidmobileapp/user/advertisements/add"
        
       // let PULLULINK = "http://127.0.0.1:44301/api/androidmobileapp/user/advertisements/add"
        //        var request = URLRequest(url: URL(string: PULLULINK)!)
        //        request.httpMethod = HTTPMethod.post.rawValue
        //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //
        //
        //        let data = (jsonBody.data(using: .utf8))! as Data
        //
        //        request.httpBody = data
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                //                    multipartFormData.append((newAdvertisement?.aBackgroundUrl!.data(using: .utf8)!)!, withName: "aBackgroundUrl")
                multipartFormData.append(("\(newAdvertisement!.aAgeRangeID!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "aAgeRangeID")
                multipartFormData.append(("\(newAdvertisement!.aCategoryID!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "aCategoryID")
                if newAdvertisement!.files != nil  {
                    for file in newAdvertisement!.files! {
                                       let mimeType = self.mimeType(for: file)
                                       let ext = mimeType.components(separatedBy: "/")
                                       //                    if mimeType == "image/jpeg" || mimeType == "image/png" || mimeType == "image/gif"
                                       //                    {
                                       
                                       
                                       multipartFormData.append(file, withName: "files", fileName: "\(Date().timeIntervalSince1970).\(ext[1])", mimeType: mimeType)
                                       //}
                                       
                                   }
                }
               
                
                multipartFormData.append(("\(newAdvertisement!.aBackgroundUrl ?? "")".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "aBackgroundUrl")
                multipartFormData.append(("\(newAdvertisement!.aCityID!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "aCityID")
                multipartFormData.append(("\(newAdvertisement!.aCountryID!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "aCountryID")
                multipartFormData.append(("\(newAdvertisement!.aDescription!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "aDescription")
                
                multipartFormData.append(("\(newAdvertisement!.aGenderID!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "aGenderID")
                multipartFormData.append(("\(newAdvertisement!.aMediaTypeID!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "aMediaTypeId")
                multipartFormData.append(("\(newAdvertisement!.aPrice!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "aPrice")
                multipartFormData.append(("\(newAdvertisement!.aTrfID ?? 0)".data(using: .utf8)!), withName: "aTrfID")
                multipartFormData.append(("\(newAdvertisement!.aProfessionID!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "aProfessionID")
                multipartFormData.append(("\(newAdvertisement!.aTitle!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "aTitle")
                //                    multipartFormData.append(("\(newAdvertisement?.aTrfID!)".data(using: .utf8)!), withName: "aTrfID")
                multipartFormData.append(("\(newAdvertisement!.aTypeID!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "aTypeId")
                multipartFormData.append(("\(newAdvertisement!.isPaid!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "isPaid")
                multipartFormData.append(("\(newAdvertisement!.mail!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "mail")
                multipartFormData.append(("\(newAdvertisement!.pass!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "pass")
                //multipartFormData.append(newAdvertisement., withName: "aCategoryID")
                //multipartFormData.append(("\(newAdvertisement!.pass!)".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "password")
        },
            to: PULLULINK,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        //  print("Upload Progress: \(progress.fractionCompleted)")
                        DispatchQueue.main.async {
                            
//
                        progressView.setProgress(Float(progress.fractionCompleted), animated: true)
                        }
                    })
                    upload.responseData { response in
                        debugPrint(response)
                        do{
                            
                            
                            let statusCode  = try
                                JSONDecoder().decode(Status.self, from: response.data!)
                            // userList=list
                            
                            
                            completionBlock(statusCode)
                            
                            
                        }
                        catch let jsonErr{
                            print("Error serializing json:",jsonErr)
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    
                }
        }
        )
        
        //     Alamofire.request(request)
        //        .downloadProgress{(progress) in  print("progess!", Float(progress.fractionCompleted)) }
        //        .responseJSON { (response) in
        //
        //
        //
        //            //print(PULLULINK)
        //
        //            do{
        //
        //
        //                let statusCode  = try
        //                    JSONDecoder().decode(Status.self, from: response.data!)
        //                // userList=list
        //
        //
        //                completionBlock(statusCode)
        //
        //
        //            }
        //            catch let jsonErr{
        //                print("Error serializing json:",jsonErr)
        //            }
        //
        //        }
        
    }
}
