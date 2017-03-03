//
//  NetWorkTools.swift
//  Douyu
//
//  Created by 住梦iOS on 2017/2/28.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    case GET
    case Post
}


class NetWorkTools{
    class func requestData(type:MethodType,URLString:String,parameters:Parameters? = nil,finishedCallBack:@escaping (_ result:AnyObject) -> ()) {
        //1.获取请求类型
        
        Alamofire.request(URLString, method:type == .GET ? .get:.post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else{
                print(response.result.error)
                return
            }
            finishedCallBack(result as AnyObject)
        }
        
        
    }
}
