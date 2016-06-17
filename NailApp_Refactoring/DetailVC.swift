//
//  DetailVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/01.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    var imageCollectionObject: NCMBObject?
    var favDic: [Int:Bool] = [:]
    var detailVM: DetailVM?
    var index: Int = 0
    override func loadView() {
        let nib = UINib(nibName: "DetailView", bundle: nil)
        self.view = nib.instantiateWithOwner(nil, options: nil)[0] as! UIView
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailVM = DetailVM(imageCollectionObject: imageCollectionObject!)
        
//        detailVM!.addObserver(self, forKeyPath: "favFlg", options: [.New, .Old], context: nil)
//        detailVM!.addObserver(self, forKeyPath: "imageCollectionObject", options: [.New, .Old], context: nil)
        let detailView = self.view as! DetailView
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
        detailView.commentLabel.text = detailVM!.getComment()
        detailView.kawaiineCountLabel.text = String(detailVM!.getKawaiineCount())
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

        print("viewWillApper")
        detailVM!.addObserver(self, forKeyPath: "favFlg", options: [.New, .Old], context: nil)
        detailVM!.addObserver(self, forKeyPath: "imageCollectionObject", options: [.New, .Old], context: nil)
        detailVM!.addObserver(self, forKeyPath: "nickName", options: [.New, .Old], context: nil)
        
        detailVM!.checkFavFlg()
        detailVM!.getNailistName()

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
        detailVM!.removeObserver(self, forKeyPath: "nickName")
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
        

//        detailVM!.favFlg = !detailVM!.favFlg
        detailVM!.updateFavData()
//        detailVM!.favFlg = !detailVM!.favFlg
//        detailView.clipImage.image = UIImage(named: "unClipped.png")
        
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
            let detailView = self.view as! DetailView
            if (detailVM!.favFlg) {
                detailView.clipImage.image = UIImage(named: "Clipped.png")
//                detailVM!.imageCollectionObject!.incrementKey("kawaiine", byAmount: 1)
                detailView.kawaiineCountLabel.text = String(detailVM!.getKawaiineCount())
            } else {
                detailView.clipImage.image = UIImage(named: "unClipped.png")
//                detailVM!.imageCollectionObject!.incrementKey("kawaiine", byAmount: -1)
                detailView.kawaiineCountLabel.text = String(detailVM!.getKawaiineCount())
            }
        } else if (keyPath == "imageCollectionObject") {
            print("imageCollectionObjectのobserve")
            
        } else if (keyPath == "nickName") {
            print("nickNameのobserve")
            let detailView = self.view as! DetailView
            detailView.nailistBtn.setTitle(detailVM!.nickName, forState: .Normal)
        
        }
    
    
    }

}
