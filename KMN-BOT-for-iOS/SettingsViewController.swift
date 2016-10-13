//
//  SettingsViewController.swift
//  KMN-BOT-for-iOS
//
//  Created by 熊谷乾太 on 2016/9/22.
//  Copyright © 2016年 乾太. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let data = [
        "[🐻] 關於作者",
        "[🐰] 協助名單",
        "[🐱] 登出 Plurk 帳戶"
    ]
    
    var cellText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectFunction(ViewSelect: String) -> Void {
        switch ViewSelect {
            case "[🐻] 關於作者":
                //
                break;
            
            case "[🐰] 協助名單":
                // この App は 《你的名字放這裡》 の提供でお送りします
                break;
            
            case "[🐱] 登出 Plurk 帳戶":
                // 設立 Alert 樣式
                let alertController = UIAlertController(
                    title: "[Warning]",
                    message: "您確定要登出您的 Plurk 帳戶嗎？",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                
                // 設立 Alert Button 樣式及事件
                let DestructiveAction = UIAlertAction(
                    title: "還是算了",
                    style: UIAlertActionStyle.Destructive
                ) {
                    (result : UIAlertAction) -> Void in
                    NSLog("[DEBUG] Logout Destructivi Action")
                }
                
                // 設立 Alert Button 樣式及事件
                let ConfirmAction = UIAlertAction(
                    title: "我想滾",
                    style: UIAlertActionStyle.Default
                ) {
                    (result : UIAlertAction) -> Void in
                    NSLog("[DEBUG] Logout Confirm Action")
                    
                    // 清空 NSUserDefaults 記事本內的東西
                    NSUserDefaults.standardUserDefaults().removePersistentDomainForName(NSBundle.mainBundle().bundleIdentifier!)
                    
                    // 建構一個 Storyboard
                    let storyboard:UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
                    
                    // 實作一個登入介面
                    let ViewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                    
                    // 從下方彈出一個介面作為登入介面，Completion 作為封包，可以寫一些彈出 View 時的一些操作
                    self.presentViewController(ViewController, animated: true, completion: nil)
                }
                
                // 建立 Alert Button
                alertController.addAction(DestructiveAction)
                alertController.addAction(ConfirmAction)

                self.presentViewController(alertController, animated: true, completion: nil)

                break;
            
            default:
                break;
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

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // 定義 TableView 的 Cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SettingsTableViewCell", forIndexPath: indexPath)
        let text = data[indexPath.row]
        cell.textLabel?.text = text
        return cell
    }
    
    // 定義 TableView 的 Count
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // Select Row 點擊事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cellText = cell?.textLabel?.text
        selectFunction(cellText!)
        NSLog("[DEBUG] Settings TableView Row onClick: \(cellText)")
    }
}
