//
//  AppDelegate.swift
//  muKnow Content Provider
//
//  Created by Apple on 02/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "theNavigationVCSBID") as! UINavigationController
        
        

        
        let window = UIApplication.shared.delegate!.window!
        window?.rootViewController = mainViewController
        
        return true
    }

   


}

