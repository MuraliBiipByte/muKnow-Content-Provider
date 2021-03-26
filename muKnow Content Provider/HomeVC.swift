//
//  HomeVC.swift
//  muKnow Content Provider
//
//  Created by Apple on 04/03/21.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var notificationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func notificationBtnTapped(_ sender: UIButton) {
        
        /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let courseViewController = storyboard.instantiateViewController(withIdentifier: "NotificationsViewController")
        self.navigationController?.pushViewController(courseViewController, animated: false) */
        
        
        let notificationVCObj = UIStoryboard.MainStoryBoard.NotificationVC()
        self.navigationController?.pushViewController(notificationVCObj!, animated: true)
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
