//
//  LocalStorage.swift
//  muKnow Content Provider
//
//  Created by Apple on 08/03/21.
//
import UIKit

func SaveLoginResponse(Struct:LoginResponse) {
    
    var SaveDict = [String:Any]()
    SaveDict = ["message":"\(Struct.message!)",
                "status":"\(Struct.status!)",
                "trainerId" : "\(Struct.trainerId!)",
                "userName" : "\(Struct.userName!)",
                "email" : "\(Struct.email!)",
                "phoneNo" : "\(Struct.phoneNo!)",
                "userType" : "\(Struct.userType!)",
                "active" : "\(Struct.active!)",
                "imageUrl" : "\(Struct.imageUrl!)"
    ]
    
    let Defaults = UserDefaults.standard
    let data = try? JSONSerialization.data(withJSONObject: SaveDict, options: .prettyPrinted)
    Defaults.set(data, forKey: "LoginResponse")
    Defaults.synchronize()
    
}

func fetchLoginResponse() -> LoginResponse? {
    
    if UserDefaults.standard.value(forKey: "LoginResponse") != nil {
        
        if let ResponceDict:[String:AnyObject] = try! JSONSerialization.jsonObject(with:UserDefaults.standard.value(forKey: "LoginResponse") as! Data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject] {
            
            var LoginObj = LoginResponse()
            LoginObj.message = "\(ResponceDict["message"]!)"
            LoginObj.status = "\(ResponceDict["status"]!)"
            LoginObj.trainerId = "\(ResponceDict["trainerId"]!)"
            LoginObj.userName = "\(ResponceDict["userName"]!)"
            LoginObj.email = "\(ResponceDict["email"]!)"
            LoginObj.userType = "\(ResponceDict["userType"]!)"
            LoginObj.phoneNo = "\(ResponceDict["phoneNo"]!)"
            LoginObj.active = "\(ResponceDict["active"]!)"
            LoginObj.imageUrl = "\(ResponceDict["imageUrl"]!)"

            return LoginObj
        }
        else {
            
            return nil
        }
    }
    else {
        return nil
    }
}
