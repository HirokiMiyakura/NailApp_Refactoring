//
//  EditDetailVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/06/18.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class EditDetailVC: UIViewController {

//    var indexPath: NSIndexPath = NSIndexPath()
//    var imageInfo = []
    var imageCollectionObject: NCMBObject?
    var detailVM: DetailVM?
    var editImageDataVM: EditImageDataVM?
    
    override func loadView() {
        let nib = UINib(nibName: "EditDetailView", bundle: nil)
        self.view = nib.instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailVM = DetailVM(imageCollectionObject: imageCollectionObject!)
        editImageDataVM = EditImageDataVM()
        let editDetailView = self.view as! EditDetailView
        let placeholder = UIImage(named: "transparent.png")
        editDetailView.imageView.setImageWithURL(detailVM!.getURL(), placeholderImage: placeholder)
        editDetailView.textField.text = detailVM!.getComment()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: Selector("saveData"))
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
    
    override func viewWillAppear(animated: Bool) {
        
        print("viewWillApper")
//        detailVM!.addObserver(self, forKeyPath: "imageCollectionObject", options: [.New, .Old], context: nil)
        editImageDataVM!.addObserver(self, forKeyPath: "uploadDoneFlg", options: [.New, .Old], context: nil)
        
        //        super.viewWillAppear(animated)
        //        let detailView = self.view as! DetailView
        //            detailView.userInteractionEnabled = true
        //        detailView.scrollView.translatesAutoresizingMaskIntoConstraints = false
        //        detailView.scrollView.contentSize = CGSizeMake(screenWidth, screenWidth*3)  //横幅は画面に合わせ、縦幅は1200とする。
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisapper")
//        detailVM!.removeObserver(self, forKeyPath: "imageCollectionObject")
        editImageDataVM!.removeObserver(self, forKeyPath: "uploadDoneFlg")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        NSLog("Called")
        
        if (keyPath == "uploadDoneFlg") {
            LoadingProxy.off();//ローディング表示。非表示にする場合はoff
            self.navigationController?.popViewControllerAnimated(true)
        }
    }


    // addBtnをタップしたときのアクション
    func saveData() {
        LoadingProxy.set(self); //表示する親をセット
        LoadingProxy.on();//ローディング表示。非表示にする場合はoff
        let editDetailView = self.view as! EditDetailView
        var objectIdOfImageInfo: String
        objectIdOfImageInfo = imageCollectionObject!.objectForKey("objectId")! as! String
        let param1 = [
            "objectId" : objectIdOfImageInfo,
            "textField" : editDetailView.textField.text!,
//            "commentTextView" : view!.commentTextView.text,
//            "image" : view!.profileImageView,
//            "mailAddress" : view!.mailTextField.text!,
//            "tel" : view!.telTextField.text!,
//            "salonName" : view!.salonNameTextField.text!,
//            "locationPrefecture" : view!.prefectureTextField.text!,
//            "locationCity" : view!.cityTextField.text!,
//            "lineId" : view!.lineIdTextField.text!,
//            "url" : view!.urlTextField.text!,
//            "averageAge" : view!.averageAgeTextField.text!,
//            "averageCost" : view!.averageCostTextField.text!,
//            "nailistFlg" : view!.nailistSwitch.on,
            //            "time" : String(time)
            ] as Dictionary<String, AnyObject>
        
        editImageDataVM!.updateImageData(param1)
//        self.navigationController?.pushViewController(second, animated: true)
    }
    

}
