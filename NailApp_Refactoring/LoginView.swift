//
//  LoginView.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/02.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class LoginView: UIView {

    @IBOutlet weak var authButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
//    @IBAction func authButton(sender: AnyObject) {
//    }
//    @IBAction func loginButton(sender: AnyObject) {
//        
//        // メールアドレスとパスワードでログイン
//        NCMBUser.logInWithMailAddressInBackground(eMailTextField.text, password: passwordTextField.text, block: ({(user, error) in
//            if (error != nil){
//                // ログイン失敗時の処理
//                let alertController = UIAlertController(title: "Sorry!", message: "ログイン失敗です。原因は謎。", preferredStyle: .Alert)
//                
//                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//                alertController.addAction(defaultAction)
//                
//                self.presentViewController(alertController, animated: true, completion: nil)
//                
//            }else{
//                // ログイン成功時の処理
//                let alertController = UIAlertController(title: "Thank You!", message: "ログイン成功！", preferredStyle: .Alert)
//                
//                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//                alertController.addAction(defaultAction)
//                
//                self.presentViewController(alertController, animated: true, completion: self.hiroki)
//
//            }
//        }))
//
//    }
    @IBOutlet weak var emailShinkiTextField: UITextField!
    @IBOutlet weak var eMailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    // 角丸の半径(0で四角形)
//    @IBInspectable var cornerRadius: CGFloat = 0.0
//    
//    // 枠
//    @IBInspectable var borderColor: UIColor = UIColor.clearColor()
//    @IBInspectable var borderWidth: CGFloat = 0.0
//    
//    override func drawRect(rect: CGRect) {
//        // 角丸
//        self.layer.cornerRadius = cornerRadius
//        self.clipsToBounds = (cornerRadius > 0)
//        
//        // 枠線
//        self.layer.borderColor = borderColor.CGColor
//        self.layer.borderWidth = borderWidth
//        
//        // 背景
//        //        self.backgroundColor = UIColor.whiteColor()
//        
//        super.drawRect(rect)
//    }

}
