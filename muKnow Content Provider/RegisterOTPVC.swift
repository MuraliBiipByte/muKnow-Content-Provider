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
    var id : String?
    var email : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        showAlert(message: "Mail Sent Successfully")
        
    }
    @IBAction func back_VC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        ApiManager().getRequestWithParameters(service:WebServices.OTP_SUCCESS, params: params as [String : Any])
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
                print("\(resultDictionary)")
                
                
                let apiResponse = result as! [String : Any]
                let dataDict = apiResponse["data"] as! [String : Any]
                let responseDict = dataDict["response"] as! NSDictionary
                
                
                let msg = responseDict["message"]! as! String
                if msg == "Invalid OTP" {
                    DispatchQueue.main.async {
                        self.showAlert(message: "Invalid OTP")
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

}
