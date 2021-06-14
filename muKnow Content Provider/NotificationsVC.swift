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
        
        /*
         if let loginResponse = fetchLoginResponse() {
            print("Fetched loginResponse = ",loginResponse)
            getNotificationHistoryData()
            
        }else{
            print("Need to go Login Page....")
            self.showAlertWithAction(message: "Please login to Continue")
            
        }*/
        
        getNotificationHistoryData()
        
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
    
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var articleListBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    
    @IBAction func homeBtnTapped(_ sender: UIButton) {
        let homePageVObj = UIStoryboard.MainStoryBoard.HomePageVC()
        self.navigationController?.pushViewController(homePageVObj!, animated: false)
    }
    
    @IBAction func articleListBtnTapped(_ sender: UIButton) {
        let articleListVCObj = UIStoryboard.MainStoryBoard.ArticleListVC()
        self.navigationController?.pushViewController(articleListVCObj!, animated: false)
    }
    
    @IBAction func notificationBtnTapped(_ sender: UIButton) {
        
        /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let courseViewController = storyboard.instantiateViewController(withIdentifier: "NotificationsViewController")
        self.navigationController?.pushViewController(courseViewController, animated: false) */
        
        
//        let notificationVCObj = UIStoryboard.MainStoryBoard.NotificationVC()
//        self.navigationController?.pushViewController(notificationVCObj!, animated: false)
    }

   
    @IBAction func profileBtnTapped(_ sender: UIButton) {
//        let profileVCObj = UIStoryboard.MainStoryBoard.ProfileVC()
//        self.navigationController?.pushViewController(profileVCObj!, animated: false)
        
        let myAccountVCObj = UIStoryboard.MainStoryBoard.MyAccountVC()
        self.navigationController?.pushViewController(myAccountVCObj!, animated: false)
    }
}
