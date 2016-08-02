//
//  EditDetailVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/06/18.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class EditDetailVC: UIViewController {
    var colorOutletDictionary:Dictionary<Int, UIButton> = [:]// as Dictionary<Int, UIButton>
    var lengthOutletDictionary:Dictionary<Int, UIButton> = [:]// = [:] as Dictionary<Int, UIButton>
    var sceneOutletDictionary:Dictionary<Int, UIButton> = [:]// = [:] as Dictionary<Int, UIButton>
    var designOutletDictionary:Dictionary<Int, UIButton> = [:]// = [:] as Dictionary<Int, UIButton>
    var tasteOutletDictionary:Dictionary<Int, UIButton> = [:]// = [:] as Dictionary<Int, UIButton>
    var genreOutletDictionary:Dictionary<Int, UIButton> = [:]// = [:] as Dictionary<Int, UIButton>
    
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
        var wasTapped: Bool = false
        if designTappedArray.containsObject(sender.tag) {
            wasTapped = true
        }
        // フラグが立っていたボタンの色を反転
        for (flg,Outlet) in designOutletDictionary {
            if (designTappedArray.containsObject(flg)) {
                let tmpCurrentTitleColor:UIColor = Outlet.currentTitleColor
                var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
                if Outlet.backgroundColor != nil {
                    tmpCurrentBackGroundColor = Outlet.backgroundColor!
                } else {
                    
                }
                Outlet.backgroundColor = tmpCurrentTitleColor
                Outlet.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
            }
        }
        
        if (!wasTapped) {
            // 今押したボタンが押されてない状態だったら(押してない状態→押した状態の場合)
            // まず配列を初期化
            designTappedArray = []
            // そこに今押したボタンのtagを追加
            designTappedArray.addObject(sender.tag)
            // 押されたボタンの色を反転
            let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
            var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
            if sender.backgroundColor != nil {
                tmpCurrentBackGroundColor = sender.backgroundColor!
            } else {
                
            }
            sender.backgroundColor = tmpCurrentTitleColor
            sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
        } else {
            // 押されてたら（押してる状態→押してない状態の場合）
            // 初期化
            designTappedArray = []
        }
        
        if designTappedArray == [] {
            designSign = "0"
        } else {
            designSign = String(designTappedArray[0])
        }
        
    }
    @IBAction func colorTapped(sender: UIButton) {
        
        // 押されたボタンが押下済みかどうか
        var wasTapped: Bool = false
        if colorTappedArray.containsObject(sender.tag) {
            wasTapped = true
        }
        // フラグが立っていたボタンの色を反転
        for (flg,Outlet) in colorOutletDictionary {
            if (colorTappedArray.containsObject(flg)) {
                let tmpCurrentTitleColor:UIColor = Outlet.currentTitleColor
                var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
                if Outlet.backgroundColor != nil {
                    tmpCurrentBackGroundColor = Outlet.backgroundColor!
                } else {
                    
                }
                Outlet.backgroundColor = tmpCurrentTitleColor
                Outlet.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
            }
        }
        
        if (!wasTapped) {
            // 今押したボタンが押されてない状態だったら(押してない状態→押した状態の場合)
            // まず配列を初期化
            colorTappedArray = []
            // そこに今押したボタンのtagを追加
            colorTappedArray.addObject(sender.tag)
            // 押されたボタンの色を反転
            let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
            var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
            if sender.backgroundColor != nil {
                tmpCurrentBackGroundColor = sender.backgroundColor!
            } else {
                
            }
            sender.backgroundColor = tmpCurrentTitleColor
            sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
        } else {
            // 押されてたら（押してる状態→押してない状態の場合）
            // 初期化
            colorTappedArray = []
        }
        
        if colorTappedArray == [] {
            colorSign = "0"
        } else {
            colorSign = String(colorTappedArray[0])
        }
        
    }
    @IBAction func lengthTapped(sender: UIButton) {
        // 押されたボタンが押下済みかどうか
        var wasTapped: Bool = false
        if lengthTappedArray.containsObject(sender.tag) {
            wasTapped = true
        }
        // フラグが立っていたボタンの色を反転
        for (flg,Outlet) in lengthOutletDictionary {
            if (lengthTappedArray.containsObject(flg)) {
                let tmpCurrentTitleColor:UIColor = Outlet.currentTitleColor
                var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
                if Outlet.backgroundColor != nil {
                    tmpCurrentBackGroundColor = Outlet.backgroundColor!
                } else {
                    
                }
                Outlet.backgroundColor = tmpCurrentTitleColor
                Outlet.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
            }
        }
        
        if (!wasTapped) {
            // 今押したボタンが押されてない状態だったら(押してない状態→押した状態の場合)
            // まず配列を初期化
            lengthTappedArray = []
            // そこに今押したボタンのtagを追加
            lengthTappedArray.addObject(sender.tag)
            // 押されたボタンの色を反転
            let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
            var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
            if sender.backgroundColor != nil {
                tmpCurrentBackGroundColor = sender.backgroundColor!
            } else {
                
            }
            sender.backgroundColor = tmpCurrentTitleColor
            sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
        } else {
            // 押されてたら（押してる状態→押してない状態の場合）
            // 初期化
            lengthTappedArray = []
        }
        
        if lengthTappedArray == [] {
            lengthSign = "0"
        } else {
            lengthSign = String(lengthTappedArray[0])
        }
    }
    
    @IBAction func sceneTapped(sender: UIButton) {
        // 押されたボタンが押下済みかどうか
        var wasTapped: Bool = false
        if sceneTappedArray.containsObject(sender.tag) {
            wasTapped = true
        }
        // フラグが立っていたボタンの色を反転
        for (flg,Outlet) in sceneOutletDictionary {
            if (sceneTappedArray.containsObject(flg)) {
                let tmpCurrentTitleColor:UIColor = Outlet.currentTitleColor
                var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
                if Outlet.backgroundColor != nil {
                    tmpCurrentBackGroundColor = Outlet.backgroundColor!
                } else {
                    
                }
                Outlet.backgroundColor = tmpCurrentTitleColor
                Outlet.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
            }
        }
        
        if (!wasTapped) {
            // 今押したボタンが押されてない状態だったら(押してない状態→押した状態の場合)
            // まず配列を初期化
            sceneTappedArray = []
            // そこに今押したボタンのtagを追加
            sceneTappedArray.addObject(sender.tag)
            // 押されたボタンの色を反転
            let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
            var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
            if sender.backgroundColor != nil {
                tmpCurrentBackGroundColor = sender.backgroundColor!
            } else {
                
            }
            sender.backgroundColor = tmpCurrentTitleColor
            sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
        } else {
            // 押されてたら（押してる状態→押してない状態の場合）
            // 初期化
            sceneTappedArray = []
        }
        
        if sceneTappedArray == [] {
            sceneSign = "0"
        } else {
            sceneSign = String(sceneTappedArray[0])
        }
        
    }
    @IBAction func tasteTapped(sender: UIButton) {
        // 押されたボタンが押下済みかどうか
        var wasTapped: Bool = false
        if tasteTappedArray.containsObject(sender.tag) {
            wasTapped = true
        }
        // フラグが立っていたボタンの色を反転
        for (flg,Outlet) in tasteOutletDictionary {
            if (tasteTappedArray.containsObject(flg)) {
                let tmpCurrentTitleColor:UIColor = Outlet.currentTitleColor
                var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
                if Outlet.backgroundColor != nil {
                    tmpCurrentBackGroundColor = Outlet.backgroundColor!
                } else {
                    
                }
                Outlet.backgroundColor = tmpCurrentTitleColor
                Outlet.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
            }
        }
        
        if (!wasTapped) {
            // 今押したボタンが押されてない状態だったら(押してない状態→押した状態の場合)
            // まず配列を初期化
            tasteTappedArray = []
            // そこに今押したボタンのtagを追加
            tasteTappedArray.addObject(sender.tag)
            // 押されたボタンの色を反転
            let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
            var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
            if sender.backgroundColor != nil {
                tmpCurrentBackGroundColor = sender.backgroundColor!
            } else {
                
            }
            sender.backgroundColor = tmpCurrentTitleColor
            sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
        } else {
            // 押されてたら（押してる状態→押してない状態の場合）
            // 初期化
            tasteTappedArray = []
        }
        
        if tasteTappedArray == [] {
            tasteSign = "0"
        } else {
            tasteSign = String(tasteTappedArray[0])
        }
    }
    
    @IBAction func genreTapped(sender: UIButton) {
        // 押されたボタンが押下済みかどうか
        var wasTapped: Bool = false
        if genreTappedArray.containsObject(sender.tag) {
            wasTapped = true
        }
        // フラグが立っていたボタンの色を反転
        for (flg,Outlet) in genreOutletDictionary {
            if (genreTappedArray.containsObject(flg)) {
                let tmpCurrentTitleColor:UIColor = Outlet.currentTitleColor
                var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
                if Outlet.backgroundColor != nil {
                    tmpCurrentBackGroundColor = Outlet.backgroundColor!
                } else {
                    
                }
                Outlet.backgroundColor = tmpCurrentTitleColor
                Outlet.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
            }
        }
        
        if (!wasTapped) {
            // 今押したボタンが押されてない状態だったら(押してない状態→押した状態の場合)
            // まず配列を初期化
            genreTappedArray = []
            // そこに今押したボタンのtagを追加
            genreTappedArray.addObject(sender.tag)
            // 押されたボタンの色を反転
            let tmpCurrentTitleColor:UIColor = sender.currentTitleColor
            var tmpCurrentBackGroundColor:UIColor = UIColor.whiteColor()
            if sender.backgroundColor != nil {
                tmpCurrentBackGroundColor = sender.backgroundColor!
            } else {
                
            }
            sender.backgroundColor = tmpCurrentTitleColor
            sender.setTitleColor(tmpCurrentBackGroundColor, forState: UIControlState.Normal)
        } else {
            // 押されてたら（押してる状態→押してない状態の場合）
            // 初期化
            genreTappedArray = []
        }
        
        if genreTappedArray == [] {
            genreSign = "0"
        } else {
            genreSign = String(genreTappedArray[0])
        }
        
    }

    
