//
//  EditProfileVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/02.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var commentTextView: String = ""
    var nickNameTextField: String = ""
    var imageChangeFlg: Bool = false
    private let mModel = EditProfileVM();

    override func loadView() {
        let nib = UINib(nibName: "EditProfileView", bundle: nil)
        self.view = nib.instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let view = self.view as? EditProfileView
        view!.commentTextView.text = self.commentTextView
        view!.nickNameTextField.text = self.nickNameTextField
        view!.cancelButton.action = #selector(EditProfileVC.cancelButtonTapped(_:))
        view!.saveButton.action = #selector(EditProfileVC.saveButtonTapped(_:))
        view!.changeImageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditProfileVC.changeImage(_:))))
        view!.nailistSwitch.addTarget(self, action: Selector("switchChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
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
    
    func cancelButtonTapped(sender: AnyObject) {
        print("cancel")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func saveButtonTapped(sender: UITapGestureRecognizer) {
        print("save")
        let view = self.view as? EditProfileView
        if (imageChangeFlg) {
//            var dict = anyObject as Dictionary<String, AnyObject>
            let param1 = [
                "nickName" : view!.nickNameTextField.text!,
                "commentTextView" : view!.commentTextView.text,
                "image" : view!.profileImageView
            ] as Dictionary<String, AnyObject>
            mModel.myImageUploadRequest(param1)
            // TODO
            // 非同期だからどうしよう。
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            let carrentUser = NCMBUser.currentUser()
            carrentUser.setObject(view!.nickNameTextField.text, forKey: "nickName")
            carrentUser.setObject(view!.commentTextView.text, forKey: "comment")
            carrentUser.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
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

}
