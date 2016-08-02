//
//  TabBarController.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/06/18.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    var preSelectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print(self.selectedIndex)
        if (self.selectedIndex == TAB_UPLOAD && NCMBUser.currentUser() == nil) {
            self.selectedIndex = preSelectedIndex
            
            print("ログインせよ")
            // 未ログインの場合はポップアップを出して処理終了
            let alertController = UIAlertController(title: "Sorry!", message: "投稿するには会員になって！", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            return

        } else {
            preSelectedIndex = self.selectedIndex
        }
//        if viewController is TabBarDelegate {
//            let v = viewController as! TabBarDelegate
//            v.didSelectTab(self)
//        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
