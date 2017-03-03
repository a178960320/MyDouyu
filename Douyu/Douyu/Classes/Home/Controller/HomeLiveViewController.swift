//
//  HomeLiveViewController.swift
//  Douyu
//
//  Created by 住梦iOS on 2017/3/1.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

import UIKit

class HomeLiveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.拿到系统pop的手势
        guard let systemGes = self.navigationController?.interactivePopGestureRecognizer else{return}
        
        //2.获取手势添加到view中
        
        guard let gesView = systemGes.view else { return }
        
        //3.获取target/action
        //3.1利用运行时查看所有属性的名称
        /*
        var count:UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        
        for i in 0..<count{
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString:name!))
        }
        */
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        
        guard let targetObjc = targets?.first else { return }
        print(targetObjc)
        //3.2取出target
        guard let target = targetObjc.value(forKey: "target") else { return}
        
        //3.3
        let action = Selector(("handleNavigationTransition:"))
        
        //4.创建自己的手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
        self.view.backgroundColor = UIColor.orange
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
