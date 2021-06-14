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
    
    var paramsForResendOTP : [String:Any] = [:]
    
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
       
        ApiManager().postRequestWithParameters(service: WebServices.Login, params: paramsDict, completion:
                                                { [self] (result, success) in
     
            
            
            if success == false
            {
                self.view.StopLoading()
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
                
                
                if status == "0" {
                    self.view.StopLoading()
                    self.showAlert(message: message as! String)
                    return
                }else if status == "2" {
                    self.view.StopLoading()
                    Message.shared.Alert(Title:APP_NAME, Message: message, TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithSelector(Title: "Ok", Selector:#selector(sendOTPAndgoToValidationScreen), Controller: self),Message.AlertActionWithSelector(Title: "Cancel", Selector:#selector(cancelTapped), Controller: self)], Controller: self)
                    


                    
                }else{
                    self.view.StopLoading()
                    
                    let responseDict = dataDict["response"] as! NSDictionary
                    let trainerDetailsArr = responseDict["trainer_details"] as! NSArray //[String : Any]
                    let trainerDict = trainerDetailsArr[0] as! NSDictionary
                    
                    let trainerId = "\(trainerDict.value(forKey: "id")!)"
                    let username = "\(trainerDict.value(forKey: "username")!)"
                    let email = "\(trainerDict.value(forKey: "email")!)"
                    let user_type = "\(trainerDict.value(forKey: "user_type")!)"
                    let active = "\(trainerDict.value(forKey: "active")!)"
                    let image_url = "\(trainerDict.value(forKey: "image_url")!)"
                    
                    let imgURL : URL = URL(string: image_url)!
                    self.downloadAndSaveImg(imageURL: imgURL)
                    
                    var aLoginResponseStruct = LoginResponse()
                    aLoginResponseStruct.message = message
                     aLoginResponseStruct.status = status
                    aLoginResponseStruct.trainerId = trainerId
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
                    
                    
                    APPDELEGATE.setRootVC()
                    
                    
                    
                    
                    let homeVC = UIStoryboard.MainStoryBoard.HomePageVC()
                    self.navigationController?.pushViewController(homeVC!, animated: true)
    //                self.dismiss(animated: true, completion: nil)
                }
                
                
                
                
            }
        })

    }
    
  
    
    @objc func cancelTapped()
          {
              print("Cancel tapped...")
          }
    
    @objc func sendOTPAndgoToValidationScreen()
    {
        self.paramsForResendOTP["email_id"] = "\(txtEmail.text!)"
        self.view.StartLoading()
        ApiManager().postRequestWithParameters(service:WebServices.RESEND_OTP, params: paramsForResendOTP as [String : Any]){ [self]
            (result, success) in
            self.view.StopLoading()
            if success == false
            {
                self.showAlert(message: result as! String)
                return
            }else{
                /* let resultDictionary = result as! [String:Any]
                print("Resend OTP Response from Login: \(resultDictionary)")
                
                
                let apiResponse = result as! [String : Any]
                let dataDict = apiResponse["data"] as! [String : Any]
                let responseDict = dataDict["response"] as! NSDictionary
                
                let msg = responseDict["message"]! as! String */
                //self.showAlert(message: msg)
                
                
                
                let otpValidationVCObj = UIStoryboard.MainStoryBoard.OTPValidationVC()
                otpValidationVCObj?.doNeedToPop = true
                otpValidationVCObj?.email = "\(txtEmail.text!)"
                self.navigationController?.pushViewController(otpValidationVCObj!, animated: false)
                
                
                
               
            }
        }
        
    }
    func downloadAndSaveImg(imageURL : URL){
        
        let fileName = "ProfileImage"
//        let url = imageURL
        
        let theURL = imageURL //URL.init(string: url)
//        let folderName =  COMMONFUNCTION.getModuleFolderPathSync(ModuleName: moduleName)
        
        
        let folderName = getFolderPath()
        let destinationUrl = folderName.appendingPathComponent(fileName)
        
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig)
        
        let defaultSessionConfiguration = URLSessionConfiguration.default
        defaultSessionConfiguration.timeoutIntervalForRequest = 600000
        defaultSessionConfiguration.timeoutIntervalForResource = 600000
        defaultSessionConfiguration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        defaultSessionConfiguration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let defaultSession = URLSession(configuration: defaultSessionConfiguration)
        
        let request = URLRequest(url: theURL)
        
        let task = defaultSession.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Success: \(statusCode) , \(fileName) downloaded...")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationUrl)
                } catch (let writeError) {
                    print("error writing file \(destinationUrl) : \(writeError)")
                }
                
            } else {
                print("Failure:  \(fileName) Not downloaded...URL= \(imageURL)")
            }
        }
        task.resume()

        
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    //Get Upload file path
    func getFolderPath() -> URL {
        let documentsDirectory = getDocumentsDirectory()
        let folderPath = documentsDirectory.appendingPathComponent("ProfileImgFolder")
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: folderPath.path) {
        }
        else {
            do {
                try fileManager.createDirectory(atPath: folderPath.path, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription);
            }
        }
        return folderPath
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
