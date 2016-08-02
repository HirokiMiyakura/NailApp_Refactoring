//
//  cameraHomeTabVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/07/12.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class cameraHomeTabVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imageView: UIImage?
    @IBAction func fromCameraRollBtn(sender: AnyObject) {
        self.pickImageFromLibrary()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
//        if info[UIImagePickerControllerEditedImage] != nil {
//            var image = info[UIImagePickerControllerEditedImage] as! UIImage
//            image = mModel.resizeImage(image,width: 300,height: 300)
//            print(image)
//            self.uploadImageView.image = image
//            self.imageChoseFlg = true
//        }
        
        let uploadImageVC = self.storyboard!.instantiateViewControllerWithIdentifier( "uploadImageVC" ) as! UploadImageVC
        uploadImageVC.imageView = info[UIImagePickerControllerEditedImage] as? UIImage
        imageView = info[UIImagePickerControllerEditedImage] as? UIImage
        self.navigationController?.pushViewController(uploadImageVC, animated: true)
        picker.dismissViewControllerAnimated(true, completion: nil)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let controller = segue.destinationViewController as! UploadImageVC
        //        controller.indexPath = indexPath!
        //        controller.imageInfo = mModel!.imageInfo
        controller.uploadImageView.image = imageView
        
        
        
    }

}
