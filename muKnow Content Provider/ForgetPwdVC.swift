//
//  ForgetPwdVC.swift
//  muKnow Content Provider
//
//  Created by Apple on 16/03/21.
//

import UIKit

class ForgetPwdVC: UIViewController {

    @IBOutlet var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func submit_Tapped(_ sender: Any) {
        
        
        
        
        if self.txtEmail.text == "" {
            self.showAlert(message: "Enter Email")
        }
        if !(txtEmail.text?.isValidEmail())! {
            self.showAlert(message: "Please Enter valid Email")
            return
        }
        
        // web service integration for Forget PW
        let paramsDict = [
            "email":self.txtEmail.text!
        ]
        
        
        
        print("\(paramsDict)")
        
        self.view.StartLoading()
        
        ApiManager().postRequestWithParameters(service:WebServices.FORGET_PWD, params: paramsDict)
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
                print("FORGET_PWD Response = \(resultDictionary)")
//                ["message": Mail sent successfully, "result": 1, "otp_id": 37, "id": 27274]
                
                
                /*
                let forgotVc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPwOTPViewController") as! ForgetPwOTPViewController
               
                forgotVc.EmailId = self.txtEmail.text!
                forgotVc.OtpId = resultDictionary["otp_id"] as? String
                
                
                self.present(forgotVc, animated: true, completion: nil)*/
                
                let apiResponse = resultDictionary
                let dataDict = apiResponse["data"] as! [String : Any]
                let responseDict = dataDict["response"] as! NSDictionary
                
                let msg = "\(responseDict["message"]!)"
                let status = "\(responseDict["status"]!)"
                
                let keyExists = resultDictionary["error"] != nil
                if keyExists{
                    
                    /*let valDict = resultDictionary["error"] as! [String : Any]
                    let msg = valDict["email"]! as! String */
                    
                    DispatchQueue.main.async {
                        self.showAlert(message: "The email must be a valid email address")
                    }
                    
                }else if status == "0"{
                    DispatchQueue.main.async {
                        self.showAlert(message: msg)
                    }
                }
                else {
                    let forgotVc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPwOTPViewControllerSBID") as! ForgetPwOTPViewController
                                  
                                   forgotVc.EmailId = self.txtEmail.text!
//                                   forgotVc.OtpId = resultDictionary["otp_id"] as? String
//                    forgotVc.idFromFirstResponse = "\(resultDictionary["id"]!)" //resultDictionary["id"] as? String
                                   
                                   
                                   self.present(forgotVc, animated: true, completion: nil)
                }
                
                
            }
            
        }
      
        //        let forgotVc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPwOTPViewController") as! ForgetPwOTPViewController
        //        self.present(forgotVc, animated: true, completion: nil)
        
        
    }
    
    @IBAction func back_VC(_ sender: Any) {
        
         let forgotVc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVCSBID") as! LoginVC
        self.present(forgotVc, animated: true, completion: nil)
        
    }
    
    func showAlert(message:String)
       {
           Message.shared.Alert(Title:APP_NAME, Message: message, TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithOutSelector(Title: "Ok")], Controller: self)
       }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
