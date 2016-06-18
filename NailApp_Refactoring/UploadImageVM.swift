//
//  UploadImageVM.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/04.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
//import NCMB
class UploadImageVM: NSObject {
    
    func resizeImage(image: UIImage, width: Int, height: Int) -> UIImage {
        
        let size: CGSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage
    }
    
    //画像のアップロード処理
    func myImageUploadRequest(param1: Dictionary<String, AnyObject>) {
        //myUrlには自分で用意したphpファイルのアドレスを入れる
        //        let myUrl = NSURL(string:"http://test.localhost/NailApp_NoUseNifty/uploadToFileServer.php")
        let myUrl = NSURL(string: urlUploadImagesPhp)
        //        let myUrl = NSURL(string:"http://dsh4k2h4k2.esy.es/uploadTest4.php")
        let request = NSMutableURLRequest(URL:myUrl!)
        request.HTTPMethod = "POST"
        
        // ログイン中のユーザーの取得
        let carrentUser = NCMBUser.currentUser()
        let userName = carrentUser.userName
        print(userName!)
        let time:Int = Int(NSDate().timeIntervalSince1970)
        print(time)
        //下記のパラメータはあくまでもPOSTの例
        let param = [
            "userName" : userName!,
            "fileName" : String(time)
        ]
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let imageData = UIImageJPEGRepresentation(param1["image"]!.image!!, 1)
        if(imageData==nil) { return; }
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            // リクエストを出力
            print("******* resquest = \(request)")
            // レスポンスを出力
            print("******* response = \(response)")
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("****** response data = \(responseString!)")
            dispatch_async(dispatch_get_main_queue(),{
                //アップロード完了
                // これかかないとアップロード後画面が固まる。
                //                self.removeFromParentViewController()
                //                self.view.removeFromSuperview()
            });
        }
        task.resume()
        
        // niftyにもあげないと
        // imageコレクションも更新
        var saveError: NSError? = nil
        let objImage: NCMBObject = NCMBObject(className: "image")
        objImage.setObject(userName!, forKey: "userName")
        //        objImage.setObject("http://test.localhost/NailApp_NoUseNifty/images/" + String(time) + ".jpg", forKey: "imagePath")
        objImage.setObject(urlUploadImagesLocation + String(time) + ".jpg", forKey: "imagePath")
        objImage.setObject(param1["commentTextView"]!, forKey: "comment")
        objImage.setObject(0, forKey: "kawaiine")
        //        objImage.save(&saveError)
        objImage.saveInBackgroundWithBlock { (error: NSError?) -> Void in
            if let e = error {
                // 端末情報の登録が失敗した場合の処理
                print(e.description)
                if (e.code == 409001){
                    // 失敗した原因がdeviceTokenの重複だった場合
                    //                    self.updateExistInstallation(installation)
                } else {
                    // deviceTokenの重複以外のエラーが返ってきた場合
                }
            }
            //            self.removeFromParentViewController()
            //            self.view.removeFromSuperview()
        }
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        var body = NSMutableData()
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        let filename = "image(1).jpg"
        let mimetype = "image/jpg"
        body.appendString("--\(boundary)\r\n")
        // filePathKeyという識別しに対応するのがfilenameという変数
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\r\n")
        return body
    }


}
