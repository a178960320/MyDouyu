//
//  RecommendViewController.swift
//  Douyu
//
//  Created by 住梦iOS on 2017/2/28.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kItemW = (SCREEN_WIDTH - 3 * kItemMargin)/2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 8 / 7

class RecommendViewController: UIViewController {
    //ViewModel
    let recommentViewModel = RecommentViewModel()
    
    
    
    //MARK: - 懒加载属性
    lazy var collectionView:UICollectionView = {
        
        //1.定义布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2。创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "NormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NormalCell")
        collectionView.register(UINib.init(nibName: "PrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PrettyCell")
        collectionView.register(UINib.init(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        //设置collectionView随着父控件的缩小而缩小
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return collectionView
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //设置UI
        setupUI()
        
        //网络请求
        getNetData()
    }

    

}
//MARK: - 创建UI
extension RecommendViewController{
    func setupUI(){
        view.addSubview(collectionView)
    }
}
//MARK: - collection的协议代理
extension RecommendViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommentViewModel.anchorGroup[section]
        
        return group.room_list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        //1.定义cell
        var cell:BaseCollectionViewCell!
        
        //2.取出cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrettyCell", for: indexPath) as! BaseCollectionViewCell
            
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCell", for: indexPath) as! BaseCollectionViewCell
        }
        cell.model = recommentViewModel.anchorGroup[indexPath.section].room_list[indexPath.row]
        
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommentViewModel.anchorGroup.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headView", for: indexPath) as! HeaderCollectionReusableView
        
        //2.
        let group =  recommentViewModel.anchorGroup[indexPath.section]
        
        
        //3.
        headView.iconImageView.image = UIImage.init(named: group.icon_name)
        headView.titleLabel.text = group.tag_name
        
        return headView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }else{
            return CGSize(width: kItemW, height: kNormalItemH)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let liveVC = HomeLiveViewController()
        liveVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(liveVC, animated: true)
    }
}
//MARK: - 网络请求
extension RecommendViewController{
    func getNetData(){
        recommentViewModel.loadData { 
            self.collectionView.reloadData()
        }
    }
}
