//
//  UIBarButton-Extension.swift
//  Douyu
//
//  Created by 住梦iOS on 2017/2/24.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    convenience init(imageName:String,highImageName:String = "",size:CGSize = CGSize(width: 0, height: 0)) {
        let btn  = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named:highImageName), for: .highlighted)
        }
        
        if size != CGSize(width:0,height:0) {
            btn.frame = CGRect(origin: CGPoint(x:0,y:0), size: size)
        }else{
            btn.sizeToFit()
        }
        self.init(customView:btn)
    }
    
    
//    class func createmItem(imageName:String,highImageName:String,size:CGSize) -> UIBarButtonItem {
//        let btn  = UIButton()
//        btn.setImage(UIImage(named:imageName), for: .normal)
//        btn.setImage(UIImage(named:highImageName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint(x:0,y:0), size: size)
//        
//        return UIBarButtonItem(customView: btn)
//    }
}
