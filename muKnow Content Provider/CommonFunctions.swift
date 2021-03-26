//
//  CommonFunctions.swift
//  muKnow Content Provider
//
//  Created by Apple on 11/03/21.
//

import UIKit

func setNavigationBar(vc : UIViewController , naviItem : UINavigationItem) {
    vc.navigationController?.setNavigationBarHidden(false, animated: true)
    let lefticonButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 35, height: 35)))
    lefticonButton.setBackgroundImage(UIImage(named: "muknowAppLogo"), for: .normal)
    let leftbarButton = UIBarButtonItem(customView: lefticonButton)
    
    naviItem.leftBarButtonItem = leftbarButton
}