//    var colorPinkBtnFlg: Bool = false
//    var colorBlueBtnFlg: Bool = false
//    var lengthLongBtnFlg: Bool = false
//    var lengthShortBtnFlg: Bool = false
//    var sceneOfficeBtnFlg: Bool = false
//    var sceneDateBtnFlg: Bool = false
//    var colorSign: String = "0"
//    var lengthSign: String = "0"
//    var sceneSign: String = "0"
    var signArray: [String] = []
    var signDictionary = [:] as Dictionary<String, String>
    var signDictionary2 = [
        "colorPinkBtnFlg": false,
        "colorBlueBtnFlg": false,
        "lengthLongBtnFlg": false,
        "lengthShortBtnFlg": false,
        "sceneOfficeBtnFlg": false,
        "sceneDateBtnFlg": false,
        "colorSign": "0",
        "lengthSign": "0",
        "sceneSign": "0"
        ] as Dictionary<String, AnyObject>

//    var indexPath: NSIndexPath = NSIndexPath()
//    var imageInfo = []
    var imageCollectionObject: NCMBObject?
    var detailVM: DetailVM?
    var editImageDataVM: EditImageDataVM?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
//    override func loadView() {
//        let nib = UINib(nibName: "EditDetailView", bundle: nil)
//        self.view = nib.instantiateWithOwner(nil, options: nil)[0] as! UIView
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        detailVM = DetailVM(imageCollectionObject: imageCollectionObject!)
        editImageDataVM = EditImageDataVM()
