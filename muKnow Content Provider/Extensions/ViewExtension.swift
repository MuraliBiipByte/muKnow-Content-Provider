//
//  ViewExtension.swift
//  muKnow Content Provider
//
//  Created by Apple on 09/03/21.
//

import UIKit

extension UIView {
    
    // MARK: - Loader {
    
    func StartLoading() {
        
        if let _ = viewWithTag(10000)
        {
            //View is already Loading
        }
        else
        {
            
            let lockView = UIView(frame: bounds)
            lockView.backgroundColor = UIColor.clear
            lockView.tag = 10000
            
            addSubview(lockView)
            
            let container = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            container.backgroundColor = UIColor.lightGray
            container.layer.cornerRadius = 5
            container.clipsToBounds = true
            container.center =  lockView.center
            lockView.addSubview(container)
            
            let activity = UIActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
            activity.style = .whiteLarge
            activity.hidesWhenStopped = true
            activity.center = container.center
            
            lockView.addSubview(activity)
            lockView.bringSubviewToFront(activity)
            
            activity.startAnimating()
        }
    }
    
    func isLoading() -> Bool
    {
        if viewWithTag(10000) != nil {
            return true
        }
        return false
    }
    
    func StopLoading()
    {
        if let lockView = viewWithTag(10000)
        {
            UIView.animate(withDuration: 0.2, animations:
                {
                
            }) { finished in
                lockView.removeFromSuperview()
            }
        }
}
}
