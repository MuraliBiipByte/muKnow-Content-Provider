//
//  NotificationsVC.swift
//  muKnow Content Provider
//
//  Created by Apple on 10/03/21.
//

import UIKit


class NotificationsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar(vc: self, naviItem: navigationItem)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let loginResponse = fetchLoginResponse() {
            print("Fetched loginResponse = ",loginResponse)
            getNotificationHistoryData()
            
        }else{
            print("Need to go Login Page....")
            self.showAlertWithAction(message: "Please login to Continue")
            
        }
        
        
//        if let loginResponse = fetchLoginResponseData(){
//            print("loginResponse = ",loginResponse)
//            getNotificationHistoryData()
//
//        }else{
//            print("Need to go Login Page....")
//            self.showAlertWithAction(message: "Please login to Continue")
//
//        }
    }
    
    func showAlertWithAction(message:String)
    {
        Message.shared.Alert(Title:APP_NAME, Message: message, TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithSelector(Title: "Ok", Selector:#selector(goToLogin), Controller: self)], Controller: self)
    }
    @objc func goToLogin()
    {
//        let changePwVc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        self.present(changePwVc, animated: true, completion: nil)
        let loginVCObj = UIStoryboard.MainStoryBoard.LoginVC()
//        self.navigationController?.present(loginVCObj!, animated: true, completion: nil)
        self.present(loginVCObj!, animated: true, completion: nil)
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func getNotificationHistoryData() {
        print("need to call notification service.....")
    }
}
