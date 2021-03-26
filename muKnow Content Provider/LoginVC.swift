//
//  ViewController.swift
//  muKnow Content Provider
//
//  Created by Apple on 02/03/21.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        
    }
    
    func showAlert(message:String)
    {
        Message.shared.Alert(Title:APP_NAME, Message: message, TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithOutSelector(Title: "Ok")], Controller: self)
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        if self.txtEmail.text == "" {
//            Message.AlertActionWithOutSelector(Title: "Enter Email")
            self.showAlert(message: "Enter Email")
            return
        }
        

        if !(txtEmail.text?.isValidEmail())! {
                self.showAlert(message: "Please Enter valid Email")
                return
        }
                
        else if self.txtPassword.text == "" {
            self.showAlert(message: "Enter Password")
            return
        }
        
        let paramsDict = [
            "email":self.txtEmail.text!,
            "password":self.txtPassword.text!]
           print("Login Param : \(paramsDict)")
        
        
        self.view.StartLoading()
        
        
        
        
        ApiManager().getRequestWithParameters(service: WebServices.Login, params: paramsDict, completion:
                { (result, success) in
                    
            
            self.view.StopLoading()
            
            if success == false
            {
                self.showAlert(message: result as! String)
                return
            }
            else
            {
                let apiResponse = result as! [String : Any]
                let dataDict = apiResponse["data"] as! [String : Any]
                let message = "\(dataDict["message"]!)"
                let status = "\(dataDict["status"]!)"
                print("message = ",message)
                print("Status = ",status)
                
                let responseDict = dataDict["response"] as! NSDictionary
                let trainerDetailsArr = responseDict["trainer_details"] as! NSArray //[String : Any]
                let trainerDict = trainerDetailsArr[0] as! NSDictionary
                
                let trainerId = "\(trainerDict.value(forKey: "id")!)"
                let username = "\(trainerDict.value(forKey: "username")!)"
                let email = "\(trainerDict.value(forKey: "email")!)"
                let user_type = "\(trainerDict.value(forKey: "user_type")!)"
                let active = "\(trainerDict.value(forKey: "active")!)"
                let image_url = "\(trainerDict.value(forKey: "image_url")!)"
                
                
                var aLoginResponseStruct = LoginResponse()
                aLoginResponseStruct.message = message
                 aLoginResponseStruct.status = status
                aLoginResponseStruct.id = trainerId
                aLoginResponseStruct.userName = username
                aLoginResponseStruct.email = email
                aLoginResponseStruct.userType = user_type
                aLoginResponseStruct.active = active
                aLoginResponseStruct.imageUrl = image_url
                
                /* var aTrainerStruct = Trainer()
                aTrainerStruct.id = trainerId
                aTrainerStruct.userName = username
                aTrainerStruct.email = email
                aTrainerStruct.userType = user_type
                aTrainerStruct.active = active
                aTrainerStruct.imageUrl = image_url
                
                aLoginResponseStruct.TrainDetailArr.append(aTrainerStruct) */
                
                SaveLoginResponse(Struct: aLoginResponseStruct)
                
//                self.navigationController?.dismiss(animated: true, completion: nil)
//                self.navigationController?.present(loginVCObj!, animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
                
                
            }
        })

    }
    @IBAction func signupBtnTapped(_ sender: UIButton) {
        let registrationVCObj = UIStoryboard.MainStoryBoard.RegistrationVC()
//        self.navigationController?.pushViewController(registrationVCObj!, animated: true)
//        self.navigationController?.present(registrationVCObj!, animated: true, completion: nil)
        self.present(registrationVCObj!, animated: true, completion: nil)
    }
    
    @IBAction func forgotPassword_Tapped(_ sender: Any) {
//        let abcd = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPwdVCSBID") as! ForgetPwdVC
        
//        let forgotVc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPwdVCSBID") as! ForgetPwdVC
        
        
        let forgotVC = UIStoryboard.MainStoryBoard.ForgetPwdVC()
        self.present(forgotVC!, animated: true, completion: nil)
    }
    
}
extension LoginVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
        return true
    }
}
