//
//  UniversallyConstant.swift
//  Douyu
//
//  Created by 住梦iOS on 2017/2/24.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

import UIKit

///屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.width
///屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.height

///视图的x
func x(object:UIView)->CGFloat{
    return object.frame.origin.x
}

///视图的y
func y(object:UIView)->CGFloat{
    return object.frame.origin.y
}

///视图的宽
func w(object:UIView)->CGFloat{
    return object.frame.size.width
}

///视图的高
func h(object:UIView)->CGFloat{
    return object.frame.size.height
}
