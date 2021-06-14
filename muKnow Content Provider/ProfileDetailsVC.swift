//
//  ProfileDetailsVC.swift
//  muKnow Content Provider
//
//  Created by Apple on 12/04/21.
//

import UIKit

class ProfileDetailsVC: UIViewController {

    @IBOutlet weak var myLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var profileImgEditBtn: UIButton!
    @IBOutlet var userMobileNoLbl: UILabel!
    
    @IBOutlet var userEmail: UILabel!
    
    @IBOutlet var subscriptionStatus: UILabel!
    
    @IBOutlet var userNameLbl: UILabel!
    
    @IBOutlet var ReferLbl: UILabel!
    @IBOutlet var referralCode: UILabel!
    
    @IBOutlet var UserDataView: UIView!
    
    @IBAction func back_tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func edit_ProfileDetails(_ sender: Any) {
        
//        let editVc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
//
//
//        editVc.name = self.userNameLbl.text!
//        editVc.number = self.userMobileNoLbl.text!
//        editVc.dob = self.userDOB
//
//        self.navigationController?.pushViewController(editVc, animated: true)

    }
    
    var fileURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        profileImgEditBtn.isHidden = true
        
        

        

        profileImgView.layer.borderWidth = 1
        profileImgView.layer.masksToBounds = true
        profileImgView.layer.borderColor = UIColor.black.cgColor
        profileImgView.layer.cornerRadius = profileImgView.frame.size.width / 2
        profileImgView.clipsToBounds = true
        profileImgView.contentMode = .scaleToFill
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let lefticonButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 35, height: 35)))
        lefticonButton.setBackgroundImage(UIImage(named: "muknowAppLogo"), for: .normal)
 //        btn1.addTarget(self, action: Selector("action1:"), forControlEvents: .TouchUpInside)
 
        let leftbarButton = UIBarButtonItem(customView: lefticonButton)
        navigationItem.leftBarButtonItem = leftbarButton
        // Do any additional setup after loading the view.
        
        
        let loginResponse = fetchLoginResponse()
        userNameLbl.text = loginResponse?.userName
        userEmail.text = loginResponse?.email
//        userMobileNoLbl.text =
        
        
        
        
//        let fileURL = COMMONFUNCTION.getModuleFolderPath().appendingPathComponent(filename)
        let fileName = "ProfileImage"
        fileURL = getFolderPath().appendingPathComponent(fileName)

        self.profileImgView.image = UIImage(named: "NewProfile")!
        myLoader.startAnimating()
        myLoader.isHidden = false
        
        setProfileImg()
    }
    
    @objc fileprivate func setProfileImg() {
        if FileManager.default.fileExists(atPath: fileURL!.path){
            myLoader.stopAnimating()
            myLoader.isHidden = true
            if let img = UIImage(contentsOfFile: fileURL!.path) {
                self.profileImgView.image = img
            }
        }else{
            
            
            self.perform(#selector(self.setProfileImg), with: nil, afterDelay: 0.2)
            //setProfileImg(fileURL)
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logoutBtnTapped(_ sender: UIButton) {
        
        clearAllFolder()
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "LoginResponse")
//        defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        defaults.synchronize()
        
        
        
        
        
        
        APPDELEGATE.setRootVC()
    }
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
    
    
}
