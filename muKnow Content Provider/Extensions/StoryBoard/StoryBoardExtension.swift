//
//  StoryBoardExtension.swift
//  muKnow Content Provider
//
//  Created by Apple on 09/03/21.
//

import Foundation
import UIKit

extension UIStoryboard{
    
    struct MainStoryBoard {
        static func LoginVC() -> LoginVC?{
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVCSBID") as? LoginVC
        }
        
        static func HomePageVC() -> HomeVC?{
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVCSBID") as? HomeVC
        }
        
        static func NotificationVC() -> NotificationsVC?{
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVCSBID") as? NotificationsVC
        }
        
        static func RegistrationVC() -> RegistrationVC?{
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegistrationVCSBID") as? RegistrationVC
        }
        
        static func ForgetPwdVC() -> ForgetPwdVC?{
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgetPwdVCSBID") as? ForgetPwdVC
        }
    }
}
