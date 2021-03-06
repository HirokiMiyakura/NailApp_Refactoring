//
//  DetailVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/01.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
import Social

class DetailVC: UIViewController {
    var imageCollectionObject: NCMBObject?
    var favDic: [Int:Bool] = [:]
    var detailVM: DetailVM?
    var index: Int = 0
    override func loadView() {
        let nib = UINib(nibName: "DetailView2", bundle: nil)
        self.view = nib.instantiateWithOwner(nil, options: nil)[0] as! UIView
        
        
    }

    override func viewDidLoad() {
        print("DetailVCのviewDidLoad")
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        detailVM = DetailVM(imageCollectionObject: imageCollectionObject!)
        
//        detailVM!.addObserver(self, forKeyPath: "favFlg", options: [.New, .Old], context: nil)
//        detailVM!.addObserver(self, forKeyPath: "imageCollectionObject", options: [.New, .Old], context: nil)
        let detailView = self.view as! DetailView2
        
//        print(detailView.scrollView.frame)
//        detailView.userInteractionEnabled = true
//        detailView.nailistBtn.userInteractionEnabled = true
        detailView.nailistBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailVC.nailistBtnTapped(_:))))
        
        
        // observe仕様に変えたから下記は不要だな。
        let favFlg = favDic[index]
//        if (favFlg!) {
//            detailView.clipImage.image = UIImage(named: "Clipped.png")
//        } else {
//            detailView.clipImage.image = UIImage(named: "unClipped.png")
//        }
//        detailVM!.checkFavFlg()
//        detailView.clipImage.image = UIImage(named: "Clipped.png")
        detailView.clipImage.userInteractionEnabled = true
        detailView.clipImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailVC.clipImageTapped(_:))))
        detailView.shareImage.userInteractionEnabled = true
        detailView.shareImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailVC.shareImageTapped(_:))))
        detailView.shareImage.image = UIImage(named: "share.png")
        detailView.commentLabel.text = detailVM!.getComment()
        detailView.kawaiineCountLabel.text = String(detailVM!.getKawaiineCount()) + "人がクリップしています。"
        let url = NSURL(string: (self.imageCollectionObject!.objectForKey("imagePath") as? String)!)
        let placeholder = UIImage(named: "transparent.png")
        detailView.detailImage.setImageWithURL(detailVM!.getURL(), placeholderImage: placeholder)
//        detailVM!.setImage(detailView.detailImage)
//        detailView.nailistBtn.setTitle(detailVM!.getNailistName(), forState: .Normal)
        
