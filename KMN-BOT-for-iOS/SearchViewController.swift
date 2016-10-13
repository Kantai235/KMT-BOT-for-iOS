//
//  SearchViewController.swift
//  KMN-BOT-for-iOS
//
//  Created by 熊谷乾太 on 2016/9/22.
//  Copyright © 2016年 乾太. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, NSURLConnectionDataDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var _寵物: [寵物?] = []
    
    var cellText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        var _jsonResult: NSDictionary! = nil
        do {
            _jsonResult = try NSJSONSerialization.JSONObjectWithData(
                preferences.objectForKey("User_Plurk_Json")!.dataUsingEncoding(NSUTF8StringEncoding)!,
                options: []
            ) as? NSDictionary
        } catch
            let error as NSError {
                print("Error: \(error.localizedDescription)"
            );
        }
        
        NSLog("[DEBUG] 使用者帳戶為: \(_jsonResult.valueForKey("nick_name"))")
        
        /* 測試 Plurk 帳號：Kantai_Test
         * 測試 Plurk 密碼：kantai_password
         */
        // http://kmnbot.ga/
        // http://kmnbot.servegame.com/
//        let _mainHttpPath = "http://kmnbot.servegame.com/pets/\(_jsonResult.valueForKey("nick_name") as! String).json"
        let _mainHttpPath = "http://kmnbot.servegame.com/pets/KMN_TREE.json"
        let request = NSURLRequest(URL: NSURL(string: _mainHttpPath)!)
        let urlSession = NSURLSession.sharedSession()
        
        NSLog("[DEBUG] 準備開始 Session KMN_BOT_BOX")
        
        let task = urlSession.dataTaskWithRequest(
            request,
            completionHandler: {
                (data, responsem, error) -> Void in
                let httpResponse = responsem as? NSHTTPURLResponse
                if error != nil {
                        NSLog("[WARN] 遇到了錯誤，在 urlSession 當中");
                        self.showNewPlayerAlert()
                        print(error!.localizedDescription)
                    } else {
                        if httpResponse!.statusCode != 404 {
                            NSLog("[DEBUG] 準備開始解析 Json 的結構。 data=\(NSString(data: data!, encoding: NSUTF8StringEncoding))")
                            self.parseJsonData(data!)
                            NSLog("[DEBUG] 解析完畢，準備把 TableView 的資料 reloadData")
                            self.tableView.reloadData()
                        } else {
                            NSLog("[DEBUG] urlSession data is 404.")
                            self.showNewPlayerAlert()
                        }
                    }
            }
        )
        task.resume()
    }

    func showNewPlayerAlert() -> Void {
        /* 處理例外錯誤 */
        // 建立 Alert 視窗結構
        let alertController = UIAlertController(
            title: "[INFO]",
            message: "似乎找不到您的帳戶資料喔！\n" +
                     "可能原因如下：\n\n" +
                     "Q1:您是新加入的玩家。\n" +
                     "A1:如果您還沒在噗浪加入機器狼好友，請先加入吧！(機器狼 = @KMN_BOT)，如果已經加入了，請您先去抽顆蛋吧！\n\n" +
                     "Q2:太久沒玩了，機器狼資料被黑箱掉了。\n" +
                     "A2:您需要手動玩一次地下城，才能救回您的機器狼喔！\n\n" +
                     "Q3:您被機器狼拒絕服務了。\n" +
                     "A3:找樹哥(@KMN_TREE)幫您解決。",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        // 建立 Alert Button
        alertController.addAction(
            UIAlertAction(
                title: "我瞭解了。",
                style: UIAlertActionStyle.Default,
                handler: nil
            )
        )
        
        // 顯示 Alert
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // View 已經加載到視窗上時的事件
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func parseJsonData(data: NSData) -> Void {
        let _jsonBox = SearchCellPost()
        var _jsonResult: NSDictionary! = nil
            
        do {
            _jsonResult = try NSJSONSerialization.JSONObjectWithData(
                data,
                options: []
                ) as? NSDictionary
        } catch
            let error as NSError {
                print("Error: \(error.localizedDescription)"
                );
        }
            
        // Pares JSON data
        NSLog("[DEBUG] func parseJsonData in Pares JSON data _玩家")
        let _玩家 = 玩家()
        let _json_玩家 = _jsonResult.valueForKey("玩家")
        _玩家.蒐集完成度 = (_json_玩家! as AnyObject).valueForKey("蒐集完成度") as! String
        _玩家._id = (_json_玩家! as AnyObject).valueForKey("_id") as! String
        _jsonBox._玩家.append(_玩家)
            
        // Pares JSON data
        NSLog("[DEBUG] func parseJsonData in Pares JSON data _寵物")
        let _json_寵物: NSArray! = _jsonResult.valueForKey("寵物") as! NSArray
        for _json in _json_寵物 {
            let json = 寵物()
            json.技能 = (_json as AnyObject).valueForKey("技能") as! String
            json.圖片 = (_json as AnyObject).valueForKey("圖片") as! String
            json.稀有度 = (_json as AnyObject).valueForKey("稀有度") as! Int
            json.寵物名稱 = (_json as AnyObject).valueForKey("寵物名稱") as! String
            json.下場TYPE = (_json as AnyObject).valueForKey("下場TYPE") as! String
            json.等級 = (_json as AnyObject).valueForKey("等級") as! String
            json.階級 = (_json as AnyObject).valueForKey("階級") as! String
            json.原TYPE = (_json as AnyObject).valueForKey("原TYPE") as! String
            _jsonBox._寵物.append(json)
            NSLog("[DEBUG] 已經抓取到 \(json.寵物名稱) 這項寵物。")
        }
        NSLog("[DEBUG] func parseJsonData in set _jsonBox._寵物")
        self._寵物 = _jsonBox._寵物
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

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // 定義 TableView 的 Cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchTableViewCell", forIndexPath: indexPath) as! SearchTableViewCell
        
        NSLog("[DEBUG] TableView Cell indexPath.row = \(indexPath.row)")
        let cellPost = self._寵物[indexPath.row]
        if (cellPost!.圖片 != "") {
            loadImageFromUrl((cellPost?.圖片)!, view: cell.SearchCellImageView)
        }
        cell.SearchCellMainTitle.text = cellPost?.寵物名稱;
        cell.SearchCellSubTitle.text = reStar((cellPost?.稀有度)!);
        cell.cellPost = cellPost
        return cell
    }
    
    // 定義 TableView 的 Count
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._寵物.count
    }
    
    // Select Row 點擊事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! SearchTableViewCell
        cellText = cell.SearchCellMainTitle.text
        NSLog("[DEBUG] Settings TableView Row onClick: \(cellText)")
    }
    
    // 機器狼的稀有度數字轉星星
    func reStar(starCount: Int) -> String {
        var star:String = ""
        for _ in 1...starCount {
            star += "★"
        }
        return star
    }
    
    
    func loadImageFromUrl(url: String, view: UIImageView){
        // Create Url from string
        let url = NSURL(string: url)!
        // Download task:
        // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (responseData, responseUrl, error) -> Void in
            // if responseData is not null...
            if let data = responseData{
                // execute in UI thread
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    view.image = UIImage(data: data)
                })
            }
        }
        // Run task
        task.resume()
    }
}
