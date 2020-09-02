//
//  PaymentOperation.swift
//  pullu.test
//
//  Created by Rufat Asadov on 7/19/20.
//  Copyright © 2020 Rufat Asadzade. All rights reserved.
//

import Foundation
import Alamofire
import MBProgressHUD
public class PaymentOperation {
    
    func GetWithdrawServices(completionBlock: @escaping (_ result:ResponseStruct<WithdrawService>) ->()){
                
                         //let PULLULINK = "http://pullu.az:81/api/androidmobileapp/accounts/verify/otp"
                         let PULLULINK = "https://pullu.az/api/payment/get/withdraw/services"
                        request(PULLULINK ,method: .get, encoding: URLEncoding(destination: .queryString)).responseJSON
                            {
                                (response)
                                in
                                //  print(PULLULINK)
                                
                                do{
                                    
                                    
                                    let statusCode  = try
                                        JSONDecoder().decode(ResponseStruct<WithdrawService>.self, from: response.data!)
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
