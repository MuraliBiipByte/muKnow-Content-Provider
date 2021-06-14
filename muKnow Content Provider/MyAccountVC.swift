//
//  MyAccountVC.swift
//  muKnow Content Provider
//
//  Created by Apple on 11/06/21.
//

import UIKit

class MyAccountVC: UIViewController {

    @IBOutlet var ProfileTable: UITableView!
    
    var PrifileNamesArr = [String]()
    var ProfileImgArr = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar(vc: self, naviItem: navigationItem)
        self.ProfileTable.dataSource = self
        self.ProfileTable.delegate = self
        self.ProfileTable.separatorColor = .clear
        
        self.PrifileNamesArr = ["My Profile","Settings","Support","Log Out"];
        self.ProfileImgArr = [UIImage(named:"User")!,UIImage(named:"Settings")!,UIImage(named:"Help-hand")!,UIImage(named:"Logout")!]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func clearAllFolder() {
        let fileManager = FileManager.default
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = urls[urls.count - 1] as URL
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: documentsDirectory.path)
            for filePath in filePaths {
                try fileManager.removeItem(at: documentsDirectory.appendingPathComponent(filePath))
                
                
//                if filePath != "TKV2Logs.txt" {
//                    try fileManager.removeItem(at: documentsDirectory.appendingPathComponent(filePath))
//                }
            }
        } catch {
            print("Could not clear folder: \(error)")
        }
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
        
        
        let notificationVCObj = UIStoryboard.MainStoryBoard.NotificationVC()
        self.navigationController?.pushViewController(notificationVCObj!, animated: false)
    }

   
//    @IBAction func profileBtnTapped(_ sender: UIButton) {
//        /*
//        let profileVCObj = UIStoryboard.MainStoryBoard.ProfileVC()
//        self.navigationController?.pushViewController(profileVCObj!, animated: false) */
//        
//        let myAccountVCObj = UIStoryboard.MainStoryBoard.MyAccountVC()
//        self.navigationController?.pushViewController(myAccountVCObj!, animated: false)
//    }

}
extension MyAccountVC : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PrifileNamesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell")as! ProfileTableViewCell
        cell.profileNameLbl.text = PrifileNamesArr[indexPath.row]
        cell.profileImg.image = self.ProfileImgArr[indexPath.row]
       
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
//            let userVC = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
//            userVC.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(userVC, animated: true)
            
            let profileVCObj = UIStoryboard.MainStoryBoard.ProfileVC()
            self.navigationController?.pushViewController(profileVCObj!, animated: false)
            
            
        }
        if  indexPath.row == 3 {
            
            /* removeObjects()
            let initialVc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            //self.present(initialVc, animated: true, completion: nil)
         self.navigationController?.present(initialVc, animated: true, completion: nil)*/
            
            
            
            clearAllFolder()
            
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "LoginResponse")
    //        defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            defaults.synchronize()
        
            APPDELEGATE.setRootVC()
        }
    }
    
    
}
