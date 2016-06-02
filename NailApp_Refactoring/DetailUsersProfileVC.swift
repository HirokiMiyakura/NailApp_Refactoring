//
//  DetailUsersProfileVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/08.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class DetailUsersProfileVC: UIViewController {

    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var mailAddressLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var lineIdLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var campaneLabel: UILabel!
    @IBOutlet weak var averageCostLabel: UILabel!
    @IBOutlet weak var shikuchosonLabel: UILabel!
    @IBOutlet weak var todofukenLabel: UILabel!
    @IBOutlet weak var averageAgeLabel: UILabel!
    @IBOutlet weak var salonNameLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    var userName: String!
    var mModel = DetailUserProfileVM();
//    @IBOutlet weak var tableView: UITableView!
//    //データ
//    var dataList = ["青山","阿部","加藤","川島","神田","佐藤","坂田","田中"]

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSizeMake(screenWidth, 1200)
        mModel.getAPIforPrefecture()
        mModel.getSalonInfo()
        mModel.loadProfileInfo(self.userName)
//        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        mModel.addObserver(self, forKeyPath: "aiueoaiueo", options: [.New, .Old], context: nil)
        mModel.addObserver(self, forKeyPath: "profileInfo", options: [.New, .Old], context: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        mModel.removeObserver(self, forKeyPath: "aiueoaiueo")
        mModel.removeObserver(self, forKeyPath: "profileInfo")
//        mModel.removeObserver(self, forKeyPath: "uploadDoneFlg")
        //        mModel.removeObserver(self, forKeyPath: "prefectureArray")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        NSLog("Called")
        
        if (keyPath == "aiueoaiueo") {
//            let view = self.view as! EditProfileView
            self.salonNameLabel.text = mModel.aiueoaiueo[0].objectForKey("salonName") as? String
//            view.salonNameTextField.text = mModel.aiueoaiueo[0].objectForKey("salonName") as? String
            self.mailAddressLabel.text = mModel.aiueoaiueo[0].objectForKey("mailAddress") as? String
            self.telLabel.text = mModel.aiueoaiueo[0].objectForKey("tel") as? String
            self.todofukenLabel.text = mModel.aiueoaiueo[0].objectForKey("locationPrefecture") as? String
            self.shikuchosonLabel.text = mModel.aiueoaiueo[0].objectForKey("locationCity") as? String
            self.lineIdLabel.text = mModel.aiueoaiueo[0].objectForKey("lineId") as? String
            self.urlLabel.text = mModel.aiueoaiueo[0].objectForKey("url") as? String
            self.averageAgeLabel.text = mModel.aiueoaiueo[0].objectForKey("averageAge") as? String
            self.averageCostLabel.text = mModel.aiueoaiueo[0].objectForKey("averageCost") as? String
            //        view.nailistSwitch.on = (mModel.aiueoaiueo[0].objectForKey("nailistFlg") as? Bool)!
            
        } else if (keyPath == "profileInfo") {
            print("profileInfo")
            self.introductionLabel.text = mModel.profileInfo[0].objectForKey("comment") as? String
//            print(self.introductionLabel.text)
//            self.introductionLabel.text = "heihfosifjaoiefpaoiepfoiaupoifuapoiefpaoifpoaieufpoaiuefpoaiaoiuoaeiu"
        }
        
    }


    
//    //データ
//    var dataList = ["青山,一塁手","阿部,捕手","加藤,二塁手","神田,三塁手","佐藤,遊撃手","坂田,外野手"]
//    
//    //データを返すメソッド
//    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
//        
//        //セルを取得する。
//        let cell = tableView.dequeueReusableCellWithIdentifier("TestCell", forIndexPath:indexPath) as UITableViewCell
//        
//        //データをカンマで分割する。
//        let arr = dataList[indexPath.row].componentsSeparatedByString(",")
//        
//        cell.textLabel?.text = arr[0] //タイトル
//        cell.detailTextLabel?.text = arr[1]  //詳細文
//        return cell
//    }
//    
//    //データの個数を返すメソッド
//    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
//        return dataList.count
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
