//
//  PrettyCollectionViewCell.swift
//  Douyu
//
//  Created by 住梦iOS on 2017/2/28.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

import UIKit
import Kingfisher

class PrettyCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var placeButton: UIButton!
    @IBOutlet weak var anchorLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    override var model: roomListModel?{
        didSet{
            if Float((model?.online)!)! > 10000 {
                onlineLabel.text = "\(Float((model?.online)!)!/10000)万"
            }else{
                onlineLabel.text = model?.online
            }
            placeButton.setTitle(model?.anchor_city, for: .normal)
            anchorLabel.text = model?.nickname
            coverImageView.kf.setImage(with: URL(string: (model?.room_src)!))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
