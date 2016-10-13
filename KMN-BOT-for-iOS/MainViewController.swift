//
//  MainViewController.swift
//  KMN-BOT-for-iOS
//
//  Created by 熊谷乾太 on 2016/9/19.
//  Copyright © 2016年 乾太. All rights reserved.
//

import UIKit
import OAuthSwift

class MainViewController: UIViewController {

    // KMT_BOT DNS = http://133.130.102.121
    
    // OAuthSwift 建構函式
    let _OAuthSwift:OAuth1Swift = OAuth1Swift(
        consumerKey:    "bJWvgktCctpR",
        consumerSecret: "Nxk4lTnDUmM2Menek6usSAUnU1SQwKcC",
        requestTokenUrl: "http://www.plurk.com/OAuth/request_token",
        authorizeUrl:    "http://www.plurk.com/m/authorize",
        accessTokenUrl:  "http://www.plurk.com/OAuth/access_token"
    )
    
    // 建構記事本
    let preferences = NSUserDefaults.standardUserDefaults()
    
    // 噗浪 API 的根目錄(URL)
    let Plurk_API_Path = "http://www.plurk.com/APP/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
    }
    
    @IBAction func Function_Test_Button_Click(sender: AnyObject) {
        _OAuthSwift.client.get(
            self.Plurk_API_Path + "Users/me",
            parameters: [:],
            success: {
                data,
                response in
                let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                print(jsonDict)
            },
            failure: {
                error in print(error)
            }
        )
    }
}
/* 發文 */
//let url :String = "http://www.plurk.com/APP/Timeline/plurkAdd"
//let parameters :Dictionary = [
//    "content"         : "「iOS」發文測試遊玩機器狼。太陽機器狼 (bz)(bz)(bz)(bz)(bz)(bz)",
//    "qualifier"       : "says",
//    "no_comments"     : "0",
//    "lang"            : "tr_ch"
//]
//_OAuthSwift.client.get(
//    url,
//    parameters: parameters,
//    success: {
//        data,
//        response in
//        let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
//        print(jsonDict)
//    },
//    failure: {
//        error in print(error)
//    }
//)
