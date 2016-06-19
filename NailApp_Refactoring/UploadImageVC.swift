//
//  UploadImageVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/04.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class UploadImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    private let mModel = UploadImageVM();
    var imageChoseFlg = false
    @IBAction func uploadButton(sender: AnyObject) {
        // 画像を選択していなかったらアラートをだすべし。
        if (!imageChoseFlg) {
            let alertController = UIAlertController(title: "Sorry!", message: "写真を選択してください！", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            return
            
        }
        
        
        LoadingProxy.set(self); //表示する親をセット
        LoadingProxy.on();//ローディング表示。非表示にする場合はoff
        let param1 = [
//            "nickName" : view!.nickNameTextField.text!,
            "commentTextView" : self.uploadTextView.text,
            "image" : self.uploadImageView
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
        // ① 0番目のタブのViewControllerを取得する
        let tabVC0 = self.tabBarController!.viewControllers![0];
        // ② 0番目のタブを選択済みにする
        self.tabBarController!.selectedViewController = tabVC0;
        // ③ UINavigationControllerに追加済みのViewを一旦取り除く
//        self.navigationController?.popViewControllerAnimated(true)
        //        tabVC0.popToRootViewControllerAnimated = false
        //        [vc popToRootViewControllerAnimated:NO];
        // ④ SecondViewの画面遷移処理を呼び出す
        //        tabVC0.viewControllers
        //        [vc.viewControllers[0] performSegueWithIdentifier:@"ThirdViewを呼び出す" sender:nil];
        
    }

}