//        detailView.scrollView.touchesBegan(<#T##touches: Set<UITouch>##Set<UITouch>#>, withEvent: <#T##UIEvent?#>)
//        detailView.scrollView.delegate = self
        
        
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let detailView = self.view as! DetailView
//        
//        detailView.nailistBtn.touchesBegan(touches, withEvent: event)
        
        print("aaaaa")
    }
    override func viewWillAppear(animated: Bool) {

        print("DetailVCのviewWillApper")
        detailVM!.addObserver(self, forKeyPath: "favFlg", options: [.New, .Old], context: nil)
        detailVM!.addObserver(self, forKeyPath: "imageCollectionObject", options: [.New, .Old], context: nil)
        detailVM!.addObserver(self, forKeyPath: "profileInfo", options: [.New, .Old], context: nil)
        
        detailVM!.checkFavFlg()
        detailVM!.loadProfileInfo()

//        super.viewWillAppear(animated)
//        let detailView = self.view as! DetailView
//            detailView.userInteractionEnabled = true
//        detailView.scrollView.translatesAutoresizingMaskIntoConstraints = false
//        detailView.scrollView.contentSize = CGSizeMake(screenWidth, screenWidth*3)  //横幅は画面に合わせ、縦幅は1200とする。
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisapper")
        detailVM!.removeObserver(self, forKeyPath: "favFlg")
        detailVM!.removeObserver(self, forKeyPath: "imageCollectionObject")
        detailVM!.removeObserver(self, forKeyPath: "profileInfo")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func nailistBtnTapped(sender: UITapGestureRecognizer) {
        print("nailistBtnTapped")
        let detailUserVC = self.storyboard!.instantiateViewControllerWithIdentifier( "detailUserVC" ) as! DetailUserVC
        detailUserVC.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        detailUserVC.userName = self.imageCollectionObject?.objectForKey("userName") as? String
        detailUserVC.ownORotherFlg = "2"
        gblUserName = self.imageCollectionObject?.objectForKey("userName") as? String
        self.navigationController?.pushViewController(detailUserVC, animated: true)
        
    }
    
    func clipImageTapped(sender: UITapGestureRecognizer) {
        print("clipImageTapped")
        if (NCMBUser.currentUser() == nil) {
            print("ログインせよ")
            // 未ログインの場合はポップアップを出して処理終了
            let alertController = UIAlertController(title: "Sorry!", message: "カワイイネをするには会員になって！", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            return
            
        }

//        detailVM!.favFlg = !detailVM!.favFlg
        detailVM!.updateFavData()
//        detailVM!.favFlg = !detailVM!.favFlg
//        detailView.clipImage.image = UIImage(named: "unClipped.png")
        
    }
    
    func shareImageTapped(sender: UITapGestureRecognizer) {
        print("shareImageTapped")
        
        
        let alertController = UIAlertController(title: "Share", message: "", preferredStyle: .Alert)
        
        let editProfileAction = UIAlertAction(title: "Facebookで共有", style: .Default, handler: {
            (action:UIAlertAction!) -> Void in
            print("Facebook共有します")
            let text = "facebook share text"
            
            let composeViewController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
            composeViewController.setInitialText(text)
            
            self.presentViewController(composeViewController, animated: true, completion: nil)
            
        })
        
        let editImageAction = UIAlertAction(title: "Twitterで共有", style: .Default, handler: {
            (action:UIAlertAction!) -> Void in
            print("Twitterで共有します")
            let text = "twitter share text"
            
            let composeViewController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
            composeViewController.setInitialText(text)
            
            self.presentViewController(composeViewController, animated: true, completion: nil)

            
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
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        let controller = segue.destinationViewController as! DetailUserVC
//        controller.userName = self.imageCollectionObject?.objectForKey("userName") as? String
////        controller.ownORotherFlg = "2"
//        
//        
//    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        NSLog("Called")
        print(keyPath)
        //        print(change)
        if (keyPath == "favFlg") {
            let detailView = self.view as! DetailView2
            if (detailVM!.favFlg) {
                detailView.clipImage.image = UIImage(named: "heart_like.png")
//                detailVM!.imageCollectionObject!.incrementKey("kawaiine", byAmount: 1)
                detailView.kawaiineCountLabel.text = String(detailVM!.getKawaiineCount()) + "人がクリップしています。"
            } else {
                detailView.clipImage.image = UIImage(named: "heart_unlike.png")
//                detailVM!.imageCollectionObject!.incrementKey("kawaiine", byAmount: -1)
                detailView.kawaiineCountLabel.text = String(detailVM!.getKawaiineCount()) + "人がクリップしています。"
            }
        } else if (keyPath == "imageCollectionObject") {
            print("imageCollectionObjectのobserve")
            
        } else if (keyPath == "profileInfo") {
            print("profileInfoのobserve")
            let url = NSURL(string: (detailVM!.profileInfo[0].objectForKey("imagePath") as? String)!)
            let placeholder = UIImage(named: "transparent.png")
            let detailView = self.view as! DetailView2
            detailView.nailistBtn.setTitle((detailVM!.profileInfo[0].objectForKey("nickName") as? String)!, forState: .Normal)
            detailView.userImage.setImageWithURL(url, placeholderImage: placeholder)
//            detailView.nailistBtn.setTitle(detailVM!.nickName, forState: .Normal)
        
        }
    
    
    }

}