//        let editDetailView = self.view as! EditDetailView
//        print("editDetailView.scrollView.contentSize")
//        print(editDetailView.scrollView.contentSize)
//        editDetailView.scrollView.translatesAutoresizingMaskIntoConstraints = false
//        editDetailView.scrollView.contentSize = CGSizeMake(screenWidth, screenWidth*3)
        let placeholder = UIImage(named: "transparent.png")
        self.imageView.setImageWithURL(detailVM!.getURL(), placeholderImage: placeholder)
        self.textField.text = detailVM!.getComment()
        setSign(detailVM!.getAllSign())
        setTouchFunction()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "更新", style:.Bordered, target: self, action: Selector("saveData"))
        
        self.navigationItem.title = "画像編集"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setTouchFunction() {
//        let editDetailView = self.view as! EditDetailView
//        editDetailView.colorPinkBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditDetailVC.colorPinkBtnTapped(_:))))
//        editDetailView.colorBlueBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditDetailVC.colorBlueBtnTapped(_:))))
//        editDetailView.lengthLongBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditDetailVC.lengthLongBtnTapped(_:))))
//        editDetailView.lengthShortBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditDetailVC.lengthShortBtnTapped(_:))))
//        editDetailView.sceneOfficeBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditDetailVC.sceneOfficeBtnTapped(_:))))
//        editDetailView.sceneDateBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditDetailVC.sceneDateBtnTapped(_:))))

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(animated: Bool) {
        
        print("viewWillApper")
//        detailVM!.addObserver(self, forKeyPath: "imageCollectionObject", options: [.New, .Old], context: nil)
        editImageDataVM!.addObserver(self, forKeyPath: "uploadDoneFlg", options: [.New, .Old], context: nil)
        
        //        super.viewWillAppear(animated)
        //        let detailView = self.view as! DetailView
        //            detailView.userInteractionEnabled = true
        //        detailView.scrollView.translatesAutoresizingMaskIntoConstraints = false
//                detailView.scrollView.contentSize = CGSizeMake(screenWidth, screenWidth*3)  //横幅は画面に合わせ、縦幅は1200とする。
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisapper")
//        detailVM!.removeObserver(self, forKeyPath: "imageCollectionObject")
        editImageDataVM!.removeObserver(self, forKeyPath: "uploadDoneFlg")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        NSLog("Called")
        
        if (keyPath == "uploadDoneFlg") {
            LoadingProxy.off();//ローディング表示。非表示にする場合はoff
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

    func setSign(allSign: Dictionary<String,String>) {
//        let editDetailView = self.view as! EditDetailView
        // 固定
//        let signDefine = [
//            "typeColor" :["colorSign",["colorPinkBtn","1",editDetailView.colorPinkBtn,"colorPinkBtnFlg"],["colorBlueBtn","2",editDetailView.colorBlueBtn,"colorBlueBtnFlg"]],
//            "typeLength" :["lengthSign",["lengthLongBtn","1",editDetailView.lengthLongBtn,"lengthLongBtnFlg"],["lengthShortBtn","2",editDetailView.lengthShortBtn,"lengthShortBtnFlg"]],
//            "typeScene" :["sceneSign",["sceneOfficeBtn","1",editDetailView.sceneOfficeBtn,"sceneOfficeBtnFlg"],["sceneDateBtn","2",editDetailView.sceneDateBtn,"sceneDateBtnFlg"]],
//        ] as Dictionary<String, NSArray>
        let signDefine:Dictionary<String, NSArray> = [
            "typeColor"  : [self.colorOutletDictionary,colorTappedArray],
            "typeLength" : [self.lengthOutletDictionary,lengthTappedArray],
            "typeScene"  : [self.sceneOutletDictionary,sceneTappedArray],
            "typeGenre"  : [self.genreOutletDictionary,genreTappedArray],
            "typeDesign" : [self.designOutletDictionary,designTappedArray],
            "typeTaste"  : [self.tasteOutletDictionary,tasteTappedArray]
            ] //as Dictionary<String, Dictionary>
        
        for (colNameParam,signParam) in allSign {

            if (signParam != "0") {
                let btnOutletDictionary = signDefine[colNameParam]![0] as! NSDictionary
                let flgOnBtnObj = btnOutletDictionary[Int(signParam)!] as! CustomButton
                flgOnBtnObj.backgroundColor = flgOnBtnObj.currentTitleColor
                flgOnBtnObj.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
                let tappedArray = signDefine[colNameParam]![1] as! NSMutableArray
                tappedArray.addObject(Int(signParam)!)
            }
//            for (colNameDef,signDef) in signDefine {
//
//                if (colNameParam == colNameDef) {
//                    for (var i = 1; i < signDef.count; i += 1) {
//                        if (signDef[i][1] == signParam) {
//                            let btnObj = (signDef[i] as! NSArray)[2] as! CustomButton
//                            btnObj.backgroundColor = btnObj.currentTitleColor
//                            btnObj.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//                            let btnFlgStr = (signDef[i] as! NSArray)[3] as! String
//                            signDictionary2[btnFlgStr] = true
//                            
//                            let btnSignString = signDef[0] as! String
//                            signDictionary2[btnSignString] = (signDef[i] as! NSArray)[1] as! String
//                        }
//                    }
//                }
//            }
        }
        
    }

    // addBtnをタップしたときのアクション
    func saveData() {
        LoadingProxy.set(self); //表示する親をセット
        LoadingProxy.on();//ローディング表示。非表示にする場合はoff
//        let editDetailView = self.view as! EditDetailView
        var objectIdOfImageInfo: String
        if (lengthTappedArray.count == 0) {
            lengthTappedArray.addObject(0)
        }
        if (colorTappedArray.count == 0) {
            colorTappedArray.addObject(0)
        }
        if (sceneTappedArray.count == 0) {
            sceneTappedArray.addObject(0)
        }
        if (genreTappedArray.count == 0) {
            genreTappedArray.addObject(0)
        }
        if (tasteTappedArray.count == 0) {
            tasteTappedArray.addObject(0)
        }
        if (designTappedArray.count == 0) {
            designTappedArray.addObject(0)
        }
        objectIdOfImageInfo = imageCollectionObject!.objectForKey("objectId")! as! String
        let param1 = [
            "objectId" : objectIdOfImageInfo,
            "textField" : self.textField.text!,
            "typeLength" : String(lengthTappedArray[0]),
            "typeColor" : String(colorTappedArray[0]),
            "typeScene" : String(sceneTappedArray[0]),
            "typeGenre" : String(genreTappedArray[0]),
            "typeTaste" : String(tasteTappedArray[0]),
            "typeDesign" : String(designTappedArray[0])
//            "commentTextView" : view!.commentTextView.text,
//            "image" : view!.profileImageView,
//            "mailAddress" : view!.mailTextField.text!,
//            "tel" : view!.telTextField.text!,
//            "salonName" : view!.salonNameTextField.text!,
//            "locationPrefecture" : view!.prefectureTextField.text!,
//            "locationCity" : view!.cityTextField.text!,
//            "lineId" : view!.lineIdTextField.text!,
//            "url" : view!.urlTextField.text!,
//            "averageAge" : view!.averageAgeTextField.text!,
//            "averageCost" : view!.averageCostTextField.text!,
//            "nailistFlg" : view!.nailistSwitch.on,
            //            "time" : String(time)
            ] as Dictionary<String, AnyObject>
        
        editImageDataVM!.updateImageData(param1)
//        self.navigationController?.pushViewController(second, animated: true)
    }
    
    func colorPinkBtnTapped(sender: UITapGestureRecognizer) {
        let editDetailView = self.view as! EditDetailView
//        colorPinkBtnFlg = !colorPinkBtnFlg
        let tmpFlg = signDictionary2["colorPinkBtnFlg"] as! Bool
        signDictionary2["colorPinkBtnFlg"] = !tmpFlg
        if (signDictionary2["colorPinkBtnFlg"] as! Bool) {
            
            editDetailView.colorPinkBtn.backgroundColor = editDetailView.colorPinkBtn.currentTitleColor
            editDetailView.colorPinkBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            signDictionary2["colorSign"] = "1"
            signDictionary["typeColor"] = "1"
            
        } else {
            editDetailView.colorPinkBtn.setTitleColor(editDetailView.colorPinkBtn.backgroundColor, forState: UIControlState.Normal)
            editDetailView.colorPinkBtn.backgroundColor = UIColor.whiteColor()
            signDictionary2["colorSign"] = "0"
            signDictionary["typeColor"] = "0"
        }
    }
    func colorBlueBtnTapped(sender: UITapGestureRecognizer) {
        let editDetailView = self.view as! EditDetailView
        let tmpFlg = signDictionary2["colorBlueBtnFlg"] as! Bool
        signDictionary2["colorBlueBtnFlg"] = !tmpFlg
//        colorBlueBtnFlg = !colorBlueBtnFlg
        if (signDictionary2["colorBlueBtnFlg"] as! Bool) {
            
            editDetailView.colorBlueBtn.backgroundColor = editDetailView.colorBlueBtn.currentTitleColor
            editDetailView.colorBlueBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            signDictionary2["colorSign"] = "2"
            signDictionary["typeColor"] = "2"
            
        } else {
            editDetailView.colorBlueBtn.setTitleColor(editDetailView.colorBlueBtn.backgroundColor, forState: UIControlState.Normal)
            editDetailView.colorBlueBtn.backgroundColor = UIColor.whiteColor()
            signDictionary2["colorSign"] = "0"
            signDictionary["typeColor"] = "0"
        }
    }
    func lengthLongBtnTapped(sender: UITapGestureRecognizer) {
        let editDetailView = self.view as! EditDetailView
//        lengthLongBtnFlg = !lengthLongBtnFlg
        let tmpFlg = signDictionary2["lengthLongBtnFlg"] as! Bool
        signDictionary2["lengthLongBtnFlg"] = !tmpFlg
        
        if (signDictionary2["lengthLongBtnFlg"] as! Bool) {
            
            editDetailView.lengthLongBtn.backgroundColor = editDetailView.lengthLongBtn.currentTitleColor
            editDetailView.lengthLongBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            signDictionary2["lengthSign"] = "1"
            signDictionary["typeLength"] = "1"
            
        } else {
            editDetailView.lengthLongBtn.setTitleColor(editDetailView.lengthLongBtn.backgroundColor, forState: UIControlState.Normal)
            editDetailView.lengthLongBtn.backgroundColor = UIColor.whiteColor()
            signDictionary2["lengthSign"] = "0"
            signDictionary["typeLength"] = "0"
        }
    }
    func lengthShortBtnTapped(sender: UITapGestureRecognizer) {
        let editDetailView = self.view as! EditDetailView
        let tmpFlg = signDictionary2["lengthShortBtnFlg"] as! Bool
        signDictionary2["lengthShortBtnFlg"] = !tmpFlg 
//        lengthShortBtnFlg = !tmpFlg
        if (signDictionary2["lengthShortBtnFlg"] as! Bool) {
            
            editDetailView.lengthShortBtn.backgroundColor = editDetailView.lengthShortBtn.currentTitleColor
            editDetailView.lengthShortBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            signDictionary2["lengthSign"] = "2"
            signDictionary["typeLength"] = "2"
            
        } else {
            editDetailView.lengthShortBtn.setTitleColor(editDetailView.lengthShortBtn.backgroundColor, forState: UIControlState.Normal)
            editDetailView.lengthShortBtn.backgroundColor = UIColor.whiteColor()
            signDictionary2["lengthSign"] = "0"
            signDictionary["typeLength"] = "0"
        }
    }
    func sceneOfficeBtnTapped(sender: UITapGestureRecognizer) {
        let editDetailView = self.view as! EditDetailView
//        sceneOfficeBtnFlg = !sceneOfficeBtnFlg
        let tmpFlg = signDictionary2["sceneOfficeBtnFlg"] as! Bool
        signDictionary2["sceneOfficeBtnFlg"] = !tmpFlg
        if (signDictionary2["sceneOfficeBtnFlg"] as! Bool) {
            
            editDetailView.sceneOfficeBtn.backgroundColor = editDetailView.sceneOfficeBtn.currentTitleColor
            editDetailView.sceneOfficeBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            signDictionary2["sceneSign"] = "1"
            signDictionary["typeScene"] = "1"
            
        } else {
            editDetailView.sceneOfficeBtn.setTitleColor(editDetailView.sceneOfficeBtn.backgroundColor, forState: UIControlState.Normal)
            editDetailView.sceneOfficeBtn.backgroundColor = UIColor.whiteColor()
            signDictionary2["sceneSign"] = "0"
            signDictionary["typeScene"] = "0"
        }
    }
    func sceneDateBtnTapped(sender: UITapGestureRecognizer) {
        let editDetailView = self.view as! EditDetailView
//        sceneDateBtnFlg = !sceneDateBtnFlg
        let tmpFlg = signDictionary2["sceneDateBtnFlg"] as! Bool
        signDictionary2["sceneDateBtnFlg"] = !tmpFlg
        if (signDictionary2["sceneDateBtnFlg"] as! Bool) {
            
            editDetailView.sceneDateBtn.backgroundColor = editDetailView.sceneDateBtn.currentTitleColor
            editDetailView.sceneDateBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            signDictionary2["sceneSign"] = "2"
            signDictionary["typeScene"] = "2"
            
        } else {
            editDetailView.sceneDateBtn.setTitleColor(editDetailView.sceneDateBtn.backgroundColor, forState: UIControlState.Normal)
            editDetailView.sceneDateBtn.backgroundColor = UIColor.whiteColor()
            signDictionary2["sceneSign"] = "0"
            signDictionary["typeScene"] = "0"
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let editDetailView = self.view as! EditDetailView
        editDetailView.textField.resignFirstResponder()
        
    }
    

}
