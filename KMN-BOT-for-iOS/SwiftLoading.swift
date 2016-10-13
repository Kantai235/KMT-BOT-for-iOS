//
//  SwiftLoading.swift
//  KMN-BOT-for-iOS
//
//  Created by 熊谷乾太 on 2016/9/22.
//  Copyright © 2016年 乾太. All rights reserved.
//

import UIKit

class SwiftLoading {
    
    var loadingView = UIView()
    var container = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    func showLoading() {
        
        let window:UIWindow = UIApplication.sharedApplication().delegate!.window!!
        
        self.loadingView = UIView(frame: window.frame)
        self.loadingView.tag = 1
        self.loadingView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        
        window.addSubview(self.loadingView)
        
        container = UIView(frame: CGRect(x: 0, y: 0, width: window.frame.width/3, height: window.frame.width/3))
        container.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        container.layer.cornerRadius = 25.0
        container.layer.borderColor = UIColor.grayColor().CGColor
        container.layer.borderWidth = 0.5
        container.clipsToBounds = true
        container.center = self.loadingView.center
        
        
        activityIndicator.frame = CGRectMake(0, 0, window.frame.width/5, window.frame.width/5)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.center = self.loadingView.center
        
        
        self.loadingView.addSubview(container)
        self.loadingView.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
    }
    
    func hideLoading(){
        UIView.animateWithDuration(0.0, delay: 1.0, options: .CurveEaseOut, animations: {
            self.container.alpha = 0.0
            self.loadingView.alpha = 0.0
            self.activityIndicator.stopAnimating()
            }, completion: { finished in
                self.activityIndicator.removeFromSuperview()
                self.container.removeFromSuperview()
                self.loadingView.removeFromSuperview()
                let win:UIWindow = UIApplication.sharedApplication().delegate!.window!!
                let removeView  = win.viewWithTag(1)
                removeView?.removeFromSuperview()
        })
    }
}
