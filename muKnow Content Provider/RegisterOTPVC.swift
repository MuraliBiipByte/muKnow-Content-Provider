//
//  RegisterOTPVC.swift
//  muKnow Content Provider
//
//  Created by Apple on 08/03/21.
//

import UIKit

class RegisterOTPVC: UIViewController {

    @IBOutlet var OTPTxt: UITextField!
    
    var params : [String:Any] = [:]
    var paramsForResendOTP : [String:Any] = [:]
    //var id : String?
    var email : String?
    var doNeedToPop : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        showAlert(message: "Mail Sent Successfully")
        
    }
    @IBAction func back_VC(_ sender: Any) {
        if doNeedToPop{
            self.navigationController?.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func showAlert(message:String)
    {
        Message.shared.Alert(Title:APP_NAME, Message: message, TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithOutSelector(Title: "Ok")], Controller: self)
    }
    func showAlertWithAction(message:String,selector:Selector)
     {
         Message.shared.Alert(Title:APP_NAME, Message: message, TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithSelector(Title: "Ok", Selector:selector, Controller: self)], Controller: self)
     }
    
    @IBAction func submitOtp_Tapped(_ sender: Any) {
        
        if self.OTPTxt.text == "" {
            self.showAlert(message: "Enter OTP sent to your Email")
        }else{
            params["email_otp"] = self.OTPTxt.text
            params["email_id"] = self.email
            
            print("RegisterOTP Params = ",params)
            self.sendOTP()
        }
    }
    
    func sendOTP() {
        
        self.view.StartLoading()
        ApiManager().postRequestWithParameters(service:WebServices.OTP_SUCCESS, params: params as [String : Any])
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
                print("Submit Btn Tapped : \(resultDictionary)")
                
                
                let apiResponse = result as! [String : Any]
                let dataDict = apiResponse["data"] as! [String : Any]
                let responseDict = dataDict["response"] as! NSDictionary
                
                /*
                let msg = responseDict["message"]! as! String
                if msg == "Not Verified" {
                    DispatchQueue.main.async {
                        //self.showAlert(message: "Invalid OTP")
                        self.showAlert(message: msg)
                    }
                }else{
//                    UserDefaults.standard.set(self.params["email"], forKey: "user_email")
//                    UserDefaults.standard.set(self.params["id"], forKey: "user_id")

                    
                    self.showAlertWithAction(message: "Registered successfully", selector:#selector(self.moveToLoginPage))
                } */
                
                let msg = responseDict["message"]! as! String
                let status = "\(responseDict["status"]!)"
                if status == "0" {
                    DispatchQueue.main.async {
                        //self.showAlert(message: "Invalid OTP")
                        self.showAlert(message: msg)
                    }
                }else{
//                    UserDefaults.standard.set(self.params["email"], forKey: "user_email")
//                    UserDefaults.standard.set(self.params["id"], forKey: "user_id")

                    
                    self.showAlertWithAction(message: "Registered successfully", selector:#selector(self.moveToLoginPage))
                }
                
            }
        }
    }
    
    @objc func moveToLoginPage()
    {
        let loginVc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVCSBID") as! LoginVC
        self.present(loginVc, animated: true, completion: nil)
                        
        
    }

    @IBAction func resendOTPBtnTapped(_ sender: UIButton) {
        
        /*
        self.view.StartLoading()
        ApiManager().postRequest(service: WebServices.REGISTRATION, params: self.params) { (result, success) in
            self.view.StopLoading()
            if success == false
            {
                self.showAlert(message: result as! String)
                return
                
            }
            else
            {
                let resultDictionary = result as! [String : Any]
                _ = User(userDictionay: resultDictionary)
                print("OTP Resent.....")
                self.showAlert(message: "Mail Sent Successfully")
                print(resultDictionary)
                self.id = "\(resultDictionary["id"]!)"
            }
        } */
        self.paramsForResendOTP["email_id"] = self.email
        self.view.StartLoading()
        ApiManager().postRequestWithParameters(service:WebServices.RESEND_OTP, params: paramsForResendOTP as [String : Any]){
            (result, success) in
            self.view.StopLoading()
            if success == false
            {
                self.showAlert(message: result as! String)
                return
            }else{
                let resultDictionary = result as! [String:Any]
                print("\(resultDictionary)")
                
                
                let apiResponse = result as! [String : Any]
                let dataDict = apiResponse["data"] as! [String : Any]
                let responseDict = dataDict["response"] as! NSDictionary
                
                let msg = responseDict["message"]! as! String
                self.showAlert(message: msg)
            }
        }
        
        /*
        ApiManager().postRequest(service: WebServices.RESEND_OTP, params: self.email!) { (result, success) in
            self.view.StopLoading()
            if success == false
            {
                self.showAlert(message: result as! String)
                return
            }else{
                let resultDictionary = result as! [String:Any]
                print("\(resultDictionary)")
                
                
                let apiResponse = result as! [String : Any]
                let dataDict = apiResponse["data"] as! [String : Any]
                let responseDict = dataDict["response"] as! NSDictionary
                
                let msg = responseDict["message"]! as! String
                self.showAlert(message: msg)
            }
        } */
        
        
    }
    
}
