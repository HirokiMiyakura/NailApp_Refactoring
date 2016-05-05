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
    var detailVM: DetailVM?
    override func loadView() {
        let nib = UINib(nibName: "DetailView", bundle: nil)
        self.view = nib.instantiateWithOwner(nil, options: nil)[0] as! UIView
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailVM = DetailVM(imageCollectionObject: imageCollectionObject!)
        let detailView = self.view as! DetailView
        detailView.userInteractionEnabled = true
        detailView.nailistBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailVC.nailistBtnTapped(_:))))
        
        
        detailView.commentLabel.text = detailVM!.getComment()
        detailView.kawaiineCountLabel.text = String(detailVM!.getKawaiineCount())
        let url = NSURL(string: (self.imageCollectionObject!.objectForKey("imagePath") as? String)!)
        let placeholder = UIImage(named: "transparent.png")
        detailView.detailImage.setImageWithURL(detailVM!.getURL(), placeholderImage: placeholder)
//        detailVM!.setImage(detailView.detailImage)
        detailView.nailistBtn.setTitle(detailVM!.getNailistName(), forState: .Normal)
        
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
    
    func nailistBtnTapped(sender: UITapGestureRecognizer) {
        let detailUserVC = self.storyboard!.instantiateViewControllerWithIdentifier( "detailUserVC" ) as! DetailUserVC
        detailUserVC.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        detailUserVC.userName = self.imageCollectionObject?.objectForKey("userName") as? String
        detailUserVC.ownORotherFlg = "2"
        gblUserName = self.imageCollectionObject?.objectForKey("userName") as? String
        self.navigationController?.pushViewController(detailUserVC, animated: true)
        
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        let controller = segue.destinationViewController as! DetailUserVC
//        controller.userName = self.imageCollectionObject?.objectForKey("userName") as? String
////        controller.ownORotherFlg = "2"
//        
//        
//    }

}
