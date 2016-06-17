//
//  MyScrollView.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/06/12.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class MyScrollView: UIScrollView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        superview?.touchesBegan(touches, withEvent: event)
        print("MyScrollView-touchBegan")
    }

}
