//
//  PageTitleView.swift
//  Douyu
//
//  Created by 住梦iOS on 2017/2/24.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

import UIKit


protocol PageTitleViewDelegate:class {
    func pageTitleView(titleView:PageTitleView,selectIndex index:Int)
}
//MARK: - 定义常量
let kScrollW:CGFloat = 2
let kNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
let kSelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {
    
    //代理
    var delegate:PageTitleViewDelegate?
    
    
    //MARK: - 懒加载
    lazy var scrollView:UIScrollView = {
        let scrView = UIScrollView()
        scrView.showsHorizontalScrollIndicator = false
        scrView.scrollsToTop = false
        scrView.bounces = false
        
        return scrView
    }()
    lazy var scrollLine:UIView = {
       let view = UIView()
       view.backgroundColor = UIColor.orange
        return view
    }()
    
    
    //用于保存titles
    var titles:[String]
    //用于保存当前的index
    var currentIndex:Int = 0
    
    
    
    //构造函数
    init(frame:CGRect,titles:[String]){
        self.titles = titles;
        super.init(frame: frame)
        
        //打开交互
        isUserInteractionEnabled = true
        //创建UI
        setupUI()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: - 设置UI
extension PageTitleView{
    func setupUI(){
        //1.添加scrView
        addSubview(scrollView)
        scrollView.frame = self.bounds
        
        //2.添加titles对于的label
        addTitleLabel()
        
        //3.设置滑块
        setupBottomMenuAndLine()
    }
    func addTitleLabel(){
        //计算宽高
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollW
        let labelY:CGFloat = 0
        
        for (index,title) in titles.enumerated(){
            //1.创建UIlabel
            let label = UILabel()
            
            //2.设置label的属性
            label.text = title
            label.tag = index + 100
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = index  == currentIndex ? UIColor.orange:UIColor.darkGray
            label.textAlignment = .center
            
            
            //3.设置label的frame
            
            let labelX:CGFloat = CGFloat(index)*labelW
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //4.为label添加点击手势
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(PageTitleView.tapAction(ges:)))
            label.addGestureRecognizer(tapGes)
            label.isUserInteractionEnabled = true
            
            
            scrollView.addSubview(label)
            
        }
    }
    
    func setupBottomMenuAndLine(){
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.frame = CGRect(x: 0, y: frame.height-0.5, width: frame.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.lightGray
        addSubview(bottomLine)
        
        //2.添加滑块
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: 10, y: frame.height - 3, width: frame.width / CGFloat(titles.count)-20, height: 3)
        
    }
}
//MARK: - label手势触发事件
extension PageTitleView{
    func tapAction(ges:UIGestureRecognizer){
        if currentIndex + 100 == ges.view!.tag {
            return
        }
        //1.设置选中的颜色橘色
        let label = viewWithTag(ges.view!.tag) as! UILabel
        label.textColor = UIColor.orange
        //2.设置之前的选中颜色为灰色
        let label1 = viewWithTag(currentIndex + 100) as! UILabel
        label1.textColor = UIColor.darkGray
        //3.把选中的下标设置成当前tag
        currentIndex = ges.view!.tag - 100
        //4.让滑块进行动画
        UIView.animate(withDuration: 0.3) {
            self.scrollLine.frame.origin.x = self.frame.width / CGFloat(self.titles.count) * CGFloat(self.currentIndex)+10
        }
        //5.通知代理做事情
        delegate?.pageTitleView(titleView: self, selectIndex: currentIndex)
        
    }
}
//MARK : - 根据偏移量改变选中状态
extension PageTitleView{
    func setIndexWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int){
        if sourceIndex == targetIndex {
            (viewWithTag(sourceIndex + 100) as! UILabel).textColor = UIColor.orange
            currentIndex = targetIndex
            return
        }
        //1.取出对应的label
        let label = viewWithTag(sourceIndex + 100)
        let label1 = viewWithTag(targetIndex + 100)
        
        //2.处理滑块
        let moveTotal = label1!.frame.origin.x - label!.frame.origin.x
        let moveX = moveTotal * progress
        
        scrollLine.frame.origin.x = label!.frame.origin.x + 10 + moveX
        
        //3.处理文本颜色渐变
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        (label as! UILabel).textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        (label1 as! UILabel).textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        if progress == 1 {
            currentIndex = targetIndex
        }
    }
}

