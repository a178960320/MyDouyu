//
//  UIColor-Extension.swift
//  Douyu
//
//  Created by 住梦iOS on 2017/2/24.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
        self.init(red:r/255.0 , green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
