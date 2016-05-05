//
//  CollectionViewCell.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/04/30.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.userInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollectionViewCell.cellTapped(_:))))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        image!.frame = self.contentView.frame
    }
    
    func cellTapped(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vs: PageViewManagerVC = storyboard.instantiateViewControllerWithIdentifier("pageViewManagerVC") as! PageViewManagerVC
        // アニメーション設定
        vs.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        // 画面遷移
//        self.presentViewController(vs, animated: true, completion: nil)
    }
    
    

}
