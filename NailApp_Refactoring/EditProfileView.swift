//
//  EditProfileView.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/02.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class EditProfileView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var changeImageButton: UIButton!
//    @IBOutlet weak var saveButton: UIBarButtonItem!
//    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var nailistSwitch: UISwitch!
    @IBOutlet weak var viewForNailist: UIView!
    @IBOutlet weak var averageAgeTextField: UITextField!
    @IBOutlet weak var prefectureTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var averageCostTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var lineIdTextField: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var salonNameTextField: UITextField!
    
//    @IBOutlet weak var testButton: UIButton!
//    func init() {
//        cancelButton.
//    }

    required init?(coder aDecoder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
        //        super.layoutSubviews()
        //        //全体のサイズ
        //        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //        scrollView.frame = CGRect(x: 0,y: 0,width: screenWidth,height: screenWidth)
//        scrollView.contentSize = CGSizeMake(screenWidth, 1200)  //横幅は画面に合わせ、縦幅は1200とする。
    }

}
