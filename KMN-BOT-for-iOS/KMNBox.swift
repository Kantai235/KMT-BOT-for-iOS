//
//  KMNBoxCells.swift
//  KMN-BOT-for-iOS
//
//  Created by 熊谷乾太 on 2016/9/23.
//  Copyright © 2016年 乾太. All rights reserved.
//

import UIKit

class KMNBox {
    var _玩家: 玩家?
    var _寵物: [寵物?] = []
}

class 玩家 {
    var 蒐集完成度: String = "";
    var _id: String = "";
}

class 寵物 {
    var 技能: String = "";
    var 圖片: String = "";
    var 稀有度: Int = 0;
    var 寵物名稱: String = "";
    var 下場TYPE: String = "";
    var 等級: String = "";
    var 階級: String = "";
    var 原TYPE: String = "";
}
