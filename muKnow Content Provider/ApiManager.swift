//
//  ApiManager.swift
//  Muknow
//
//  Created by Admin on 21/02/2018 .
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import Alamofire


struct WebServices {
 
    //dev
    static let BASE_URL_SERVICE = "http://devservices.mu-know.com/"
//    static let BASE_URL = "https://lessonsgowhere.com.sg/"
//    static let ARTICLE_BASE_URL = "http://devadmin.mu-know.com/"
    
//    http://devservices.mu-know.com/smiles_trainer_login?email=train3@yopmail.com&password=qwe123
    
    static let Login = "smiles_trainer_login"
    static let REGISTRATION = "smiles_add_trainer_users"
    static let OTP_SUCCESS = "smiles_registered_trainers_otp_validation"
    static let FORGET_PWD = "smiles_forgotpassword_trainers_otp"
    static let FORGET_PWD_OTP = "smiles_forgotpassword_otp_validation_trainers"
    static let CHANGE_PWD = "smiles_reset_password_trainers"
}


class ApiManager {
 
    func getRequestWithParameters(service:String,params: [String:Any], completion: @escaping (_ result:Any,_ success:Bool) -> ())
        {
            let urlString = WebServices.BASE_URL_SERVICE + service
            let serviceUrl = URL(string: urlString)
           print(serviceUrl!)
            if !(Alamofire.NetworkReachabilityManager()?.isReachable)!
            {
                completion("The Internet connection appears to be offline.",false)
                return
            }
            
        AF.request(serviceUrl!, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON
                {(response:DataResponse) in
                    
                    switch response.result
                    {
                      case .success(let data):
                        print(response.result)
                        
                         let jsonResponse = data as! [String : Any]
                        print(jsonResponse)
                       
                         completion(jsonResponse,true)
                        
   
                        break
                    case .failure(let error):
                        print(response.result)
                        completion(error.localizedDescription,false)
                        break
                    }
            }
        }

    
    enum ResponceCodes
    {
        case success, authError, badRequest, requestTimeOut, internalServerError, serviceUnavailable, notFound, forbidden, OtherError, NoInternet
        
        func GetResponceCode() -> Int
        {
            var result: Int = 0
            switch self
            {
            case .success:
                result = 200
            case .authError:
                result = 401
            case .badRequest:
                result = 400
            case .requestTimeOut:
                result = 408
            case .internalServerError:
                result = 500
            case .serviceUnavailable:
                result = 503
            case .notFound:
                result = 404
            case .forbidden:
                result = 403
            case .NoInternet:
                result = 007
            case .OtherError:
                result = 0
            }
            return result
        }
    }
    
    
}
