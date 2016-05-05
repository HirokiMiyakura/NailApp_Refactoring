//
//  DetailUserView.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/01.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class DetailUserView: UIView {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileCommentLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBAction func editProfileButtonAction(sender: AnyObject) {
    }
    @IBOutlet weak var editProfileButtonOutlet: UIButton!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init() {
        
        super.init(frame: CGRectMake(0, 0, 0, 0));
        
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.frame = CGRectMake(50, 50, 50, 50)
    }

}
