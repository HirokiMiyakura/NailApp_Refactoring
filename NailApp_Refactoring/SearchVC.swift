//
//  SearchVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/07/13.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    var colorPinkBtnFlg: Bool = false
    var colorBlueBtn: Bool = false
    var lengthLongBtn: Bool = false
    var lengthShortBtn: Bool = false
    var sceneOfficeBtn: Bool = false
    var sceneDateBtn: Bool = false
    var colorSign: String = "0"
    var lengthSign: String = "0"
    var sceneSign: String = "0"
    var signArray: [String] = []
    var signDictionary = [:] as Dictionary<String, String>
    
    @IBAction func sceneDateBtn(sender: UIButton) {
        sceneDateBtn = !sceneDateBtn
        if (sceneDateBtn) {
            sender.backgroundColor = sender.currentTitleColor
            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            sceneSign = "2"
            signDictionary["typeScene"] = sceneSign
            
        } else {
            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
            sender.backgroundColor = UIColor.whiteColor()
            sceneSign = "0"
            signDictionary["typeScene"] = sceneSign
        }
    }
    @IBAction func sceneOfficeBtn(sender: UIButton) {
        sceneOfficeBtn = !sceneOfficeBtn
        if (sceneOfficeBtn) {
            sender.backgroundColor = sender.currentTitleColor
            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            sceneSign = "1"
            signDictionary["typeScene"] = sceneSign
            
        } else {
            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
            sender.backgroundColor = UIColor.whiteColor()
            sceneSign = "0"
            signDictionary["typeScene"] = sceneSign
        }
    }
    @IBAction func lengthShortBtn(sender: UIButton) {
        lengthShortBtn = !lengthShortBtn
        if (lengthShortBtn) {
            sender.backgroundColor = sender.currentTitleColor
            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            lengthSign = "2"
            signDictionary["typeLength"] = lengthSign
            
        } else {
            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
            sender.backgroundColor = UIColor.whiteColor()
            lengthSign = "0"
            signDictionary["typeLength"] = lengthSign
        }
    }
    @IBAction func lengthLongBtn(sender: UIButton) {
        lengthLongBtn = !lengthLongBtn
        if (lengthLongBtn) {
            sender.backgroundColor = sender.currentTitleColor
            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            lengthSign = "1"
            signDictionary["typeLength"] = lengthSign
            
        } else {
            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
            sender.backgroundColor = UIColor.whiteColor()
            lengthSign = "0"
            signDictionary["typeLength"] = lengthSign
        }
    }
    @IBAction func colorBlueBtn(sender: UIButton) {
        colorBlueBtn = !colorBlueBtn
        if (colorBlueBtn) {
            sender.backgroundColor = sender.currentTitleColor
            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            colorSign = "2"
            signDictionary["typeColor"] = colorSign
            
        } else {
            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
            sender.backgroundColor = UIColor.whiteColor()
            colorSign = "0"
            signDictionary["typeColor"] = colorSign
        }
    }
    
    @IBAction func colorPinkBtn(sender: UIButton) {
        colorPinkBtnFlg = !colorPinkBtnFlg
        if (colorPinkBtnFlg) {
            sender.backgroundColor = sender.currentTitleColor
            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            colorSign = "1"
            signDictionary["typeColor"] = colorSign
            
        } else {
            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
            sender.backgroundColor = UIColor.whiteColor()
            colorSign = "0"
            signDictionary["typeColor"] = colorSign
        }
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        signDictionary["typeScene"] = "0"
        signDictionary["typeLength"] = "0"
        signDictionary["typeColor"] = "0"
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 初期化
        gblParam = [:]
//        for (colName,sign) in signDictionary {
//            if (sign == "0") {
//                gblParam[colName] = sign
//            }
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
//        let cell = sender as! UICollectionViewCell
//        let indexPath = self.collectionView!.indexPathForCell(cell)
        let CollectionSearchVC = segue.destinationViewController as! CollectionVC
        CollectionSearchVC.tabKind = "8"
//        signArray = [colorSign,lengthSign,sceneSign]
        for (colName,sign) in signDictionary {
            if (sign != "0") {
                gblParam[colName] = sign
            }
        }
//        gblParam["typeColor"] = colorSign
//        gblParam["typeLength"] = lengthSign
//        gblParam["typeScene"] = sceneSign
//        controller.indexPath = indexPath!
//        controller.imageInfo = mModel!.imageInfo
//        controller.favDic = mModel!.favDic
        
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        
        for (colName,sign) in signDictionary {
            if (sign != "0") {
                return true
            }
        }
        
        // 未ログインの場合はポップアップを出して処理終了
        let alertController = UIAlertController(title: "Sorry!", message: "なんか条件指定して", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        print("なんか条件指定しろ")
        
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
