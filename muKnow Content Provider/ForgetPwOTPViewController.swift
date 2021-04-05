//
//  ForgetPwOTPViewController.swift
//  Muknow
//
//  Created by Admin on 21/02/2018 .
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ForgetPwOTPViewController: UIViewController {

    @IBOutlet var otpTxt: UITextField!
    
    var OtpId : String?
    var EmailId : String?
//    var idFromFirstResponse : String?

    var paramsDict : [String:Any] = [:]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        otpTxt.keyboardType = .default
        paramsDict = [
                   "email_id":self.EmailId!,
                   "email_otp":otpTxt.text!
                   //"id":self.OtpId!
                        ]
        
    }
    override func viewDidAppear(_ animated: Bool) {
        showAlert(message: "OTP sent to \(self.EmailId!)")
    }
    
    @IBAction func submit_OTP_Tapped(_ sender: Any) {
        
        
        if self.otpTxt.text == "" {
            self.showAlert(message: "Enter OTP sent to your Email")
            return
        }else{
            paramsDict["email_otp"] = otpTxt.text!
        }
        
       
        print("\(paramsDict) while Submitting")

        ApiManager().postRequestWithParameters(service:WebServices.FORGET_PWD_OTP, params: paramsDict as [String : Any])
        { (result, success) in
            self.view.StopLoading()
            
            if success == false
            {
                self.showAlert(message: result as! String )
                return
            }
            else
            {
                let resultDictionary = result as! [String:Any]
                /*print("\(resultDictionary)")
                let changePwVc = self.storyboard?.instantiateViewController(withIdentifier: "ChangeNewPWViewController") as! ChangeNewPWViewController
                changePwVc.EmailId = self.EmailId
                changePwVc.otpId = self.OtpId
                self.present(changePwVc, animated: true, completion: nil) */
                print("\(resultDictionary) submitting response....")
                
                
                let apiResponse = resultDictionary
                let dataDict = apiResponse["data"] as! [String : Any]
                let responseDict = dataDict["response"] as! NSDictionary
                
                //let msg = "\(responseDict["message"]!)"
                let status = "\(responseDict["status"]!)"
                
                
                //let msg = message //"\(resultDictionary["message"]!)"
                
                
                let keyExists = resultDictionary["error"] != nil
                if keyExists{
                    
                    /*let valDict = resultDictionary["error"] as! [String : Any]
                    let msg = valDict["email"]! as! String */
                    
                    DispatchQueue.main.async {
                        self.showAlert(message: "OTP Not Valid")
                    }
                    
                }
                //else if msg == "Valid OTP."{
                else if status == "1"{
                    let changePwVc = self.storyboard?.instantiateViewController(withIdentifier: "ChangeNewPWViewControllerSBID") as! ChangeNewPWViewController
                                   changePwVc.EmailId = self.EmailId
                                   //changePwVc.otpId = self.OtpId
                                    changePwVc.otpStr =  self.otpTxt.text!
                    //changePwVc.idFromFirstResponse = self.idFromFirstResponse
                                   self.present(changePwVc, animated: true, completion: nil)
                }
                //else if msg == "Invalid OTP / Expired."{
                else if status == "0" {
                    DispatchQueue.main.async {
                        self.showAlert(message: "Invalid OTP / Expired.")
                    }
                }
            }
            
        }
     
    }

    
    func showAlert(message:String)
        {
            Message.shared.Alert(Title:APP_NAME, Message: message, TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithOutSelector(Title: "Ok")], Controller: self)
        }
      
    
    
    @IBAction func back_vc(_ sender: Any) {
        let forgotVc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVCSBID") as! LoginVC
        self.present(forgotVc, animated: true, completion: nil)
    }
    
    @IBAction func resend_OTP_Tapped(_ sender: Any) {
        
                self.view.StartLoading()
                
        let resendParamsDict : [String:Any] = [
            "email":EmailId!
        ]
      //ApiManager().postRequestToGetAccessToken(service:WebServices.FORGET_PWD, params: paramsDict)
        ApiManager().postRequestWithParameters(service:WebServices.FORGET_PWD, params: resendParamsDict)
                { (result, success) in
                    self.view.StopLoading()
                    
                    if success == false
                    {
                        self.showAlert(message: result as! String )
                        return
                    }
                    else
                    {
                        let resultDictionary = result as! [String:Any]
                        print("\(resultDictionary) while resend...")
                        
        //                ["message": Mail sent successfully, "result": 1, "otp_id": 37, "id": 27274]
                        self.showAlert(message: "Mail sent Successfully")
                        
                        self.OtpId = resultDictionary["otp_id"] as? String
                        self.paramsDict["id"] = self.OtpId
                    }
                    
                }
    }
    

}
