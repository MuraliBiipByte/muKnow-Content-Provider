//
//  RegistrationVC.swift
//  muKnow Content Provider
//
//  Created by Apple on 03/03/21.
//

import UIKit


class RegistrationVC: UIViewController {

    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var mobileTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var confirmPwTxt: UITextField!
    @IBOutlet var btnTermsConditions: UIButton!
    var termsAccept = false

    
    var paramsDict = [String:Any]()
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var profileImgBtn: UIButton!
    
    @IBAction func profileImgBtnTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                    self.openCamera()
                }))

                alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                    self.openGallery()
                }))

                alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

                self.present(alert, animated: true, completion: nil)
    }
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func openGallery()
   {
       if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.allowsEditing = true
           imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
           self.present(imagePicker, animated: true, completion: nil)
       }
       else
       {
           let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
   }
    @IBOutlet weak var termsOfServiceBtn: UIButton!
    let yourAttributes: [NSAttributedString.Key: Any] = [
    .font: UIFont.systemFont(ofSize: 14),
    .foregroundColor: UIColor.blue,
    .underlineStyle: NSUnderlineStyle.single.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        btnTermsConditions.setImage(#imageLiteral(resourceName: "unCheck"), for:.normal)

        nameTxt.delegate = self
        emailTxt.delegate = self
        mobileTxt.delegate = self
        passwordTxt.delegate = self
        confirmPwTxt.delegate = self
        
        mobileTxt.keyboardType = .phonePad
        
        btnTermsConditions.setImage(UIImage(named: "unCheck"), for: .normal);
        
        
        let attributeString = NSMutableAttributedString(string: "Terms of Service",
                                                        attributes: yourAttributes)
        termsOfServiceBtn.setAttributedTitle(attributeString, for: .normal)
    }
    
    @IBAction func create_NewAccount(_ sender: Any) {
        
        
        if (nameTxt.text!.isEmpty) {
            self.showAlert(message: "Please Enter Name")
            return
        }
        
        if (nameTxt.text?.isValidInput())!{
            //Message.shared.Alert(Title: "Alert", Message: "Invalid Username. \n Username should be in between 4 to 15 Characters", TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithOutSelector(Title: "Ok")], Controller: self)
            self.showAlert(message: "Please Enter valid Name")
            return
        }
        if (emailTxt.text!.isEmpty){
            self.showAlert(message: "Please Enter Email")
            return
        }
        if !(emailTxt.text?.isValidEmail())! {
            self.showAlert(message: "Please Enter valid Email")
            return
        }
        if (mobileTxt.text!.isEmpty){
            self.showAlert(message: "Please Enter Mobile Number")
            return
        }
        if !(mobileTxt.text?.isValidMobileNumber())! {
            self.showAlert(message: "Please Enter valid Mobile Number")
            return
        }
        if (passwordTxt.text!.isEmpty){
            self.showAlert(message: "Please Enter Password")
            return
        }

        if (passwordTxt.text!.count < 6 ){
            self.showAlert(message: "The password must be at least 6 characters ")
            return
        }
        
        if (confirmPwTxt.text!.isEmpty){
            self.showAlert(message: "Please Re-Enter Password")
            return
        }
        if passwordTxt.text! != confirmPwTxt.text! {
            self.showAlert(message: "Password & Confirm Password are not matching.")
            return
        }
        if profileImgView.image == nil {
            self.showAlert(message: "Please provide Profile Image")
            return
        }
       
        
        
        
        
        
        if (termsAccept != true){
            self.showAlert(message: "Please Accept Terms & Conditions")
            return
        }
        // web service integration for sign up
        paramsDict = [
            "user_type":"trainer",
            "full_name":self.nameTxt.text!,
            "password":self.passwordTxt.text!,
            "confirm_password":self.confirmPwTxt.text!,
            "email_id":self.emailTxt.text!,
            "device_type":"iOS",
            "device_token" : "123456",
            "telcode" : "65",
            "phone":self.mobileTxt.text!,
        ]
        
//        http://devservices.mu-know.com:8080/register?email=asdfgf99d.09@gmail.com&password=asdfghjgfdes&full_name=ABD&mobile=12345678&date_of_birth=1988-05-09
    
        
        
//        http://devservices.mu-know.com:8080/smiles_add_trainer_users?user_type=trainer&full_name=TrRaja&password=qwe123&confirm_password=qwe123&email_id=train1@yopmail.com&device_type=ios&device_token=1234567890&telcode=+65&phone=1234567890
        
        
        print("Registration paramDict = \(paramsDict)")
        
        self.view.StartLoading()
        ApiManager().registrationWithImage(imageToUpload: profileImgView.image!, service: WebServices.REGISTRATION, params: paramsDict) { [self] (result, success) in
            
            self.view.StopLoading()
            if success == false
            {
                self.showAlert(message: result as! String)
                return
                
            }
            else
            {
                
                /*
                let resultDictionary = result as! [String : Any]
                
                
//                _ = User(userDictionay: resultDictionary)
                
                print("Registration ResultDict = ",resultDictionary)
                // STORE THE USER INFORMATION
                
                let keyExists = resultDictionary["error"] != nil
                if keyExists{
                    DispatchQueue.main.async {
                        self.showAlert(message: "Email Already Registered")
                    }
                    
                }else{
                    let changePwVc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterOTPVCSBID") as! RegisterOTPVC
//                    changePwVc.params = self.paramsDict
                    changePwVc.id = resultDictionary["id"] as? String
                    changePwVc.email = paramsDict["email_id"] as? String
                    self.present(changePwVc, animated: true, completion: nil)
                } */
                

//                self.showAlert(message: "User Registered Successfully...")
                let changePwVc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterOTPVCSBID") as! RegisterOTPVC
//                    changePwVc.params = self.paramsDict
//                changePwVc.id = resultDictionary["id"] as? String
                changePwVc.email = paramsDict["email_id"] as? String
                self.present(changePwVc, animated: true, completion: nil)
            }
        }
        
        
        
        /*
        ApiManager().getRequestWithParameters(service: WebServices.REGISTRATION, params: paramsDict) { [self] (result, success) in
            self.view.StopLoading()
            if success == false
            {
                self.showAlert(message: result as! String)
                return
                
            }
            else
            {
                let resultDictionary = result as! [String : Any]
                
                
//                _ = User(userDictionay: resultDictionary)
                
                print("Registration ResultDict = ",resultDictionary)
                // STORE THE USER INFORMATION
                
                let keyExists = resultDictionary["error"] != nil
                if keyExists{
                    DispatchQueue.main.async {
                        self.showAlert(message: "Email Already Registered")
                    }
                    
                }else{
                    let changePwVc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterOTPVCSBID") as! RegisterOTPVC
//                    changePwVc.params = self.paramsDict
                    changePwVc.id = resultDictionary["id"] as? String
                    changePwVc.email = paramsDict["email_id"] as? String
                    self.present(changePwVc, animated: true, completion: nil)
                }
            }
        } */
    }
    
    
    
       
       
    
    
    
    
    
//    @objc func myAccount()
//    {
//        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "Nav") as! UINavigationController
//
////        UITabBar.appearance().tintColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
////        UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray
//
//        self.present(nextViewController, animated: true, completion: nil)
//    }
    
    
    @IBAction func agreeTerms_Conditions_Tapped(_ sender: Any) {
        
        if termsAccept
        {
            termsAccept = false
            btnTermsConditions.setImage(#imageLiteral(resourceName: "unCheck"), for:.normal)
        }
        else
        {
            termsAccept = true
            btnTermsConditions.setImage(#imageLiteral(resourceName: "check"), for:.normal)
        }
    }

    @IBAction func back_vc(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }

    func showAlert(message:String)
      {
          Message.shared.Alert(Title:APP_NAME, Message: message, TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithOutSelector(Title: "Ok")], Controller: self)
      }
    
//      func showAlertWithAction(message:String)
//      {
//          Message.shared.Alert(Title:APP_NAME, Message: message, TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithSelector(Title: "Ok", Selector:#selector(myAccount), Controller: self)], Controller: self)
//      }
    
    @IBAction func termsOfServiceBtnTapped(_ sender: UIButton) {
        /* if let url = URL(string: "http://54.255.115.196/sharent_new/index.php/welcome/terms_conditions") {
            UIApplication.shared.open(url)
        }*/
    }
    
    

}

extension RegistrationVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension RegistrationVC :  UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let pickedImage = info[.originalImage] as? UIImage {
        let correctedImage = pickedImage.upOrientationImage()
//        uploadImage(selectedImg: correctedImage!)
        self.profileImgView.image = correctedImage
    }
    picker.dismiss(animated: true, completion: nil)
}
}
