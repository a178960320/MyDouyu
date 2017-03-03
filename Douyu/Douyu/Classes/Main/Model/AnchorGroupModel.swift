//
//  AnchorGroupModel.swift
//  Douyu
//
//  Created by 住梦iOS on 2017/2/28.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

import UIKit

class AnchorGroupModel: NSObject{
    //该组中对应的房间信息
    var room_list:[roomListModel] = [roomListModel]()
    
    var tag_name:String = ""
    
    var icon_url:String = "home_header_normal"
    
    var icon_name = "home_header_normal"
    
    var tag_id = ""
    
    class func modelContainerPropertyGenericClass() -> [String : Any]? {
      return ["room_list":roomListModel.self]
    }
}

class roomListModel:NSObject{
    var anchor_city = ""
    var avatar_mid = ""
    var avatar_small = ""
    var cate_id = ""
    var child_id = ""
    var game_name = ""
    var nickname = ""
    var online = ""
    var room_id = ""
    var room_name = ""
    var room_src = ""
    var show_status = ""
    var show_time = ""
    var specific_catalog = ""
    var vertical_src = ""
}
