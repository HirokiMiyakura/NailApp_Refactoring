//
//  DetailUserVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/01.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class DetailUserVC: UIViewController {
    var userName: String?
    var ownORotherFlg: String?
    private var mModel: DetailUserVM?

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var profileCommentLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    var topViewXIB: DetailUserView!
    
//    override func loadView() {
//        let nib = UINib(nibName: "DetailUserView", bundle: nil)
//        self.topView = nib.instantiateWithOwner(nil, options: nil)[0] as! UIView
//        
//        
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        let nib = UINib(nibName: "DetailUserView", bundle: nil)
//        topViewXIB = nib.instantiateWithOwner(nil, options: nil)[0] as! DetailUserView
//        self.topView.addSubview(topViewXIB)
        
        self.navigationItem.title = "プロフィール"
        
        mModel = DetailUserVM(userName: self.userName!)
//        mModel = DetailUserVM()
//        topViewXIB.profileCommentLabel.text = "saito"
//        self.topView = nib.instantiateWithOwner(nil, options: nil)[0] as! UIView
//        self.view.addSubview(nib.instantiateWithOwner(nil, options: nil)[0] as! UIView)
//        self.view = nib.instantiateWithOwner(nil, options: nil)[0] as! UIView

        // Do any additional setup after loading the view.
//        topViewXIB.editProfileButtonOutlet.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailUserVC.editProfileButtonOutletTapped(_:))))
        
        if (ownORotherFlg != "2") {
//            topViewXIB.editProfileButtonOutlet.hidden = true
            // show search button and set action
            var rightSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(DetailUserVC.editButton))
            // add the button to navigationBar
            self.navigationItem.setRightBarButtonItems([rightSearchBarButtonItem], animated: true)

        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        mModel!.addObserver(self, forKeyPath: "profileInfo", options: [.New, .Old], context: nil)
        mModel!.loadProfileInfo()
//        self.setProfile()
        
        
//        performSegueWithIdentifier("segueToCollectionView",sender: nil)
        
    }
    override func viewWillDisappear(animated: Bool) {
        mModel!.removeObserver(self, forKeyPath: "profileInfo")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    override func shouldAutomaticallyForwardAppearanceMethods() -> Bool {
//        return false
//    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        NSLog("Called")
//        topViewXIB.profileCommentLabel.text = mModel?.profileInfo[0].objectForKey("comment") as? String
        self.profileCommentLabel.text = mModel?.profileInfo[0].objectForKey("comment") as? String
//        topViewXIB.nickNameLabel.text = mModel?.profileInfo[0].objectForKey("nickName") as? String
        self.nickNameLabel.text = mModel?.profileInfo[0].objectForKey("nickName") as? String
        let placeholder = UIImage(named: "transparent.png")
//        topViewXIB.profileImage.setImageWithURL(NSURL(string: (mModel?.profileInfo[0].objectForKey("imagePath") as? String)!), placeholderImage: placeholder)
        if mModel?.profileInfo[0].objectForKey("imagePath") == nil {
            return
        }
        self.profileImage.setImageWithURL(NSURL(string: (mModel?.profileInfo[0].objectForKey("imagePath") as? String)!), placeholderImage: placeholder)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("segue！！")
        if (segue.identifier == "segueToEdit") {
            // プロフィール編集処理画面遷移時
//            let controller = segue.destinationViewController as! editProfileViewController
//            controller.tmpNickName = self.nickName.text
//            controller.tmpProfileComment = self.ProfileComment.text
            
        } else if (segue.identifier == "segueToCollectionView") {
            let controller = segue.destinationViewController as! CollectionVC
            controller.userName = self.userName!
            if (ownORotherFlg == "1") {
                controller.tabKind = "5"
            } else if (ownORotherFlg == "2"){
                controller.tabKind = "4"
            }
            
        } else if (segue.identifier == "segueToDetailProfile") {
            let controller = segue.destinationViewController as! DetailUserHomeTabVC
            controller.userName = self.userName!
        }
        
        
    }
//    func editProfileButtonOutletTapped(sender: UITapGestureRecognizer) {
//        let editProfileVC = self.storyboard!.instantiateViewControllerWithIdentifier( "editProfileVC" ) as! EditProfileVC
//        editProfileVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
////        detailUserVC.userName = self.imageCollectionObject?.objectForKey("userName") as? String
////        detailUserVC.ownORotherFlg = "2"
////        gblUserN?ame = self.imageCollectionObject?.objectForKey("userName") as? String
////        editProfileVC.
//        editProfileVC.commentTextView = topViewXIB.profileCommentLabel.text!
//        editProfileVC.nickNameTextField = topViewXIB.nickNameLabel.text!
//        if(topViewXIB.profileImage != nil) {
//            editProfileVC.imageView = topViewXIB.profileImage
//        }
//        
//        self.presentViewController(editProfileVC, animated: true, completion: nil)
////        self.navigationController?.pushViewController(editProfileVC, animated: true)
//        
//    }
    
    func editButton() {
        
        // ログイン成功時の処理
        let alertController = UIAlertController(title: "編集", message: "", preferredStyle: .Alert)
        
        let editProfileAction = UIAlertAction(title: "プロフィール編集", style: .Default, handler: {
            (action:UIAlertAction!) -> Void in
            print("プロフィール編集します")
            let editProfileVC = self.storyboard!.instantiateViewControllerWithIdentifier( "editProfileVC" ) as! EditProfileVC
            editProfileVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            //        detailUserVC.userName = self.imageCollectionObject?.objectForKey("userName") as? String
            //        detailUserVC.ownORotherFlg = "2"
            //        gblUserN?ame = self.imageCollectionObject?.objectForKey("userName") as? String
            //        editProfileVC.
            if(self.profileCommentLabel.text != nil) {
                editProfileVC.commentTextView = self.profileCommentLabel.text!
            }
            if(self.nickNameLabel.text != nil) {
                    editProfileVC.nickNameTextField = self.nickNameLabel.text!
            }
            if(self.profileImage != nil) {
                editProfileVC.imageView = self.profileImage
            }
            
            self.presentViewController(editProfileVC, animated: true, completion: nil)

        })
        
        let editImageAction = UIAlertAction(title: "投稿写真編集", style: .Default, handler: {
            (action:UIAlertAction!) -> Void in
            print("投稿写真編集します")
            
            let editImageVC = self.storyboard!.instantiateViewControllerWithIdentifier( "collectionEditVC" ) as! CollectionEditVC
//            self.pushViewController(editImageVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(editImageVC, animated: true)
        })
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Default, handler: {
            (action:UIAlertAction!) -> Void in
            print("キャンセルします")
        })

        alertController.addAction(editProfileAction)
        alertController.addAction(editImageAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
}
