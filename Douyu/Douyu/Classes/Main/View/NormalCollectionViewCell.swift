//
//  NormalCollectionViewCell.swift
//  Douyu
//
//  Created by 住梦iOS on 2017/2/28.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

import UIKit

class NormalCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var onlineLabel: UIButton!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var anchorNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override var model: roomListModel?{
        didSet{
            if Float(model!.online)! > 10000 {
                onlineLabel.setTitle("\(Float(model!.online)!/10000)万", for: .normal)
            }else{
                onlineLabel.setTitle(model?.online, for: .normal)
            }
            
            //            coverImageView.image =
            anchorNameLabel.text = model?.nickname
            titleLabel.text = model?.room_name
            coverImageView.kf.setImage(with: URL(string: model!.room_src))
        }
    }
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

}
