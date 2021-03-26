//
//  StructAndEnum.swift
//  muKnow Content Provider
//
//  Created by Apple on 10/03/21.
//

import UIKit


struct LoginDetails {
    var email:String!
    var password:String!
}

struct LoginResponse {
    var message : String!
    var status : String!
    //    var TrainDetailArr = [Trainer]()
    var id : String!
    var userName : String!
    var email : String!
    var userType : String!
    var active : String!
    var imageUrl : String!

}
//struct Trainer{
//    var id : String!
//    var userName : String!
//    var email : String!
//    var userType : String!
//    var active : String!
//    var imageUrl : String!
//}
