//
//  DetailView.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/01.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class DetailView: UIView {
    @IBOutlet weak var detailImage: UIImageView!

    @IBOutlet weak var nailistBtn: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var shareImage: UIImageView!

    @IBOutlet weak var clipImage: UIImageView!
    @IBOutlet weak var kawaiineCountLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func layoutSubviews() {
        scrollView.contentSize = CGSizeMake(screenWidth, 1200)
    }
}
