//
//  SearchVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/07/13.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
//    var colorPinkBtnFlg: Bool = false
//    var colorBlueBtn: Bool = false
//    var lengthLongBtn: Bool = false
//    var lengthShortBtn: Bool = false
//    var sceneOfficeBtn: Bool = false
//    var sceneDateBtn: Bool = false
//    var colorSign: String = "0"
//    var lengthSign: String = "0"
//    var sceneSign: String = "0"
//    var signArray: [String] = []
    var signDictionary = [:] as Dictionary<String, NSMutableArray>
    
    var colorOutletDictionary = [:] as Dictionary<Int, UIButton>
    var lengthOutletDictionary = [:] as Dictionary<Int, UIButton>
    var sceneOutletDictionary = [:] as Dictionary<Int, UIButton>
    var designOutletDictionary = [:] as Dictionary<Int, UIButton>
    var tasteOutletDictionary = [:] as Dictionary<Int, UIButton>
    var genreOutletDictionary = [:] as Dictionary<Int, UIButton>
    
    /* デザイン */
    /*
     フレンチ："1"
     アート："2"
     グラデーション："3"
     柄："4"
     ワンカラー："5"
     フット："6"
     */
    // アウトレット接続
    @IBOutlet weak var designFrenchOutlet: CustomButton!
    @IBOutlet weak var designArtOutlet: CustomButton!
    @IBOutlet weak var designGradationOutlet: CustomButton!
    @IBOutlet weak var designGaraOutlet: CustomButton!
    @IBOutlet weak var designOneColorOutlet: CustomButton!
    @IBOutlet weak var designFootOutlet: CustomButton!
    
    // 押下済みかどうか判定するための配列
    var designTappedArray:NSMutableArray = []
    //    var sceneOfficeBtnFlg: Bool = false
    //    var sceneDateBtnFlg: Bool = false
    // デザインサイン
    var designSign: String = "0"
    
    
    /* 色 */
    /* 排他 */
    /*
     ピンク："1"
     ホワイト："2"
     ブルー/グリーン："3"
     ベージュ："4"
     シルバー/ゴールド："5"
     オレンジ/イエロー："6"
     */
    // アウトレット接続
    @IBOutlet weak var colorOrangeBtnOutlet: CustomButton!
    @IBOutlet weak var colorSilverBtnOutlet: CustomButton!
    @IBOutlet weak var colorBejuBtnOutlet: CustomButton!
    @IBOutlet weak var colorBlueBtnOutlet: CustomButton!
    @IBOutlet weak var colorWhitebtnOutlet: CustomButton!
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
     ベリーロング："3"
     */
    // アウトレット接続
    @IBOutlet weak var lengthVeryLongOutlet: CustomButton!
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
     ブライダル："2"
     合コン："3"
     デート："4"
     パーティ："5"
     ゴージャス："6"
     */
    // アウトレット接続
    @IBOutlet weak var sceneSeasonOutlet: CustomButton!
    @IBOutlet weak var scenePartyOutlet: CustomButton!
    @IBOutlet weak var sceneGokonOutlet: CustomButton!
    @IBOutlet weak var sceneBridalOutlet: CustomButton!
    @IBOutlet weak var sceneDateOutlet: CustomButton!
    @IBOutlet weak var sceneOfficeOutlet: CustomButton!
    // 押下済みかどうか判定するための配列
    var sceneTappedArray:NSMutableArray = []
    var sceneOfficeBtnFlg: Bool = false
    var sceneDateBtnFlg: Bool = false
    // シーンサイン
    var sceneSign: String = "0"
    
    /* テイスト */
    /*
     シンプル："1"
     ガーリー："2"
     ゴージャス："3"
     */
    // アウトレット接続
    @IBOutlet weak var tasteSimpleOutlet: CustomButton!
    @IBOutlet weak var tasteGariOutlet: CustomButton!
    @IBOutlet weak var tasteGorgeousOutlet: CustomButton!
    
    // 押下済みかどうか判定するための配列
    var tasteTappedArray:NSMutableArray = []
    //    var tasteOfficeBtnFlg: Bool = false
    //    var sceneDateBtnFlg: Bool = false
    // テイストサイン
    var tasteSign: String = "0"
    
    /* ジャンル */
    /*
     ジェル："1"
     スカルプ："2"
     その他："3"
     */
    // アウトレット接続
    @IBOutlet weak var genreGelOutlet: CustomButton!
    @IBOutlet weak var genreSculpOutlet: CustomButton!
    @IBOutlet weak var genreOtherOutlet: CustomButton!
    
    // 押下済みかどうか判定するための配列
    var genreTappedArray:NSMutableArray = []
    //    var tasteOfficeBtnFlg: Bool = false
    //    var sceneDateBtnFlg: Bool = false
    // ジャンルサイン
    var genreSign: String = "0"
    
    
    @IBAction func designTapped(sender: UIButton) {
        // 押されたボタンが押下済みかどうか
//        var wasTapped: Bool = false
        if designTappedArray.containsObject(sender.tag) {
//            wasTapped = true
            designTappedArray.removeObject(sender.tag)
            
        } else {
            designTappedArray.addObject(sender.tag)
        }
        
        // 押されたボタンの色を反転
        let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
        var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
        if sender.backgroundColor != nil {
            tmpCurrentBackGroundColor = sender.backgroundColor!
        } else {
            
        }
        sender.backgroundColor = tmpCurrentTitleColor
        sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//        // フラグが立っていたボタンの色を反転
//        for (flg,Outlet) in designOutletDictionary {
//            if (designTappedArray.containsObject(flg)) {
//                let tmpCurrentTitleColor:UIColor = Outlet.currentTitleColor
//                var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
//                if Outlet.backgroundColor != nil {
//                    tmpCurrentBackGroundColor = Outlet.backgroundColor!
//                } else {
//                    
//                }
//                Outlet.backgroundColor = tmpCurrentTitleColor
//                Outlet.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//            }
//        }
        
//        if (!wasTapped) {
//            // 今押したボタンが押されてない状態だったら(押してない状態→押した状態の場合)
//            // まず配列を初期化
//            designTappedArray = []
//            // そこに今押したボタンのtagを追加
//            designTappedArray.addObject(sender.tag)
//            // 押されたボタンの色を反転
//            let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
//            var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
//            if sender.backgroundColor != nil {
//                tmpCurrentBackGroundColor = sender.backgroundColor!
//            } else {
//                
//            }
//            sender.backgroundColor = tmpCurrentTitleColor
//            sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//        } else {
//            // 押されてたら（押してる状態→押してない状態の場合）
//            // 初期化
//            designTappedArray = []
//        }
//        
//        if designTappedArray == [] {
//            designSign = "0"
//        } else {
//            designSign = String(designTappedArray[0])
//        }
        
    }
    @IBAction func colorTapped(sender: UIButton) {
        
        if colorTappedArray.containsObject(sender.tag) {
            colorTappedArray.removeObject(sender.tag)
        } else {
            colorTappedArray.addObject(sender.tag)
        }
        
        // 押されたボタンの色を反転
        let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
        var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
        if sender.backgroundColor != nil {
            tmpCurrentBackGroundColor = sender.backgroundColor!
        } else {
            
        }
        sender.backgroundColor = tmpCurrentTitleColor
        sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
        
//        // 押されたボタンが押下済みかどうか
//        var wasTapped: Bool = false
//        if colorTappedArray.containsObject(sender.tag) {
//            wasTapped = true
//        }
//        // フラグが立っていたボタンの色を反転
//        for (flg,Outlet) in colorOutletDictionary {
//            if (colorTappedArray.containsObject(flg)) {
//                let tmpCurrentTitleColor:UIColor = Outlet.currentTitleColor
//                var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
//                if Outlet.backgroundColor != nil {
//                    tmpCurrentBackGroundColor = Outlet.backgroundColor!
//                } else {
//                    
//                }
//                Outlet.backgroundColor = tmpCurrentTitleColor
//                Outlet.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//            }
//        }
//        
//        if (!wasTapped) {
//            // 今押したボタンが押されてない状態だったら(押してない状態→押した状態の場合)
//            // まず配列を初期化
//            colorTappedArray = []
//            // そこに今押したボタンのtagを追加
//            colorTappedArray.addObject(sender.tag)
//            // 押されたボタンの色を反転
//            let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
//            var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
//            if sender.backgroundColor != nil {
//                tmpCurrentBackGroundColor = sender.backgroundColor!
//            } else {
//                
//            }
//            sender.backgroundColor = tmpCurrentTitleColor
//            sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//        } else {
//            // 押されてたら（押してる状態→押してない状態の場合）
//            // 初期化
//            colorTappedArray = []
//        }
//        
//        if colorTappedArray == [] {
//            colorSign = "0"
//        } else {
//            colorSign = String(colorTappedArray[0])
//        }
        
    }
    @IBAction func lengthTapped(sender: UIButton) {
        // 押されたボタンが押下済みかどうか
        if lengthTappedArray.containsObject(sender.tag) {
            //            wasTapped = true
            lengthTappedArray.removeObject(sender.tag)
            
        } else {
            lengthTappedArray.addObject(sender.tag)
        }
        
        // 押されたボタンの色を反転
        let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
        var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
        if sender.backgroundColor != nil {
            tmpCurrentBackGroundColor = sender.backgroundColor!
        } else {
            
        }
        sender.backgroundColor = tmpCurrentTitleColor
        sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//        // 押されたボタンが押下済みかどうか
//        var wasTapped: Bool = false
//        if lengthTappedArray.containsObject(sender.tag) {
//            wasTapped = true
//        }
//        // フラグが立っていたボタンの色を反転
//        for (flg,Outlet) in lengthOutletDictionary {
//            if (lengthTappedArray.containsObject(flg)) {
//                let tmpCurrentTitleColor:UIColor = Outlet.currentTitleColor
//                var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
//                if Outlet.backgroundColor != nil {
//                    tmpCurrentBackGroundColor = Outlet.backgroundColor!
//                } else {
//                    
//                }
//                Outlet.backgroundColor = tmpCurrentTitleColor
//                Outlet.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//            }
//        }
//        
//        if (!wasTapped) {
//            // 今押したボタンが押されてない状態だったら(押してない状態→押した状態の場合)
//            // まず配列を初期化
//            lengthTappedArray = []
//            // そこに今押したボタンのtagを追加
//            lengthTappedArray.addObject(sender.tag)
//            // 押されたボタンの色を反転
//            let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
//            var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
//            if sender.backgroundColor != nil {
//                tmpCurrentBackGroundColor = sender.backgroundColor!
//            } else {
//                
//            }
//            sender.backgroundColor = tmpCurrentTitleColor
//            sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//        } else {
//            // 押されてたら（押してる状態→押してない状態の場合）
//            // 初期化
//            lengthTappedArray = []
//        }
//        
//        if lengthTappedArray == [] {
//            lengthSign = "0"
//        } else {
//            lengthSign = String(lengthTappedArray[0])
//        }
    }
    
    @IBAction func sceneTapped(sender: UIButton) {
        // 押されたボタンが押下済みかどうか
        //        var wasTapped: Bool = false
        if sceneTappedArray.containsObject(sender.tag) {
            //            wasTapped = true
            sceneTappedArray.removeObject(sender.tag)
            
        } else {
            sceneTappedArray.addObject(sender.tag)
        }
        
        // 押されたボタンの色を反転
        let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
        var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
        if sender.backgroundColor != nil {
            tmpCurrentBackGroundColor = sender.backgroundColor!
        } else {
            
        }
        sender.backgroundColor = tmpCurrentTitleColor
        sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//        // 押されたボタンが押下済みかどうか
//        var wasTapped: Bool = false
//        if sceneTappedArray.containsObject(sender.tag) {
//            wasTapped = true
//        }
//        // フラグが立っていたボタンの色を反転
//        for (flg,Outlet) in sceneOutletDictionary {
//            if (sceneTappedArray.containsObject(flg)) {
//                let tmpCurrentTitleColor:UIColor = Outlet.currentTitleColor
//                var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
//                if Outlet.backgroundColor != nil {
//                    tmpCurrentBackGroundColor = Outlet.backgroundColor!
//                } else {
//                    
//                }
//                Outlet.backgroundColor = tmpCurrentTitleColor
//                Outlet.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//            }
//        }
//        
//        if (!wasTapped) {
//            // 今押したボタンが押されてない状態だったら(押してない状態→押した状態の場合)
//            // まず配列を初期化
//            sceneTappedArray = []
//            // そこに今押したボタンのtagを追加
//            sceneTappedArray.addObject(sender.tag)
//            // 押されたボタンの色を反転
//            let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
//            var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
//            if sender.backgroundColor != nil {
//                tmpCurrentBackGroundColor = sender.backgroundColor!
//            } else {
//                
//            }
//            sender.backgroundColor = tmpCurrentTitleColor
//            sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//        } else {
//            // 押されてたら（押してる状態→押してない状態の場合）
//            // 初期化
//            sceneTappedArray = []
//        }
//        
//        if sceneTappedArray == [] {
//            sceneSign = "0"
//        } else {
//            sceneSign = String(sceneTappedArray[0])
//        }
        
    }
    @IBAction func tasteTapped(sender: UIButton) {
        // 押されたボタンが押下済みかどうか
        //        var wasTapped: Bool = false
        if tasteTappedArray.containsObject(sender.tag) {
            //            wasTapped = true
            tasteTappedArray.removeObject(sender.tag)
            
        } else {
            tasteTappedArray.addObject(sender.tag)
        }
        
        // 押されたボタンの色を反転
        let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
        var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
        if sender.backgroundColor != nil {
            tmpCurrentBackGroundColor = sender.backgroundColor!
        } else {
            
        }
        sender.backgroundColor = tmpCurrentTitleColor
        sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//        // 押されたボタンが押下済みかどうか
//        var wasTapped: Bool = false
//        if tasteTappedArray.containsObject(sender.tag) {
//            wasTapped = true
//        }
//        // フラグが立っていたボタンの色を反転
//        for (flg,Outlet) in tasteOutletDictionary {
//            if (tasteTappedArray.containsObject(flg)) {
//                let tmpCurrentTitleColor:UIColor = Outlet.currentTitleColor
//                var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
//                if Outlet.backgroundColor != nil {
//                    tmpCurrentBackGroundColor = Outlet.backgroundColor!
//                } else {
//                    
//                }
//                Outlet.backgroundColor = tmpCurrentTitleColor
//                Outlet.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//            }
//        }
//        
//        if (!wasTapped) {
//            // 今押したボタンが押されてない状態だったら(押してない状態→押した状態の場合)
//            // まず配列を初期化
//            tasteTappedArray = []
//            // そこに今押したボタンのtagを追加
//            tasteTappedArray.addObject(sender.tag)
//            // 押されたボタンの色を反転
//            let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
//            var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
//            if sender.backgroundColor != nil {
//                tmpCurrentBackGroundColor = sender.backgroundColor!
//            } else {
//                
//            }
//            sender.backgroundColor = tmpCurrentTitleColor
//            sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//        } else {
//            // 押されてたら（押してる状態→押してない状態の場合）
//            // 初期化
//            tasteTappedArray = []
//        }
//        
//        if tasteTappedArray == [] {
//            tasteSign = "0"
//        } else {
//            tasteSign = String(tasteTappedArray[0])
//        }
    }
    
    @IBAction func genreTapped(sender: UIButton) {
        // 押されたボタンが押下済みかどうか
        //        var wasTapped: Bool = false
        if genreTappedArray.containsObject(sender.tag) {
            //            wasTapped = true
            genreTappedArray.removeObject(sender.tag)
            
        } else {
            genreTappedArray.addObject(sender.tag)
        }
        
        // 押されたボタンの色を反転
        let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
        var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
        if sender.backgroundColor != nil {
            tmpCurrentBackGroundColor = sender.backgroundColor!
        } else {
            
        }
        sender.backgroundColor = tmpCurrentTitleColor
        sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//        // 押されたボタンが押下済みかどうか
//        var wasTapped: Bool = false
//        if genreTappedArray.containsObject(sender.tag) {
//            wasTapped = true
//        }
//        // フラグが立っていたボタンの色を反転
//        for (flg,Outlet) in genreOutletDictionary {
//            if (genreTappedArray.containsObject(flg)) {
//                let tmpCurrentTitleColor:UIColor = Outlet.currentTitleColor
//                var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
//                if Outlet.backgroundColor != nil {
//                    tmpCurrentBackGroundColor = Outlet.backgroundColor!
//                } else {
//                    
//                }
//                Outlet.backgroundColor = tmpCurrentTitleColor
//                Outlet.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//            }
//        }
//        
//        if (!wasTapped) {
//            // 今押したボタンが押されてない状態だったら(押してない状態→押した状態の場合)
//            // まず配列を初期化
//            genreTappedArray = []
//            // そこに今押したボタンのtagを追加
//            genreTappedArray.addObject(sender.tag)
//            // 押されたボタンの色を反転
//            let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
//            var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
//            if sender.backgroundColor != nil {
//                tmpCurrentBackGroundColor = sender.backgroundColor!
//            } else {
//                
//            }
//            sender.backgroundColor = tmpCurrentTitleColor
//            sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
//        } else {
//            // 押されてたら（押してる状態→押してない状態の場合）
//            // 初期化
//            genreTappedArray = []
//        }
//        
//        if genreTappedArray == [] {
//            genreSign = "0"
//        } else {
//            genreSign = String(genreTappedArray[0])
//        }
        
    }

    
    
