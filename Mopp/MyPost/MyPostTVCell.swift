//
//  MyPostTVCell.swift
//  Mopp
//
//  Created by APPLE on 21/08/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import ImageSlideshow

class MyPostTVCell: UITableViewCell
{
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var lblSingleLater: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblImgCounter: UILabel!
    @IBOutlet weak var btnLikeCount: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var slideshowHightconstraints: NSLayoutConstraint! //300
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
