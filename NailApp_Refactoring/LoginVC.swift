//
//  LoginVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/02.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    var loginView: LoginView?
    
    override func loadView() {
        let nib = UINib(nibName: "LoginView", bundle: nil)
        self.view = nib.instantiateWithOwner(nil, options: nil)[0] as! UIView
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginView = self.view as! LoginView!
        
        
        
        loginView!.loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginVC.loginButtonTapped(_:))))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loginButtonTapped(sender: UITapGestureRecognizer) {
        // メールアドレスとパスワードでログイン
        NCMBUser.logInWithMailAddressInBackground(loginView!.eMailTextField.text, password: loginView!.passwordTextField.text, block: ({(user, error) in
            if (error != nil){
                // ログイン失敗時の処理
                let alertController = UIAlertController(title: "Sorry!", message: "ログイン失敗です。原因は謎。", preferredStyle: .Alert)

                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)

                self.presentViewController(alertController, animated: true, completion: nil)

            }else{
                // ログイン成功時の処理
                let alertController = UIAlertController(title: "Thank You!", message: "ログイン成功！", preferredStyle: .Alert)

                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: {
                    (action:UIAlertAction!) -> Void in
                    self.closeMyView()
                })
                alertController.addAction(defaultAction)

                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
        }))
        
    }
    
    func closeMyView() {
//        self.navigationController?.popViewControllerAnimated(true)
        // ① 2番目のタブのViewControllerを取得する
        let tabVC0 = self.tabBarController!.viewControllers![0];
        // ② 2番目のタブを選択済みにする
        self.tabBarController!.selectedViewController = tabVC0;
        // ③ UINavigationControllerに追加済みのViewを一旦取り除く
        self.navigationController?.popViewControllerAnimated(true)
//        tabVC0.popToRootViewControllerAnimated = false
//        [vc popToRootViewControllerAnimated:NO];
        // ④ SecondViewの画面遷移処理を呼び出す
//        tabVC0.viewControllers
//        [vc.viewControllers[0] performSegueWithIdentifier:@"ThirdViewを呼び出す" sender:nil];

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        loginView = self.view as! LoginView!
        loginView?.eMailTextField.resignFirstResponder()
        loginView?.passwordTextField.resignFirstResponder()
        
    }

}