//    @IBAction func sceneDateBtn(sender: UIButton) {
//        sceneDateBtn = !sceneDateBtn
//        if (sceneDateBtn) {
//            sender.backgroundColor = sender.currentTitleColor
//            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            sceneSign = "2"
//            signDictionary["typeScene"] = sceneSign
//            
//        } else {
//            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
//            sender.backgroundColor = UIColor.whiteColor()
//            sceneSign = "0"
//            signDictionary["typeScene"] = sceneSign
//        }
//    }
//    @IBAction func sceneOfficeBtn(sender: UIButton) {
//        sceneOfficeBtn = !sceneOfficeBtn
//        if (sceneOfficeBtn) {
//            sender.backgroundColor = sender.currentTitleColor
//            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            sceneSign = "1"
//            signDictionary["typeScene"] = sceneSign
//            
//        } else {
//            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
//            sender.backgroundColor = UIColor.whiteColor()
//            sceneSign = "0"
//            signDictionary["typeScene"] = sceneSign
//        }
//    }
//    @IBAction func lengthShortBtn(sender: UIButton) {
//        lengthShortBtn = !lengthShortBtn
//        if (lengthShortBtn) {
//            sender.backgroundColor = sender.currentTitleColor
//            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            lengthSign = "2"
//            signDictionary["typeLength"] = lengthSign
//            
//        } else {
//            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
//            sender.backgroundColor = UIColor.whiteColor()
//            lengthSign = "0"
//            signDictionary["typeLength"] = lengthSign
//        }
//    }
//    @IBAction func lengthLongBtn(sender: UIButton) {
//        lengthLongBtn = !lengthLongBtn
//        if (lengthLongBtn) {
//            sender.backgroundColor = sender.currentTitleColor
//            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            lengthSign = "1"
//            signDictionary["typeLength"] = lengthSign
//            
//        } else {
//            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
//            sender.backgroundColor = UIColor.whiteColor()
//            lengthSign = "0"
//            signDictionary["typeLength"] = lengthSign
//        }
//    }
//    @IBAction func colorBlueBtn(sender: UIButton) {
//        colorBlueBtn = !colorBlueBtn
//        if (colorBlueBtn) {
//            sender.backgroundColor = sender.currentTitleColor
//            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            colorSign = "2"
//            signDictionary["typeColor"] = colorSign
//            
//        } else {
//            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
//            sender.backgroundColor = UIColor.whiteColor()
//            colorSign = "0"
//            signDictionary["typeColor"] = colorSign
//        }
//    }
//    
//    @IBAction func colorPinkBtn(sender: UIButton) {
//        colorPinkBtnFlg = !colorPinkBtnFlg
//        if (colorPinkBtnFlg) {
//            sender.backgroundColor = sender.currentTitleColor
//            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            colorSign = "1"
//            signDictionary["typeColor"] = colorSign
//            
//        } else {
//            sender.setTitleColor(sender.backgroundColor, forState: UIControlState.Normal)
//            sender.backgroundColor = UIColor.whiteColor()
//            colorSign = "0"
//            signDictionary["typeColor"] = colorSign
//        }
//        
//    }


