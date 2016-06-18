//
//  SettingVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/02.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
//import NCMB

class SettingVC: UIViewController, UITableViewDelegate {
    private let mModel = SettingVM();
    
    @IBOutlet weak var tableView: UITableView!
//    override func loadView() {
//        let nib = UINib(nibName: "SettingView", bundle: nil)
//        self.view = nib.instantiateWithOwner(nil, options: nil)[0] as! UIView
////        self.view = SettingView();
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView, canFocusRowAtIndexPath: <#T##NSIndexPath#>
//        let settingView = self.view as! SettingView
        self.tableView.delegate = self;
        self.tableView.dataSource = mModel;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        
            
        case 0:
            
            if (NCMBUser.currentUser() == nil) {
                print("ログインせよ")
                // 未ログインの場合はポップアップを出して処理終了
                let alertController = UIAlertController(title: "Sorry!", message: "お気に入りをみるには会員になって！", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
                return

            }
            
            
            
            let detailUserVC = self.storyboard!.instantiateViewControllerWithIdentifier( "detailUserVC" ) as! DetailUserVC
            detailUserVC.userName = NCMBUser.currentUser().userName
            detailUserVC.ownORotherFlg = "1" // 1は自分
            gblUserName = NCMBUser.currentUser().userName
            self.navigationController?.pushViewController(detailUserVC, animated: true)
//            performSegueWithIdentifier("segueToDetailUserVC", sender: nil)
            
        case 1:
            
            self.navigationController?.pushViewController(LoginVC(), animated: true)
        //            performSegueWithIdentifier("segueToLoginVC", sender: nil)
        case 2:
            NCMBUser.logOut()
            
        case 3:
            self.navigationController?.showViewController(ViewController(), sender: true)
        default:
            break
            
        }
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
