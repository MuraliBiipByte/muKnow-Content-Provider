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
    static let BASE_URL = ""
//    static let BASE_URL = "https://lessonsgowhere.com.sg/"
//    static let ARTICLE_BASE_URL = "http://devadmin.mu-know.com/"
    
//    http://devservices.mu-know.com/smiles_trainer_login?email=train3@yopmail.com&password=qwe123
    
    static let Login = "smiles_trainer_login"
    static let REGISTRATION = "smiles_add_trainer_users"
    static let OTP_SUCCESS = "smiles_registered_trainers_otp_validation"
    static let FORGET_PWD = "smiles_forgotpassword_trainers_otp"
    static let FORGET_PWD_OTP = "smiles_forgotpassword_otp_validation_trainers"
    static let CHANGE_PWD = "smiles_reset_password_trainers"
    static let DASHBOARD = "smiles_trainer_dashboardlist"
}


class ApiManager {
 
   
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
        AF.upload(
                  multipartFormData: { multipartFormData in
                    for (key, value) in params {
                           multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                       }
                    if let imageData = imageToUpload.jpegData(compressionQuality: 1) {
                      multipartFormData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/png")
                    }
              }
        ,
                  to: serviceUrl!, method: .post , headers: headers)
                  .response { resp in
                      print("REsponse from Image Upload is : ",resp)
//                    print("RESult from Image Upload is : ",Result)
                    
                    
                    /*
                     switch resp.result {
                    case .failure(let error):
                        print("FAil....",error)
                        completion(resp,false)
                        
                    case .success(let data):
                      //print(resp.result)
                      
                       let jsonResponse = data as! [String : Any]
                      print("The Json = ",jsonResponse)
                     
                       completion(jsonResponse,true)
                      
 
                      break
                        
                        /*
                    case .success( _):
                        print("sucess ---",resp.result)
                        print("resp.response ----",resp.response as Any)
                        //resp.response
                        
                        let jsonResponse = resp.response as Any
                        print("The Json is = ",jsonResponse)
                        
                        completion(resp,true) */
                    }*/
                    switch resp.result {
                    case .failure(let error):
                        print("FAil....",error)
                        completion(resp,false)
                    case .success( _):
                        print("sucess ---",resp.result)
                        completion(resp,true)
                    }
                    
              }
        
       /* AF.upload(
                  multipartFormData: { multipartFormData in
                    for (key, value) in params {
                           multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                       }
                    if let imageData = imageToUpload.jpegData(compressionQuality: 1) {
                      multipartFormData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/png")
                    }
              }
        ,
            to: serviceUrl!, method: .post , headers: headers).responseJSON { (data) in
                print("REsponse from Image Upload is : ",data)
//                    print("RESult from Image Upload is : ",Result)
                
              completion(data,true)
            } */
        
        
        
        
        
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in params {
//                   multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//               }
//            if let imageData = imageToUpload.jpegData(compressionQuality: 1) {
//              multipartFormData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/png")
//            }
//
//        }, usingThreshold: UInt64.init(), to: serviceUrl!, method: .post, headers: headers) { (result) in
//            switch result{
//            case .success(let upload, _, _):
//                upload.responseJSON { response in
//                    print("Succesfully uploaded")
//                    if let err = response.error{
//                        onError?(err)
//                        return
//                    }
//                    onCompletion?(nil)
//                }
//            case .failure(let error):
//                print("Error in upload: \(error.localizedDescription)")
//                onError?(error)
//            }
//        }
        
//        AF.upload(multipartFormData: { (multipart: MultipartFormData) in
//            for (key, value) in params {
//                   multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//               }
//            if let imageData = imageToUpload.jpegData(compressionQuality: 1) {
//              multipartFormData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/png")
//            }
//            },usingThreshold: UInt64.init(),
//               to: serviceUrl!,
//               method: .post,
//               headers: headers,
//               encodingCompletion: { (result) in
//                switch result {
//                case .success(let upload, _, _):
//                    upload.uploadProgress(closure: { (progress) in
//                      print("Uploading")
//                    })
//                    break
//                case .failure(let encodingError):
//                    print("err is \(encodingError)")
//                        break
//                    }
//                })
                  
                  
        
        
        
        
        
        
        
        
        
        /* if let data = data,
            let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
            print(urlContent)
        } else {
            print("Error: \(error)")
        }*/
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
