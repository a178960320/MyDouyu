//
//  PageContentView.swift
//  Douyu
//
//  Created by 住梦iOS on 2017/2/24.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate:class {
    func pageContentView(pageContentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

class PageContentView: UIView {
    //代理
    weak var delegate:PageContentViewDelegate?
    
    //开始拖动的偏移量
    var startOffset:CGFloat = 0
    
    //MARK: - 懒加载
    lazy var collectionView:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let myCollectionView = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: layout)
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        myCollectionView.isPagingEnabled = true
        myCollectionView.backgroundColor = UIColor.white
        return myCollectionView
    }()
    
    

    //1.定义属性保存值
    weak var parentVC:UIViewController?
    
    var childVC:[UIViewController]
    
    
    init(frame:CGRect,childVC:[UIViewController],parentViewController:UIViewController) {
        self.parentVC = parentViewController
        self.childVC = childVC
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension PageContentView{
    func setupUI(){
        for vc in childVC{
            parentVC?.addChildViewController(vc)
        }
        addSubview(collectionView)
    }
}

extension PageContentView:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        //设置cell的内容
        let view = childVC[indexPath.row].view
        view?.frame = cell.contentView.bounds
        cell.contentView.addSubview(view!)
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVC.count
    }
    //监听滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.定义需要的数据
        var progress:CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //2.判断左滑还是右滑
        let currentOffset = scrollView.contentOffset.x
        if currentOffset >= startOffset {//左滑
            
            progress = (currentOffset/scrollView.frame.width) - floor(currentOffset/scrollView.frame.width)
            
            sourceIndex = Int(currentOffset / scrollView.frame.width)
            
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVC.count{
                targetIndex = childVC.count - 1
            }
            if currentOffset - startOffset == scrollView.frame.width {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{
            progress = 1 - (currentOffset/scrollView.frame.width - floor(currentOffset/scrollView.frame.width))
            
            targetIndex = Int(currentOffset/scrollView.frame.width)
            
            if currentOffset <= 0 {
                sourceIndex = 0
                return
            }
            
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVC.count{
                sourceIndex = childVC.count - 1
            }
            
        }
        
        
        delegate?.pageContentView(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}
///根据当前选中的index，设置pageContentView的偏移
extension PageContentView{
    func setCurrentInde(index:Int){
        collectionView.contentOffset = CGPoint(x: CGFloat(index) * collectionView.frame.width, y: 0)
    }
}
