//
//  RecommentViewModel.swift
//  Douyu
//
//  Created by 住梦iOS on 2017/2/28.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

import UIKit
import YYModel

class RecommentViewModel{
    lazy var anchorGroup: [AnchorGroupModel] = [AnchorGroupModel]()
    lazy var hotGroup = AnchorGroupModel()
    lazy var prettyGroup = AnchorGroupModel()
    
}


//MARK: -发送网络请求
extension RecommentViewModel{
    func loadData(finishCallback : @escaping () -> ()){
        
        let dGroup = DispatchGroup.init()
        
        //请求开始进入组
        dGroup.enter()
        //1.请求第一部分推荐数据
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: nil) { (result) in
            //1.将result转成字典类型
            guard let  resultDic = result as? [String:NSObject] else{return}
            
            //2.根据data，获取数组
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else{return}
            
            //3.
            
            self.hotGroup.tag_name = "热门"
            self.hotGroup.icon_name = "home_header_hot"
            
            for obj in dataArray{
                if let model = roomListModel.yy_model(withJSON: obj){
                    self.hotGroup.room_list.append(model)
                }
            }
            //请求成功离开组
            dGroup.leave()
        }
        
        //请求开始进入组
        dGroup.enter()
        //2.请求第二部分颜值数据
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters:nil) { (result) in
            //1.将result转成字典类型
            guard let  resultDic = result as? [String:NSObject] else{return}
            
            //2.根据data，获取数组
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else{return}
            //3.遍历数组
            
            self.prettyGroup.tag_name = "颜值"
            
            self.prettyGroup.icon_name = "home_header_phone"
            for (index,obj) in dataArray.enumerated(){
                if let model = roomListModel.yy_model(withJSON: obj){
                    self.prettyGroup.room_list.append(model)
                }
                if index == 3{
                    break
                }
            }
            
            //请求成功离开组
            dGroup.leave()
        }
        
        
        
        //请求开始进入组
        dGroup.enter()
        //3.请求后面部分游戏数据
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:nil) { (result) in
            //1.将result转成字典类型
            if let resultDic = result as? [String:NSObject]{
                //2.根据data该key，获取数组
                if let dataArray = resultDic["data"] as? [[String:NSObject]]{
                    for obj in dataArray{
                        let model:AnchorGroupModel = AnchorGroupModel.yy_model(withJSON: obj)!
                        if (model.room_list.count) > 0{
                            self.anchorGroup.append(model)
                        }
                        
                    }
                    //请求成功离开组
                    dGroup.leave()
                }
            }
        }
        
        
        //4.所有的数据请求到之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroup.insert(self.prettyGroup, at: 0)
            self.anchorGroup.insert(self.hotGroup, at: 0)
            
            finishCallback()
        }
        
        
        
    }
}