//    override func loadView() {
//        let nib = UINib(nibName: "TagView", bundle: nil)
//        self.view = nib.instantiateWithOwner(nil, options: nil)[0] as! UIView 
////        self.view.addSubview(nib.instantiateWithOwner(nil, options: nil)[0] as! UIView)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        signDictionary["typeScene"] = "0"
//        signDictionary["typeLength"] = "0"
//        signDictionary["typeColor"] = "0"
        designOutletDictionary = [
            1: designFrenchOutlet,
            2: designArtOutlet,
            3: designGradationOutlet,
            4: designGaraOutlet,
            5: designOneColorOutlet,
            6: designFootOutlet
        ]
        colorOutletDictionary = [
            1: colorPinkBtnOutlet,
            2: colorWhitebtnOutlet,
            3: colorBlueBtnOutlet,
            4: colorBejuBtnOutlet,
            5: colorSilverBtnOutlet,
            6: colorOrangeBtnOutlet
        ] //as Dictionary<String, AnyObject>
        sceneOutletDictionary = [
            1: sceneOfficeOutlet,
            2: sceneBridalOutlet,
            3: sceneGokonOutlet,
            4: sceneDateOutlet,
            5: scenePartyOutlet,
            6: sceneSeasonOutlet
        ]
        tasteOutletDictionary = [
            1: tasteSimpleOutlet,
            2: tasteGariOutlet,
            3: tasteGorgeousOutlet
        ]
        lengthOutletDictionary = [
            1: lengthLongOutlet,
            2: lengthShortOutlet,
            3: lengthVeryLongOutlet
        ]
        genreOutletDictionary = [
            1: genreGelOutlet,
            2: genreSculpOutlet,
            3: genreOtherOutlet
        ]
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 初期化
        gblParam = [:]
        for (colName,signArray) in signDictionary {
            if (signArray != []) {
                gblParam[colName] = signArray
            }
        }
        
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
        
        
        
        
        
        for (colName,signArray) in signDictionary {
            if (signArray != []) {
                gblParam[colName] = signArray
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
        
        signDictionary["typeDesign"] = designTappedArray
        signDictionary["typeColor"]  = colorTappedArray
        signDictionary["typeLength"] = lengthTappedArray
        signDictionary["typeGenre"]  = genreTappedArray
        signDictionary["typeTaste"]  = tasteTappedArray
        signDictionary["typeScene"]  = sceneTappedArray
        
        for (colName,signArray) in signDictionary {
            if (signArray != []) {
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
