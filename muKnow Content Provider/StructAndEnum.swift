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
    var trainerId : String!
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
struct QAStruct {
    var Question : String!
    var answer1 : String!
    var answer2 : String!
    var answer3 : String!
    var answer4 : String!
    
    var isOption1Tapped : Bool!
    var isOption2Tapped : Bool!
    var isOption3Tapped : Bool!
    var isOption4Tapped : Bool!
    
    var isAnswerImgViewHidden : Bool!
    var isSubmitBtnTapped : Bool!
    
    var actualAnwser : String!
    var selectedAnswer : String!
    
}
