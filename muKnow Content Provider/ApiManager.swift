//
//  ApiManager.swift
//  Muknow
//
//  Created by Admin on 21/02/2018 .
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import Alamofire
import MobileCoreServices


struct WebServices {
 
    
    
//    static let BASE_URL = "https://lessonsgowhere.com.sg/"
//    static let ARTICLE_BASE_URL = "http://devadmin.mu-know.com/"
    
//    http://devservices.mu-know.com/smiles_trainer_login?email=train3@yopmail.com&password=qwe123
    
    
    //Staging
    static let BASE_URL_SERVICE = "http://stgservices.mu-know.com/"
    
    /*
    //dev
    static let BASE_URL_SERVICE = "http://devservices.mu-know.com/" */
    
    static let Login = "smiles_trainer_login"
    static let REGISTRATION = "smiles_add_trainer_users"
    static let OTP_SUCCESS = "smiles_registered_trainers_otp_validation"
    static let FORGET_PWD = "smiles_forgotpassword_trainers_otp"
    static let FORGET_PWD_OTP = "smiles_forgotpassword_otp_validation_trainers"
    static let CHANGE_PWD = "smiles_reset_password_trainers"
    static let DASHBOARD = "smiles_trainer_dashboardlist"
    static let ARTICLE_LIST = "smiles_trainer_articles_list"
    static let ARTICLE_DETAIL = "smiles_trainer_articles_list_quiz_list"
    static let RESEND_OTP = "smiles_trainer_register_resendemail_otp"
    static let REVIEWS = "smiles_reviews_articles_trainer"
} 


class ApiManager : NSObject {
 
    func getRequest(service:String,param:String, completion: @escaping (_ result:Any,_ success:Bool) -> ())
        {
            let urlString = WebServices.BASE_URL_SERVICE + service + "/" + param
            let serviceUrl = URL(string: urlString)
          print("service url is = ",serviceUrl!)
            if !(Alamofire.NetworkReachabilityManager()?.isReachable)!
            {
                completion("The Internet connection appears to be offline.",false)
                return
            }
            
            AF.request(serviceUrl!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON
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
    func postRequestWithParameters(service:String,params: [String:Any], completion: @escaping (_ result:Any,_ success:Bool) -> ())
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

    func postRequest(service:String,params: String, completion: @escaping (_ result:Any,_ success:Bool) -> ())
        {
            let urlString = WebServices.BASE_URL_SERVICE + service + "/" + params
            let serviceUrl = URL(string: urlString)
           print(serviceUrl!)
            if !(Alamofire.NetworkReachabilityManager()?.isReachable)!
            {
                completion("The Internet connection appears to be offline.",false)
                return
            }
            
        AF.request(serviceUrl!, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON
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
    
    /*
    func registrationWithImage(imageToUpload:UIImage,service:String,params: [String:Any], completion: @escaping (_ result:Any,_ success:Bool) -> ())
    {
        let urlString = WebServices.BASE_URL_SERVICE + service
        let serviceUrl = URL(string: urlString)
        print(serviceUrl!)
        if !(Alamofire.NetworkReachabilityManager()?.isReachable)!
        {
            completion("The Internet connection appears to be offline.",false)
            return
        }
    
        let headers: HTTPHeaders = [
              /* "Authorization": "your_access_token",  in case you need authorization header */
              "Content-type": "multipart/form-data"
          ]
        
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                   multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
               }
            if let imageData = imageToUpload.jpegData(compressionQuality: 1) {
              multipartFormData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/png")
            }
        }, to: serviceUrl!,method: .post,headers: headers).responseJSON { (jsonResp) in
            print("REsponse from Image Upload is : ",jsonResp)
        }
    } */
    
    
    
    

    

    func uploadImageRequest3(imageToUpload:UIImage,service:String,params: [String:Any], completion: @escaping (_ result:Any,_ success:Bool) -> ())
    {
        let urlString = WebServices.BASE_URL_SERVICE + service
        let serviceUrl = URL(string: urlString)
        print(serviceUrl!)
        if !(Alamofire.NetworkReachabilityManager()?.isReachable)!
        {
            completion("The Internet connection appears to be offline.",false)
            return
        }
    
        let headers: HTTPHeaders = [
              "Content-type": "multipart/form-data"
          ]
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                   multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
               }
            if let imageData = imageToUpload.jpegData(compressionQuality: 1) {
              multipartFormData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/png")
            }
        }, to: serviceUrl!,method: .post,headers: headers).responseJSON { (jsonResp) in
            print("Response from Image Upload is : ",jsonResp)
            
            switch jsonResp.result {
            case .failure(let error):
                print("FAil....",error)
                completion(jsonResp,false)
            case .success( _):
                
                print("response ---",jsonResp.response)
                print("result ---",jsonResp.result)
                print("value ---",jsonResp.value!)
                print("data ---",jsonResp.data)
                completion(jsonResp.value,true)
            }
        }
        
        ;
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

extension Data {
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
