//
//  AppDelegate.swift
//  muKnow Content Provider
//
//  Created by Apple on 02/03/21.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseMessaging


@main
//@available(iOS 10.0, *)
//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,UNUserNotificationCenterDelegate,MessagingDelegate{

    var window: UIWindow?
    var navigationController: UINavigationController?
    var devToken : String? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        FirebaseApp.configure()
        self.registerForNotifications()
        
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        
        /* if fetchLoginResponse() != nil {
            let homeVC = UIStoryboard.MainStoryBoard.HomePageVC()
            
//            let mainViewController = storyboard.instantiateViewController(withIdentifier: "theNavigationVCSBID") as! UINavigationController
            
            let window = UIApplication.shared.delegate!.window!
            window?.rootViewController = homeVC
            
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "theNavigationVCSBID") as! UINavigationController
            let window = UIApplication.shared.delegate!.window!
            window?.rootViewController = mainViewController
        }*/
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.setRootVC()
        
        
        
        
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let mainViewController = storyboard.instantiateViewController(withIdentifier: "theNavigationVCSBID") as! UINavigationController
//        let window = UIApplication.shared.delegate!.window!
//        window?.rootViewController = mainViewController
        

        
        
        
        Messaging.messaging().delegate = self
        return true
    }
    func registerForNotifications()
    {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions,completionHandler: {_, _ in
            
            DispatchQueue.main.async
                {
                    UIApplication.shared.registerForRemoteNotifications()
            }
        })
    }

    func setRootVC() {
        
        
        if fetchLoginResponse() != nil {
//            let rearVC = STORYBOARD_MAIN.instantiateViewController(withIdentifier: "MenuSliderVC")
            let home = UIStoryboard.MainStoryBoard.HomePageVC()
//            let homeNavController = UINavigationController.init(rootViewController: home!)
            
            navigationController = UINavigationController.init(rootViewController: home!)
            navigationController?.isNavigationBarHidden = true
            self.window?.rootViewController = navigationController
            
        }else{
            let login = UIStoryboard.MainStoryBoard.LoginVC()
//            let loginNavController = UINavigationController.init(rootViewController: login!)
            
            navigationController = UINavigationController.init(rootViewController: login!)
            navigationController?.isNavigationBarHidden = true
            self.window?.rootViewController = navigationController
        }
    }

    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print("Successfully registered for notifications!")
        devToken = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token = ",devToken as Any)
    }
    
    func getDeviceToken() -> String{
        return devToken!
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?)
    {
        print("Firebase registration token: \(fcmToken)")
        UserDefaults.standard.set(fcmToken, forKey: "fcm_Token")

    }
}

//extension AppDelegate : MessagingDelegate {
//
//}
