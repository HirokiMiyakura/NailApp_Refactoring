//
//  EditProfileVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/02.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIToolbarDelegate {
    var commentTextView: String = ""
    var nickNameTextField: String = ""
    var imageChangeFlg: Bool = false
    private var mModel: EditProfileVM!

    var imageView: UIImageView!
    
    var prefecturePicker: UIPickerView!
    var cityPicker: UIPickerView!
    var prefectureToolBar: UIToolbar!
    var cityToolBar: UIToolbar!
    override func loadView() {
        let nib = UINib(nibName: "EditProfileView", bundle: nil)
        self.view = nib.instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mModel = EditProfileVM();
        mModel.getAPIforPrefecture()
        mModel.getSalonInfo()
        
        
        // Do any additional setup after loading the view.
        
        let view = self.view as? EditProfileView
        view!.commentTextView.text = self.commentTextView
        view!.nickNameTextField.text = self.nickNameTextField
        view!.profileImageView.image = self.imageView.image
        view!.cancelButton.action = #selector(EditProfileVC.cancelButtonTapped(_:))
        view!.saveButton.action = #selector(EditProfileVC.saveButtonTapped(_:))
        view!.changeImageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditProfileVC.changeImage(_:))))
        view!.nailistSwitch.addTarget(self, action: Selector("switchChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        view!.testButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditProfileVC.testAction(_:))))
        
        
        //都道府県用PickerView作成
        prefecturePicker = UIPickerView()
        prefecturePicker.showsSelectionIndicator = true
        prefecturePicker.delegate = self
        prefecturePicker.tag = 1
        
        //市区町村用PickerView作成
        cityPicker = UIPickerView()
        cityPicker.showsSelectionIndicator = true
        cityPicker.delegate = self
        cityPicker.tag = 2
        
        //都道府県用ToolBar作成。ニョキ担当
        prefectureToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        prefectureToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        prefectureToolBar.backgroundColor = UIColor.blackColor()
        prefectureToolBar.barStyle = UIBarStyle.Black
        prefectureToolBar.tintColor = UIColor.whiteColor()
        
        //市区町村用ToolBar作成。ニョキ担当
        cityToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        cityToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        cityToolBar.backgroundColor = UIColor.blackColor()
        cityToolBar.barStyle = UIBarStyle.Black
        cityToolBar.tintColor = UIColor.whiteColor()
        
        //都道府県用ToolBarを閉じるボタンを追加
        let myToolBarButton = UIBarButtonItem(title: "Close", style: .Bordered, target: self, action: #selector(EditProfileVC.onClick(_:)))
        myToolBarButton.tag = 1
        prefectureToolBar.items = [myToolBarButton]
        
        //市区町村用ToolBarを閉じるボタンを追加
        let myToolBarButton2 = UIBarButtonItem(title: "Close", style: .Bordered, target: self, action: #selector(EditProfileVC.onClick2(_:)))
        myToolBarButton2.tag = 1
        cityToolBar.items = [myToolBarButton2]
        
        view!.prefectureTextField.inputView = prefecturePicker
        view!.prefectureTextField.inputAccessoryView = prefectureToolBar
        
        view!.cityTextField.inputView = cityPicker
        view!.cityTextField.inputAccessoryView = cityToolBar
        
        
//        let innerQuery = NCMBUser.query()
//        
//        let user = NCMBUser.currentUser()
//        print(user.objectForKey("salonPointer"))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        mModel.addObserver(self, forKeyPath: "aiueoaiueo", options: [.New, .Old], context: nil)
        mModel.addObserver(self, forKeyPath: "uploadDoneFlg", options: [.New, .Old], context: nil)
//        mModel.addObserver(self, forKeyPath: "prefectureArray", options: [.New, .Old], context: nil)
        
        //        myClass.value = "NewValue"
    }
    
    override func viewWillDisappear(animated: Bool) {
        mModel.removeObserver(self, forKeyPath: "aiueoaiueo")
        mModel.removeObserver(self, forKeyPath: "uploadDoneFlg")
//        mModel.removeObserver(self, forKeyPath: "prefectureArray")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        NSLog("Called")
        
        if (keyPath == "aiueoaiueo") {
            let view = self.view as! EditProfileView
            
//            view.salonNameTextField.text = mModel.aiueoaiueo.objectForKey("salonName") as! String
            view.salonNameTextField.text = mModel.aiueoaiueo[0].objectForKey("salonName") as? String
            view.mailTextField.text = mModel.aiueoaiueo[0].objectForKey("mailAddress") as? String
            view.telTextField.text = mModel.aiueoaiueo[0].objectForKey("tel") as? String
            view.prefectureTextField.text = mModel.aiueoaiueo[0].objectForKey("locationPrefecture") as? String
            view.cityTextField.text = mModel.aiueoaiueo[0].objectForKey("locationCity") as? String
            view.lineIdTextField.text = mModel.aiueoaiueo[0].objectForKey("lineId") as? String
            view.urlTextField.text = mModel.aiueoaiueo[0].objectForKey("url") as? String
            view.averageAgeTextField.text = mModel.aiueoaiueo[0].objectForKey("averageAge") as? String
            view.averageCostTextField.text = mModel.aiueoaiueo[0].objectForKey("averageCost") as? String
            
            
            //        view.nailistSwitch.on = (mModel.aiueoaiueo[0].objectForKey("nailistFlg") as? Bool)!
            
        } else if (keyPath == "uploadDoneFlg") {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    func cancelButtonTapped(sender: AnyObject) {
        print("cancel")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func testAction(sender: UITapGestureRecognizer) {
//        let view = self.view as! EditProfileView
        mModel.testButton("aiu")
    }
    func saveButtonTapped(sender: UITapGestureRecognizer) {
        print("save")
        let view = self.view as? EditProfileView
        let time:Int = Int(NSDate().timeIntervalSince1970)
        var param1 = [
            "nickName" : view!.nickNameTextField.text!,
            "commentTextView" : view!.commentTextView.text,
            "image" : view!.profileImageView,
            "mailAddress" : view!.mailTextField.text!,
            "tel" : view!.telTextField.text!,
            "salonName" : view!.salonNameTextField.text!,
            "locationPrefecture" : view!.prefectureTextField.text!,
            "locationCity" : view!.cityTextField.text!,
            "lineId" : view!.lineIdTextField.text!,
            "url" : view!.urlTextField.text!,
            "averageAge" : view!.averageAgeTextField.text!,
            "averageCost" : view!.averageCostTextField.text!,
            "nailistFlg" : view!.nailistSwitch.on,
//            "time" : String(time)
            ] as Dictionary<String, AnyObject>
        
        if (imageChangeFlg) {
//            var dict = anyObject as Dictionary<String, AnyObject>
            param1["time"] = String(time)
            
            mModel.myImageUploadRequest(param1)
            // TODO
            // 非同期だからどうしよう。
//            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
//            let carrentUser = NCMBUser.currentUser()
//            carrentUser.setObject(view!.nickNameTextField.text, forKey: "nickName")
//            carrentUser.setObject(view!.commentTextView.text, forKey: "comment")
//            carrentUser.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
//                self.dismissViewControllerAnimated(true, completion: nil)
//            })
            mModel.registerSalonInfomation(param1)
//            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    func changeImage(sender: UITapGestureRecognizer) {
        self.pickImageFromLibrary()
    }
    
    // 写真を撮ってそれを選択
    func pickImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    // ライブラリから写真を選択する
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.allowsEditing = true
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    // 写真を選択した時に呼ばれる
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if info[UIImagePickerControllerEditedImage] != nil {
            let view = self.view as? EditProfileView
            var image = info[UIImagePickerControllerEditedImage] as! UIImage
            image = mModel.resizeImage(image,width: 200,height: 200)
            view!.profileImageView.image = image
            self.imageChangeFlg = true
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func switchChanged(sender: UISwitch) {
        print("switched")
        let view = self.view as? EditProfileView
        // スイッチのon/off
        if sender.on {
            view!.viewForNailist.hidden = false
        } else {
            view!.viewForNailist.hidden = true
        }
        
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if (pickerView.tag == 1) {
            return mModel.prefectureArray.count
        } else if (pickerView.tag == 2) {
            return mModel.cityArray.count
        } else {
            return 0
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        if (pickerView.tag == 1) {
            return mModel.prefectureArray[row] as! String
        } else if (pickerView.tag == 2) {
            return mModel.cityArray[row].objectForKey("city") as! String
        } else {
            return "何らかのエラーにより取得できてません。"
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let view = self.view as? EditProfileView
        if (pickerView.tag == 1) {
            view!.prefectureTextField.text = mModel.prefectureArray[row] as! String
            mModel.selectedPrefecture = mModel.prefectureArray[row] as! String
            view!.cityTextField.text = ""
            mModel.getAPIforCity()
        } else if (pickerView.tag == 2) {
            view!.cityTextField.text = mModel.cityArray[row].objectForKey("city") as! String
        }
        //        getCities()
    }
    
    //閉じる
    func onClick(sender: UIBarButtonItem) {
        let view = self.view as? EditProfileView
        view!.prefectureTextField.resignFirstResponder()
    }
    //閉じる
    func onClick2(sender: UIBarButtonItem) {
        let view = self.view as? EditProfileView
        view!.cityTextField.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let view = self.view as? EditProfileView
        view!.prefectureTextField.resignFirstResponder()
        view!.cityTextField.resignFirstResponder()
        view!.nickNameTextField.resignFirstResponder()
        view!.commentTextView.resignFirstResponder()
        view!.averageAgeTextField.resignFirstResponder()
        view!.averageCostTextField.resignFirstResponder()
        view!.urlTextField.resignFirstResponder()
        view!.lineIdTextField.resignFirstResponder()
        view!.telTextField.resignFirstResponder()
        view!.mailTextField.resignFirstResponder()
        view!.salonNameTextField.resignFirstResponder()
        
        
    }

}
