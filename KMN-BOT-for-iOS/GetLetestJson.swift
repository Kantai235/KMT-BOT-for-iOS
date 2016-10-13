//
//  GetLetestJson.swift
//  KMN-BOT-for-iOS
//
//  Created by 熊谷乾太 on 2016/9/23.
//  Copyright © 2016年 乾太. All rights reserved.
//

import UIKit

class GetLetestJson: NSObject, NSURLConnectionDataDelegate {
    
    var _mainHttpPath: String!;
    var _tableView: UITableView!;
    var _json = SearchCellPost()
    
    required init?(_httpPath: String!, tableView: UITableView!) {
        super.init()
        // http://kmnbot.ga/
        // http://kmnbot.servegame.com/
        _mainHttpPath = "http://kmnbot.servegame.com/pets/" + _httpPath + ".json"
        _tableView = tableView
        
        let request = NSURLRequest(URL: NSURL(string: _mainHttpPath)!)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(
            request,
            completionHandler: { (data, responsem, error) -> Void in
                if error != nil {
                    print(error!.localizedDescription)
                }
                self._json = self.parseJsonData(data!)
        })
        task.resume()
    }
    
    func parseJsonData(data: NSData) -> SearchCellPost {
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
        let _玩家 = 玩家()
        let _json_玩家 = _jsonResult.valueForKey("玩家")
        _玩家.蒐集完成度 = (_json_玩家! as AnyObject).valueForKey("蒐集完成度") as! String
        _玩家._id = (_json_玩家! as AnyObject).valueForKey("_id") as! String
        _jsonBox._玩家.append(_玩家)
        
        // Pares JSON data
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
        return _jsonBox
    }
}
