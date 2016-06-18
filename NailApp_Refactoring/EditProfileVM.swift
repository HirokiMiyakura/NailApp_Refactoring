//
//  EditProfileVM.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/04.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
//import NCMB

class EditProfileVM: NSObject {

     dynamic var prefectureArray: NSArray = []
    dynamic var uploadDoneFlg = false
     var cityArray: NSArray = []
    var selectedPrefecture: String!
    var selectedCity: String!
    dynamic var salonInfo: NSArray = []
    dynamic var aiueoaiueo: NSArray = []
//    dynamic var aiueoaiueo: NCMBObject!
    dynamic var hoge: String!
//    dynamic var salonInfo = NSDate()
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
        let myUrl = NSURL(string:urlUploadProfileImagesPhp)
        //        let myUrl = NSURL(string:"http://dsh4k2h4k2.esy.es/uploadTest4.php")
        let request = NSMutableURLRequest(URL:myUrl!)
        request.HTTPMethod = "POST"
        
        // ログイン中のユーザーの取得
        let carrentUser = NCMBUser.currentUser()
        let userName = carrentUser.userName
//        let time:Int = Int(NSDate().timeIntervalSince1970)
        print(time)
        //下記のパラメータはあくまでもPOSTの例
        let param = [
            "userName" : userName!,
            "fileName" : param1["time"] as! String
        ]
        print("time2")
        print(param["fileName"])
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
//                self.dismissViewControllerAnimated(true, completion: nil)
                self.registerSalonInfomation(param1)
//                self.uploadDoneFlg = true
            });
        }
        task.resume()
        
//        registerSalonInfomation(param1)
        
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
                print("value")
                print(value)
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
    
    
    func getAPIforPrefecture() {
        
        let URL = NSURL(string: "http://express.heartrails.com/api/json?method=getPrefectures")
        let req = NSURLRequest(URL: URL!)
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration, delegate:nil, delegateQueue:NSOperationQueue.mainQueue())
        
        let task = session.dataTaskWithRequest(req, completionHandler: {
            (data, response, error) -> Void in
            do {
                
                let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments ) as! NSDictionary
                //Return the value assciated with key "response
                let res:NSDictionary = json.objectForKey("response") as! NSDictionary
                
                //Return the value assciated with "prefecture" and convert NSDictionary to NSArray
                let pref:NSArray = res.objectForKey("prefecture") as! NSArray
                self.prefectureArray = pref
                
            } catch {
                
                //エラー処理
                
            }
            
        })
        
        task.resume()
        
    }
    func getAPIforCity() {
        
        //URLエンコーディング（文字列エスケープ処理）
        let text: String = "http://geoapi.heartrails.com/api/json?method=getCities&prefecture="
        let prefecture:String! = self.selectedPrefecture.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())
        var URL = NSURL(string: text + prefecture)
        let req: NSMutableURLRequest = NSMutableURLRequest(URL: URL!)
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration, delegate:nil, delegateQueue:NSOperationQueue.mainQueue())
        
        let task = session.dataTaskWithRequest(req, completionHandler: {
            (data, response, error) -> Void in
            do {
                // リクエストを出力
                print("******* resquest = \(req.HTTPBody)")
                // レスポンスを出力
                print("******* response = \(response)")
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("****** response data = \(responseString!)")
                let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments ) as! NSDictionary
                //Return the value assciated with key "response
                let res:NSDictionary = json.objectForKey("response") as! NSDictionary
                
                //Return the value assciated with "prefecture" and convert NSDictionary to NSArray
                let loc:NSArray = res.objectForKey("location") as! NSArray
                
                self.cityArray = loc
//                self.myPickerView2.reloadAllComponents()

                
            } catch {
                
                //エラー処理
                print("エラーやで")
                
            }
            
        })
        
        task.resume()
        
    }
    
    func registerSalonInfomation(param1: Dictionary<String, AnyObject>) {
        
        let carrentUser = NCMBUser.currentUser()
        carrentUser.setObject(param1["nickName"], forKey: "nickName")
        carrentUser.setObject(param1["commentTextView"], forKey: "comment")
        
        if param1["time"] != nil {
            let time = param1["time"] as! String
            carrentUser.setObject(urlUploadProfileImagesLocation + time + ".jpg", forKey: "imagePath")
        }
        
        
        
        let salonObject = NCMBObject(className: "salon")
        carrentUser.setObject(param1["nailistFlg"], forKey:"nailistFlg")
        
        if (param1["nailistFlg"] as! Bool) {
            salonObject.setObject(param1["salonName"], forKey:"salonName")
            salonObject.setObject(param1["mailAddress"], forKey:"mailAddress")
            salonObject.setObject(param1["tel"], forKey:"tel")
            salonObject.setObject(param1["locationPrefecture"], forKey:"locationPrefecture")
            salonObject.setObject(param1["locationCity"], forKey:"locationCity")
            salonObject.setObject(param1["salonName"], forKey:"salonName")
            salonObject.setObject(param1["lineId"], forKey:"lineId")
            salonObject.setObject(param1["url"], forKey:"url")
            salonObject.setObject(param1["averageAge"], forKey:"averageAge")
            salonObject.setObject(param1["averageCost"], forKey:"averageCost")
            carrentUser.setObject(salonObject, forKey: "salonPointer")
        }
        
        
        
        carrentUser.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
            //            self.dismissViewControllerAnimated(true, completion: nil)
            print("サロン登録完了")
            self.uploadDoneFlg = true
        })
        
    }
    
    func getSalonInfo() {
        
        
        let carrentUser = NCMBUser.currentUser()
        if carrentUser.objectForKey("salonPointer") == nil {
            return
        }
//        let a = carrentUser.objectForKey("salonPointer")
//        let salonObjectId = a.objectForKey("objectId")
//        let salonObjectId = a.objectId
        let salonObjectId = carrentUser.objectForKey("salonPointer").objectId
//        self.aiueoaiueo = carrentUser.objectForKey("salonPointer") as! NCMBObject
        let salonQuery = NCMBQuery(className: "salon")
        salonQuery.whereKey("objectId", equalTo: salonObjectId)
        
        salonQuery.findObjectsInBackgroundWithBlock({(objects, error) in
            
            if error == nil {
                
                if objects.count > 0 {
                    
                    self.aiueoaiueo = objects
                    
                
                }
                
            } else {
                print("エラー")
                print(error.localizedDescription)
            }
        })

    }
    
    func testButton(huga: String) {
        
        self.hoge = huga
        
    }

}
