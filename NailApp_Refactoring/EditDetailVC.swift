//
//  EditDetailVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/06/18.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class EditDetailVC: UIViewController {
    
    var colorPinkBtnFlg: Bool = false
    var colorBlueBtnFlg: Bool = false
    var lengthLongBtnFlg: Bool = false
    var lengthShortBtnFlg: Bool = false
    var sceneOfficeBtnFlg: Bool = false
    var sceneDateBtnFlg: Bool = false
    var colorSign: String = "0"
    var lengthSign: String = "0"
    var sceneSign: String = "0"
    var signArray: [String] = []
    var signDictionary = [:] as Dictionary<String, String>
    var signDictionary2 = [
        "colorPinkBtnFlg": false,
        "colorBlueBtnFlg": false,
        "lengthLongBtnFlg": false,
        "lengthShortBtnFlg": false,
        "sceneOfficeBtnFlg": false,
        "sceneDateBtnFlg": false,
        "colorSign": "0",
        "lengthSign": "0",
        "sceneSign": "0"
        ] as Dictionary<String, AnyObject>

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
        print("editDetailView.scrollView.contentSize")
        print(editDetailView.scrollView.contentSize)
//        editDetailView.scrollView.translatesAutoresizingMaskIntoConstraints = false
//        editDetailView.scrollView.contentSize = CGSizeMake(screenWidth, screenWidth*3)
        let placeholder = UIImage(named: "transparent.png")
        editDetailView.imageView.setImageWithURL(detailVM!.getURL(), placeholderImage: placeholder)
        editDetailView.textField.text = detailVM!.getComment()
        setSign(detailVM!.getAllSign())
        setTouchFunction()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "更新", style:.Bordered, target: self, action: Selector("saveData"))
        
        self.navigationItem.title = "画像編集"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setTouchFunction() {
        let editDetailView = self.view as! EditDetailView
        editDetailView.colorPinkBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditDetailVC.colorPinkBtnTapped(_:))))
        editDetailView.colorBlueBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditDetailVC.colorBlueBtnTapped(_:))))
        editDetailView.lengthLongBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditDetailVC.lengthLongBtnTapped(_:))))
        editDetailView.lengthShortBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditDetailVC.lengthShortBtnTapped(_:))))
        editDetailView.sceneOfficeBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditDetailVC.sceneOfficeBtnTapped(_:))))
        editDetailView.sceneDateBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditDetailVC.sceneDateBtnTapped(_:))))

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
//                detailView.scrollView.contentSize = CGSizeMake(screenWidth, screenWidth*3)  //横幅は画面に合わせ、縦幅は1200とする。
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

    func setSign(allSign: Dictionary<String,String>) {
        let editDetailView = self.view as! EditDetailView
        // 固定
        let signDefine = [
            "typeColor" :["colorSign",["colorPinkBtn","1",editDetailView.colorPinkBtn,"colorPinkBtnFlg"],["colorBlueBtn","2",editDetailView.colorBlueBtn,"colorBlueBtnFlg"]],
            "typeLength" :["lengthSign",["lengthLongBtn","1",editDetailView.lengthLongBtn,"lengthLongBtnFlg"],["lengthShortBtn","2",editDetailView.lengthShortBtn,"lengthShortBtnFlg"]],
            "typeScene" :["sceneSign",["sceneOfficeBtn","1",editDetailView.sceneOfficeBtn,"sceneOfficeBtnFlg"],["sceneDateBtn","2",editDetailView.sceneDateBtn,"sceneDateBtnFlg"]],
        ] as Dictionary<String, NSArray>
        
        for (colNameParam,signParam) in allSign {
//            print(colNameParam)
            for (colNameDef,signDef) in signDefine {
//                print(colNameDef)
//                print(signDef)
                if (colNameParam == colNameDef) {
                    for (var i = 1; i < signDef.count; i += 1) {
                        if (signDef[i][1] == signParam) {
                            let btnObj = (signDef[i] as! NSArray)[2] as! CustomButton
                            btnObj.backgroundColor = btnObj.currentTitleColor
                            btnObj.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                            let btnFlgStr = (signDef[i] as! NSArray)[3] as! String
                            signDictionary2[btnFlgStr] = true
                            
                            let btnSignString = signDef[0] as! String
                            signDictionary2[btnSignString] = (signDef[i] as! NSArray)[1] as! String
//                            btnSign = (signDef[i] as! NSArray)[1] as! String
                        }
                    }
                }
            }
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
            "typeLength" : signDictionary2["lengthSign"]!,
            "typeColor" : signDictionary2["colorSign"]!,
            "typeScene" : signDictionary2["sceneSign"]!
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
    
    func colorPinkBtnTapped(sender: UITapGestureRecognizer) {
        let editDetailView = self.view as! EditDetailView
//        colorPinkBtnFlg = !colorPinkBtnFlg
        let tmpFlg = signDictionary2["colorPinkBtnFlg"] as! Bool
        signDictionary2["colorPinkBtnFlg"] = !tmpFlg
        if (signDictionary2["colorPinkBtnFlg"] as! Bool) {
            
            editDetailView.colorPinkBtn.backgroundColor = editDetailView.colorPinkBtn.currentTitleColor
            editDetailView.colorPinkBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            signDictionary2["colorSign"] = "1"
            signDictionary["typeColor"] = "1"
            
        } else {
            editDetailView.colorPinkBtn.setTitleColor(editDetailView.colorPinkBtn.backgroundColor, forState: UIControlState.Normal)
            editDetailView.colorPinkBtn.backgroundColor = UIColor.whiteColor()
            signDictionary2["colorSign"] = "0"
            signDictionary["typeColor"] = "0"
        }
    }
    func colorBlueBtnTapped(sender: UITapGestureRecognizer) {
        let editDetailView = self.view as! EditDetailView
        let tmpFlg = signDictionary2["colorBlueBtnFlg"] as! Bool
        signDictionary2["colorBlueBtnFlg"] = !tmpFlg
//        colorBlueBtnFlg = !colorBlueBtnFlg
        if (signDictionary2["colorBlueBtnFlg"] as! Bool) {
            
            editDetailView.colorBlueBtn.backgroundColor = editDetailView.colorBlueBtn.currentTitleColor
            editDetailView.colorBlueBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            signDictionary2["colorSign"] = "2"
            signDictionary["typeColor"] = "2"
            
        } else {
            editDetailView.colorBlueBtn.setTitleColor(editDetailView.colorBlueBtn.backgroundColor, forState: UIControlState.Normal)
            editDetailView.colorBlueBtn.backgroundColor = UIColor.whiteColor()
            signDictionary2["colorSign"] = "0"
            signDictionary["typeColor"] = "0"
        }
    }
    func lengthLongBtnTapped(sender: UITapGestureRecognizer) {
        let editDetailView = self.view as! EditDetailView
//        lengthLongBtnFlg = !lengthLongBtnFlg
        let tmpFlg = signDictionary2["lengthLongBtnFlg"] as! Bool
        signDictionary2["lengthLongBtnFlg"] = !tmpFlg
        
        if (signDictionary2["lengthLongBtnFlg"] as! Bool) {
            
            editDetailView.lengthLongBtn.backgroundColor = editDetailView.lengthLongBtn.currentTitleColor
            editDetailView.lengthLongBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            signDictionary2["lengthSign"] = "1"
            signDictionary["typeLength"] = "1"
            
        } else {
            editDetailView.lengthLongBtn.setTitleColor(editDetailView.lengthLongBtn.backgroundColor, forState: UIControlState.Normal)
            editDetailView.lengthLongBtn.backgroundColor = UIColor.whiteColor()
            signDictionary2["lengthSign"] = "0"
            signDictionary["typeLength"] = "0"
        }
    }
    func lengthShortBtnTapped(sender: UITapGestureRecognizer) {
        let editDetailView = self.view as! EditDetailView
        let tmpFlg = signDictionary2["lengthShortBtnFlg"] as! Bool
        signDictionary2["lengthShortBtnFlg"] = !tmpFlg 
//        lengthShortBtnFlg = !tmpFlg
        if (signDictionary2["lengthShortBtnFlg"] as! Bool) {
            
            editDetailView.lengthShortBtn.backgroundColor = editDetailView.lengthShortBtn.currentTitleColor
            editDetailView.lengthShortBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            signDictionary2["lengthSign"] = "2"
            signDictionary["typeLength"] = "2"
            
        } else {
            editDetailView.lengthShortBtn.setTitleColor(editDetailView.lengthShortBtn.backgroundColor, forState: UIControlState.Normal)
            editDetailView.lengthShortBtn.backgroundColor = UIColor.whiteColor()
            signDictionary2["lengthSign"] = "0"
            signDictionary["typeLength"] = "0"
        }
    }
    func sceneOfficeBtnTapped(sender: UITapGestureRecognizer) {
        let editDetailView = self.view as! EditDetailView
//        sceneOfficeBtnFlg = !sceneOfficeBtnFlg
        let tmpFlg = signDictionary2["sceneOfficeBtnFlg"] as! Bool
        signDictionary2["sceneOfficeBtnFlg"] = !tmpFlg
        if (signDictionary2["sceneOfficeBtnFlg"] as! Bool) {
            
            editDetailView.sceneOfficeBtn.backgroundColor = editDetailView.sceneOfficeBtn.currentTitleColor
            editDetailView.sceneOfficeBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            signDictionary2["sceneSign"] = "1"
            signDictionary["typeScene"] = "1"
            
        } else {
            editDetailView.sceneOfficeBtn.setTitleColor(editDetailView.sceneOfficeBtn.backgroundColor, forState: UIControlState.Normal)
            editDetailView.sceneOfficeBtn.backgroundColor = UIColor.whiteColor()
            signDictionary2["sceneSign"] = "0"
            signDictionary["typeScene"] = "0"
        }
    }
    func sceneDateBtnTapped(sender: UITapGestureRecognizer) {
        let editDetailView = self.view as! EditDetailView
//        sceneDateBtnFlg = !sceneDateBtnFlg
        let tmpFlg = signDictionary2["sceneDateBtnFlg"] as! Bool
        signDictionary2["sceneDateBtnFlg"] = !tmpFlg
        if (signDictionary2["sceneDateBtnFlg"] as! Bool) {
            
            editDetailView.sceneDateBtn.backgroundColor = editDetailView.sceneDateBtn.currentTitleColor
            editDetailView.sceneDateBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            signDictionary2["sceneSign"] = "2"
            signDictionary["typeScene"] = "2"
            
        } else {
            editDetailView.sceneDateBtn.setTitleColor(editDetailView.sceneDateBtn.backgroundColor, forState: UIControlState.Normal)
            editDetailView.sceneDateBtn.backgroundColor = UIColor.whiteColor()
            signDictionary2["sceneSign"] = "0"
            signDictionary["typeScene"] = "0"
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let editDetailView = self.view as! EditDetailView
        editDetailView.textField.resignFirstResponder()
        
    }
    

}
