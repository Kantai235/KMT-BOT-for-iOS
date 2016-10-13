//
//  LoginViewController.swift
//  KMN-BOT-for-iOS
//
//  Created by 熊谷乾太 on 2016/9/19.
//  Copyright © 2016年 乾太. All rights reserved.
//

import UIKit
import OAuthSwift

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func Login_Button_Click(sender: AnyObject) {
        /* 登入 Plurk */
        _OAuthSwift.authorizeWithCallbackURL(
            NSURL(string: "KMN-BOT-for-iOS://oauth-callback/plurk")!,
            success: { credential, response, parameters in
                // 抓取 Plurk 回傳的 Token 資料
                _OAuthSwift.client.credential.oauth_token = credential.oauth_token
                _OAuthSwift.client.credential.oauth_token_secret = credential.oauth_token_secret
                
                // 判斷回傳回來的 Token 資料是否為空
                if (credential.oauth_token != "" || credential.oauth_token_secret != "") {
                    // 將 Token 資料寫入 Preferences 當中
                    preferences.setValue(credential.oauth_token, forKey: "Plurk_Token")
                    preferences.setValue(credential.oauth_token_secret, forKey: "Plurk_Token_Secret")
                    preferences.synchronize()
                    
                    // NSLog 日誌紀錄資訊
                    NSLog("[Success] OAuth Token = \(credential.oauth_token)")
                    NSLog("[Success] OAuth Token Secret = \(credential.oauth_token_secret)")
                    
                    // 跳轉內容頁面
                    self.viewDidAppear(true);
                } else {
                    /* 處理例外錯誤 */
                    // 建立 Alert 視窗結構
                    let alertController = UIAlertController(
                        title: "[Warning]",
                        message: "無法從噗浪當中獲取帳戶資料，請您重新嘗試。",
                        preferredStyle: UIAlertControllerStyle.Alert
                    )
                    
                    // 建立 Alert Button
                    alertController.addAction(
                        UIAlertAction(
                            title: "確定",
                            style: UIAlertActionStyle.Default,
                            handler: nil
                        )
                    )
                    
                    // 顯示 Alert
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // View 已經加載到視窗上時的事件
    override func viewDidAppear(animated: Bool) {
        // 判斷是否已存在 Plruk 帳戶資料。
        if (preferences.objectForKey("Plurk_Token") != nil || preferences.objectForKey("Plurk_Token_Secret") != nil) {
            
            // 調用 Loading 動畫
            SwiftLoading().showLoading()
            
            NSLog("[DEBUG] 自動登入，Plurk_Token = \(preferences.objectForKey("Plurk_Token"))")
            NSLog("[DEBUG] 自動登入，Plurk_Token_Secret = \(preferences.objectForKey("Plurk_Token_Secret"))")
            
            // 將 Token 訊息寫入 _OAuthSwift
            _OAuthSwift.client.credential.oauth_token = preferences.objectForKey("Plurk_Token")! as! String
            _OAuthSwift.client.credential.oauth_token_secret = preferences.objectForKey("Plurk_Token_Secret")! as! String
            
            _OAuthSwift.client.get(
                url + "Users/me",
                parameters: [:],
                success: {
                    data,
                    response in
                    
                    // 關閉 Loading 動畫
                    SwiftLoading().hideLoading()
                    
                    let jsonDict = NSString(data: data, encoding: NSUTF8StringEncoding)
                    // 將 Json 資料擷取出來
                    // let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                    
                    // 將 Json 資料寫入 Preferences 當中
                    preferences.setValue(jsonDict, forKey: "User_Plurk_Json")
                    preferences.synchronize()
                    
                    NSLog("[DEBUG] 從 Plurk 獲取 Users/me: \(jsonDict)")
                    
                    // 設立 Alert 樣式
                    let alertController = UIAlertController(
                        title: "[Success]",
                        message: "系統自動登入 Plurk 完成。",
                        preferredStyle: UIAlertControllerStyle.Alert
                    )
                    // 設立 Alert Button 樣式及事件
                    let ConfirmAction = UIAlertAction(
                        title: "讓我們開始吧",
                        style: UIAlertActionStyle.Default
                    ) {
                        (result : UIAlertAction) -> Void in
                        // 建構一個 Storyboard
                        let storyboard:UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
                        
                        // 實作一個登入介面
                        let ViewController = storyboard.instantiateViewControllerWithIdentifier("MainTabBarController") as! MainTabBarController
                        
                        // 從下方彈出一個介面作為登入介面，Completion 作為封包，可以寫一些彈出 View 時的一些操作
                        self.presentViewController(ViewController, animated: true, completion: nil)
                        NSLog("[DEBUG] 正常從 Plurk 獲取 Users/me 的資料")
                    }
                    
                    // 建立 Alert Button
                    alertController.addAction(ConfirmAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)

                },
                failure: {
                    error in print(error)
                }
            )
            
//            _OAuthSwift.client.get(
//                url + "Users/me",
//                parameters: [:],
//                success: {
//                    data,
//                    response in
//                    // 將 Json 資料擷取出來
//                    let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
//
//                    // 將 Json 資料寫入 Preferences 當中
//                    self.preferences.setValue(jsonDict, forKey: "User_Plurk_Json")
//                    self.preferences.synchronize()
//                    
//                    NSLog("[DEBUG] 從 Plurk 獲取 Users/me: \(jsonDict)")
//
//                    // 設立 Alert 樣式
//                    let alertController = UIAlertController(
//                        title: "[Success]",
//                        message: "系統自動登入 Plurk 完成。",
//                        preferredStyle: UIAlertControllerStyle.Alert
//                    )
//                    // 設立 Alert Button 樣式及事件
//                    let ConfirmAction = UIAlertAction(
//                        title: "讓我們開始吧",
//                        style: UIAlertActionStyle.Default
//                    ) {
//                        (result : UIAlertAction) -> Void in
//                        // 建構一個 Storyboard
//                        let storyboard:UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
//                        
//                        // 實作一個登入介面
//                        let ViewController = storyboard.instantiateViewControllerWithIdentifier("MainTabBarController") as! MainTabBarController
//                        
//                        // 從下方彈出一個介面作為登入介面，Completion 作為封包，可以寫一些彈出 View 時的一些操作
//                        self.presentViewController(ViewController, animated: true, completion: nil)
//                        NSLog("[DEBUG] 正常從 Plurk 獲取 Users/me 的資料")
//                    }
//                    
//                    // 建立 Alert Button
//                    alertController.addAction(ConfirmAction)
//                    
//                    self.presentViewController(alertController, animated: true, completion: nil)
//                },
//                failure: {
//                     error in print(error.localizedDescription)
//                    // 設立 Alert 樣式
//                    let alertController = UIAlertController(
//                        title: "[FATAL]",
//                        message: "系統無法從 Plurk 獲取使用者資料，您將無法使用大部份的功能。",
//                        preferredStyle: UIAlertControllerStyle.Alert
//                    )
//                    // 設立 Alert Button 樣式及事件
//                    let ConfirmAction = UIAlertAction(
//                        title: "我瞭解了。",
//                        style: UIAlertActionStyle.Default
//                    ) {
//                        (result : UIAlertAction) -> Void in
//                        NSLog("[FATAL] _OAuthSwift 無法從 Plurk 獲取 Users/me")
//                    }
//                    
//                    // 建立 Alert Button
//                    alertController.addAction(ConfirmAction)
//                    
//                    self.presentViewController(alertController, animated: true, completion: nil)
//                }
//            )
            
//            // 建構一個 Storyboard
//            let storyboard:UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
//            
//            // 實作一個登入介面
//            let ViewController = storyboard.instantiateViewControllerWithIdentifier("MainTabBarController") as! MainTabBarController
//            
//            // 從下方彈出一個介面作為登入介面，Completion 作為封包，可以寫一些彈出 View 時的一些操作
//            self.presentViewController(ViewController, animated: true, completion: nil)
            
        } else {
            // 透過 NSLog 來檢視是否有問題
            NSLog("[DEBUG] 尚未登入，Plurk_Token = \(preferences.objectForKey("Plurk_Token"))")
            NSLog("[DEBUG] 尚未登入，Plurk_Token_Secret = \(preferences.objectForKey("Plurk_Token_Secret"))")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

// OAuthSwift 建構全局函式
let _OAuthSwift:OAuth1Swift = OAuth1Swift(
    consumerKey:    "bJWvgktCctpR",
    consumerSecret: "Nxk4lTnDUmM2Menek6usSAUnU1SQwKcC",
    requestTokenUrl: "http://www.plurk.com/OAuth/request_token",
    authorizeUrl:    "http://www.plurk.com/m/authorize",
    accessTokenUrl:  "http://www.plurk.com/OAuth/access_token"
)

// 讀取記事本
let preferences = NSUserDefaults.standardUserDefaults()

// Plurk API Path
let url :String = "http://www.plurk.com/APP/"
