//
//  DetailUserProfileVM.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/22.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
//import NCMB
class DetailUserProfileVM: NSObject {
    
    dynamic var profileInfo = []
    dynamic var prefectureArray: NSArray = []
    dynamic var uploadDoneFlg = false
    var cityArray: NSArray = []
    var selectedPrefecture: String!
    var selectedCity: String!
    dynamic var salonInfo: NSArray = []
    dynamic var aiueoaiueo: NSArray = []
    dynamic var hoge: String!
    
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
    
    func getSalonInfo() {
        
        
//        let userQuery = NCMBUser.query()
//        userQuery.whereKey("userName", equalTo: userName)
        
        let carrentUser = NCMBUser.currentUser()
        if carrentUser.objectForKey("salonPointer") == nil {
            return
        }
//        let a =  carrentUser.objectForKey("salonPointer")
//        let salonObjectId = a.objectForKey("objectId") as! String
        let salonObjectId = carrentUser.objectForKey("salonPointer").objectId
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

    func loadProfileInfo(userName: String) {
        //        var dic: Dictionary<String, AnyObject>?
        let userQuery = NCMBUser.query()
        userQuery.whereKey("userName", equalTo: userName)
        userQuery.findObjectsInBackgroundWithBlock({(items, error) in
            
            if error == nil {
                print("登録件数：\(items.count)")
                // items.countは1か0しかない。
                if items.count > 0 {
                    
                    self.profileInfo = items
                    
                } else {
                    
                    
                }
            }
            
            
        })
        //        return dic!
    }
    

}
