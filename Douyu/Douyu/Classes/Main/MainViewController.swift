//
//  MainViewController.swift
//  Douyu
//
//  Created by 住梦iOS on 2017/2/24.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
    }

    private func addChildVC(storyName:String){
        //1.通过stroyboard获取控制器
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()
        //2.讲childVC作为子控制器
        self.addChildViewController(childVC!)
    }
    

   

}
