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
    @IBAction func uploadButton(sender: AnyObject) {
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

}
