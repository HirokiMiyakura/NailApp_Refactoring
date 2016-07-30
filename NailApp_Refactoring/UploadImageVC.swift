//
//  UploadImageVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/04.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class UploadImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

//    @IBOutlet weak var placeHolderLabel: UILabel!
    var colorOutletDictionary = [:] as Dictionary<Int, UIButton>
    var lengthOutletDictionary = [:] as Dictionary<Int, UIButton>
    var sceneOutletDictionary = [:] as Dictionary<Int, UIButton>
    
    /* 色 */
    /* 排他 */
    /*
     ピンク："1"
     ブルー："2"
     */
    // アウトレット接続
    @IBOutlet weak var colorBlueBtnOutlet: CustomButton!
    @IBOutlet weak var colorPinkBtnOutlet: CustomButton!
    // 押下済みかどうか判定するための配列
    var colorTappedArray:NSMutableArray = []
    // これはもはや不要？
    var colorPinkBtnFlg: Bool = false
    var colorBlueBtnFlg: Bool = false
    //  カラーサイン
    var colorSign: String = "0"
    
    /* 長さ */
    /*
     ロング："1"
     ショート："2"
     */
    // アウトレット接続
    @IBOutlet weak var lengthShortOutlet: CustomButton!
    @IBOutlet weak var lengthLongOutlet: CustomButton!
    // 押下済みかどうか判定するための配列
    var lengthTappedArray:NSMutableArray = []
    // これはもはや不要？
    var lengthLongBtnFlg: Bool = false
    var lengthShortBtnFlg: Bool = false
    //  レングスサイン
    var lengthSign: String = "0"
    
    /* シーン */
    /*
     オフィス："1"
     デート："2"
     */
    // アウトレット接続
    @IBOutlet weak var sceneDateOutlet: CustomButton!
    @IBOutlet weak var sceneOfficeOutlet: CustomButton!
    // 押下済みかどうか判定するための配列
    var sceneTappedArray:NSMutableArray = []
    var sceneOfficeBtnFlg: Bool = false
    var sceneDateBtnFlg: Bool = false
    // シーンサイン
    var sceneSign: String = "0"
    
    
    @IBAction func colorTapped(sender: UIButton) {
        
        // 押されたボタンが押下済みかどうか
        var wasTapped: Bool = false
        if colorTappedArray.containsObject(sender.tag) {
            wasTapped = true
        }
        // フラグが立っていたボタンの色を反転
        for (flg,Outlet) in colorOutletDictionary {
            if (colorTappedArray.containsObject(flg)) {
                let tmpCurrentTitleColor:UIColor = Outlet.currentTitleColor
                let tmpCurrentBackGroundColor:UIColor = Outlet.backgroundColor!
                Outlet.backgroundColor = tmpCurrentTitleColor
                Outlet.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
            }
        }
        
        if (!wasTapped) {
            // 今押したボタンが押されてない状態だったら(押してない状態→押した状態の場合)
            // まず配列を初期化
            colorTappedArray = []
            // そこに今押したボタンのtagを追加
            colorTappedArray.addObject(sender.tag)
            // 押されたボタンの色を反転
            let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
            let tmpCurrentBackGroundColor:UIColor = sender.backgroundColor!
            sender.backgroundColor = tmpCurrentTitleColor
            sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
        } else {
            // 押されてたら（押してる状態→押してない状態の場合）
            // 初期化
            colorTappedArray = []
        }
        
        if colorTappedArray == [] {
            colorSign = "0"
        } else {
            colorSign = String(colorTappedArray[0])
        }

    }
    @IBAction func lengthTapped(sender: UIButton) {
        // 押されたボタンが押下済みかどうか
        var wasTapped: Bool = false
        if lengthTappedArray.containsObject(sender.tag) {
            wasTapped = true
        }
        // フラグが立っていたボタンの色を反転
        for (flg,Outlet) in lengthOutletDictionary {
            if (lengthTappedArray.containsObject(flg)) {
                let tmpCurrentTitleColor:UIColor = Outlet.currentTitleColor
                let tmpCurrentBackGroundColor:UIColor = Outlet.backgroundColor!
                Outlet.backgroundColor = tmpCurrentTitleColor
                Outlet.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
            }
        }
        
        if (!wasTapped) {
            // 今押したボタンが押されてない状態だったら(押してない状態→押した状態の場合)
            // まず配列を初期化
            lengthTappedArray = []
            // そこに今押したボタンのtagを追加
            lengthTappedArray.addObject(sender.tag)
            // 押されたボタンの色を反転
            let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
            let tmpCurrentBackGroundColor:UIColor = sender.backgroundColor!
            sender.backgroundColor = tmpCurrentTitleColor
            sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
        } else {
            // 押されてたら（押してる状態→押してない状態の場合）
            // 初期化
            lengthTappedArray = []
        }
        
        if lengthTappedArray == [] {
            lengthSign = "0"
        } else {
            lengthSign = String(lengthTappedArray[0])
        }
    }
    
    @IBAction func sceneTapped(sender: UIButton) {
    }
    @IBAction func sceneDateBtn(sender: UIButton) {
//        sceneDateBtnFlg = !sceneDateBtnFlg
//        if (sceneDateBtnFlg) {
//            sender.backgroundColor = sender.currentTitleColor
//            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            sceneSign = "2"
//            
//        } else {
//            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
//            sender.backgroundColor = UIColor.whiteColor()
//            sceneSign = "0"
//        }
    }
    @IBAction func sceneOfficeBtn(sender: UIButton) {
//        sceneOfficeBtnFlg = !sceneOfficeBtnFlg
//        if (sceneOfficeBtnFlg) {
//            sender.backgroundColor = sender.currentTitleColor
//            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            sceneSign = "1"
//            
//        } else {
//            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
//            sender.backgroundColor = UIColor.whiteColor()
//            sceneSign = "0"
//        }
    }
    @IBAction func lengthShortBtn(sender: UIButton) {
//        lengthShortBtnFlg = !lengthShortBtnFlg
//        if (lengthShortBtnFlg) {
//            sender.backgroundColor = sender.currentTitleColor
//            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            lengthSign = "2"
//            
//        } else {
//            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
//            sender.backgroundColor = UIColor.whiteColor()
//            lengthSign = "0"
//        }
    }
    @IBAction func lengthLongBtn(sender: UIButton) {
//        lengthLongBtnFlg = !lengthLongBtnFlg
//        if (lengthLongBtnFlg) {
//            sender.backgroundColor = sender.currentTitleColor
//            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            lengthSign = "1"
//            
//        } else {
//            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
//            sender.backgroundColor = UIColor.whiteColor()
//            lengthSign = "0"
//        }
    }
    @IBAction func colorBlueBtn(sender: UIButton) {
//        colorBlueBtnFlg = !colorBlueBtnFlg
//        if (colorBlueBtnFlg) {
//            sender.backgroundColor = sender.currentTitleColor
//            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            colorSign = "2"
//            
//        } else {
//            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
//            sender.backgroundColor = UIColor.whiteColor()
//            colorSign = "0"
//        }
    }
    
    @IBAction func colorPinkBtn(sender: UIButton) {
//        colorPinkBtnFlg = !colorPinkBtnFlg
//        if (colorPinkBtnFlg) {
//            sender.backgroundColor = sender.currentTitleColor
//            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            colorSign = "1"
//            
//        } else {
//            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
//            sender.backgroundColor = UIColor.whiteColor()
//            colorSign = "0"
//        }
        
    }
    private let mModel = UploadImageVM();
    var imageChoseFlg = false
    var imageView: UIImage?
    @IBAction func uploadButton(sender: AnyObject) {
        // 画像を選択していなかったらアラートをだすべし。
//        if (!imageChoseFlg) {
//            let alertController = UIAlertController(title: "Sorry!", message: "写真を選択してください！", preferredStyle: .Alert)
//            
//            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//            alertController.addAction(defaultAction)
//            
//            self.presentViewController(alertController, animated: true, completion: nil)
//            return
//            
//        }
        
        
        LoadingProxy.set(self); //表示する親をセット
        LoadingProxy.on();//ローディング表示。非表示にする場合はoff
        let param1 = [
//            "nickName" : view!.nickNameTextField.text!,
            "commentTextView" : self.uploadTextView.text,
            "image" : self.uploadImageView,
            "typeLength" : lengthSign,
            "typeColor" : colorSign,
            "typeScene" : sceneSign
            ] as Dictionary<String, AnyObject>
        mModel.myImageUploadRequest(param1)
    }
    @IBAction func chooseImageButton(sender: AnyObject) {
        self.pickImageFromLibrary()
    }
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var uploadTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        colorOutletDictionary = [
            1: colorPinkBtnOutlet,
            2: colorBlueBtnOutlet,
            ] //as Dictionary<String, AnyObject>

        lengthOutletDictionary = [
            1: lengthLongOutlet,
            2: lengthShortOutlet,
        ]
        sceneOutletDictionary = [
            1: sceneOfficeOutlet,
            2: sceneDateOutlet,
        ]
        self.uploadImageView.image = imageView
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        
        print("viewWillApper")
        //        detailVM!.addObserver(self, forKeyPath: "imageCollectionObject", options: [.New, .Old], context: nil)
        mModel.addObserver(self, forKeyPath: "uploadDoneFlg", options: [.New, .Old], context: nil)
        
        //        super.viewWillAppear(animated)
        //        let detailView = self.view as! DetailView
        //            detailView.userInteractionEnabled = true
        //        detailView.scrollView.translatesAutoresizingMaskIntoConstraints = false
        //        detailView.scrollView.contentSize = CGSizeMake(screenWidth, screenWidth*3)  //横幅は画面に合わせ、縦幅は1200とする。
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisapper")
        //        detailVM!.removeObserver(self, forKeyPath: "imageCollectionObject")
        mModel.removeObserver(self, forKeyPath: "uploadDoneFlg")
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        NSLog("Called")
        
        if (keyPath == "uploadDoneFlg") {
            LoadingProxy.off();//ローディング表示。非表示にする場合はoff
            
            self.uploadImageView.image = nil
            self.uploadTextView.text = ""
            self.imageChoseFlg = false
//            self.navigationController?.popViewControllerAnimated(true)
            
            
            let alertController = UIAlertController(title: "Thank You!", message: "アップロードしました！", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: {
                (action:UIAlertAction!) -> Void in
                self.closeMyView()
            })
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    // 写真を撮ってそれを選択
    func pickImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.Camera
            controller.allowsEditing = true
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    // ライブラリから写真を選択する
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            controller.allowsEditing = true
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    // 写真を選択した時に呼ばれる
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if info[UIImagePickerControllerEditedImage] != nil {
            var image = info[UIImagePickerControllerEditedImage] as! UIImage
            image = mModel.resizeImage(image,width: 300,height: 300)
            print(image)
            self.uploadImageView.image = image
            self.imageChoseFlg = true
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        uploadTextView.resignFirstResponder()
        
    }
    
    func closeMyView() {
        //        self.navigationController?.popViewControllerAnimated(true)
//        self.navigationController?.popViewControllerAnimated(true)
//        navigationController?.popToRootViewControllerAnimated(true)
        // ① 0番目のタブのViewControllerを取得する
        let tabVC0 = self.tabBarController!.viewControllers![0];
        // ② 0番目のタブを選択済みにする
        self.tabBarController!.selectedViewController = tabVC0;
        // ③ UINavigationControllerに追加済みのViewを一旦取り除く
        self.navigationController?.popViewControllerAnimated(true)
        //        tabVC0.popToRootViewControllerAnimated = false
        //        [vc popToRootViewControllerAnimated:NO];
        // ④ SecondViewの画面遷移処理を呼び出す
        //        tabVC0.viewControllers
        //        [vc.viewControllers[0] performSegueWithIdentifier:@"ThirdViewを呼び出す" sender:nil];
        
    }
    
    //textviewがフォーカスされたら、Labelを非表示
//    func textViewShouldBeginEditing(textView: UITextView) -> Bool
//    {
//        placeHolderLabel.hidden = true
//        return true
//    }
    
    //textviewからフォーカスが外れて、TextViewが空だったらLabelを再び表示
//    func textViewDidEndEditing(textView: UITextView) {
//        
//        if(textView.text.isEmpty){
//            place.hidden = false
//        }
//    }

}
