//
//  HomeViewController.swift
//  Douyu
//
//  Created by 住梦iOS on 2017/2/24.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,PageTitleViewDelegate,PageContentViewDelegate{

    lazy var pageTitleView:PageTitleView = {
       
        let titleView = PageTitleView(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: 40), titles: ["推荐","娱乐","游戏","趣玩"])
        titleView.delegate = self
        
        return titleView
        
    }()
    lazy var pageContentView:PageContentView = {
        var childVC = [UIViewController]()
        //循环添加子视图控制器
        for i in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.init(r: 50*CGFloat(i), g: 100, b: 150)
            childVC.append(vc)
        }
        
        let pageCV = PageContentView(frame: CGRect.init(x: 0, y: 64+40, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 40 - 49), childVC: childVC, parentViewController: self)
        pageCV.delegate = self
        
        return pageCV
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
    }



}
//MARK: - 设置ui界面
extension HomeViewController{
    func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        
        setNavigationUI()
        
        self.view.addSubview(pageTitleView)
        
        self.view.addSubview(pageContentView)
    }
    func setNavigationUI(){
        //设置导航条背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        
        //设置左侧的item
        let size = CGSize(width: 40, height: 40)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "homeLogoIcon")
        
        //设置右侧items
        let hisstoryItem = UIBarButtonItem(imageName: "viewHistoryIcon", highImageName: "viewHistoryIconHL", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "searchBtnIcon", highImageName: "searchBtnIconHL", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "scanIcon", highImageName: "scanIconHL", size: size)
        
        
        
        self.navigationItem.rightBarButtonItems = [hisstoryItem,searchItem,qrcodeItem]
    }
}
// MARK: - 实现pagetitleview的代理
extension HomeViewController{
    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
        pageContentView.setCurrentInde(index: index)
    }
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        print(progress,sourceIndex,targetIndex)
        pageTitleView.setIndexWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
