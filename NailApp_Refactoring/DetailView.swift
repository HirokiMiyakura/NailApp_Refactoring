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
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
////        self.userInteractionEnabled = true
////        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollectionViewCell.cellTapped(_:))))
//        
////        //全体のサイズ
////        scrollView.translatesAutoresizingMaskIntoConstraints = true
////        scrollView.contentSize = CGSizeMake(screenWidth, 1200)  //横幅は画面に合わせ、縦幅は1200とする。
//    }
//    
    override func layoutSubviews() {
//        super.layoutSubviews()
        //        //全体のサイズ
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.frame = CGRect(x: 0,y: 0,width: screenWidth,height: screenWidth)
        scrollView.contentSize = CGSizeMake(screenWidth, 1200)  //横幅は画面に合わせ、縦幅は1200とする。
    }
}
