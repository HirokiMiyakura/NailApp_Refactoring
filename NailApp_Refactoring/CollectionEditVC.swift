//
//  CollectionVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/04/30.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class CollectionEditVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBAction func editButton(sender: AnyObject) {
        
        
    }
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView?.allowsMultipleSelection = editing
        
//        toolBar.hidden = !editing
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var mModel: CollectionBaseVM?
    var tabKind: String = "5"
    var userName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
        mModel = CollectionFactory.getCollectionClass(tabKind)
        mModel!.loadImageData()
        
        let refreshControl = UIRefreshControl()
        //下に引っ張った時に、リフレッシュさせる関数を実行する。”：”を忘れがちなので注意。
        refreshControl.addTarget(self, action: "reloadCollection:", forControlEvents: UIControlEvents.ValueChanged)
        //UICollectionView上に、ロード中...を表示するための新しいビューを作る
        self.collectionView?.addSubview(refreshControl)
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    //リフレッシュさせる
    func reloadCollection(sender:AnyObject) {
        sender.beginRefreshing()
        mModel!.loadImageData()
        sender.endRefreshing()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:- Highlight
    
    func highlightCell(indexPath : NSIndexPath, flag: Bool) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        if flag {
            cell?.contentView.backgroundColor = UIColor.magentaColor()
        } else {
            cell?.contentView.backgroundColor = nil
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // 3カラム
//        let width: CGFloat = super.view.frame.width / 3 - 6
//        let height: CGFloat = width
//        //        print(width)
//        //        print(height)
//        let rect:CGRect = CGRectMake(0, 0, width, height)
//        
//        return CGSize(width: width, height: height) // The size of one cell
        
        
        let length = (UIScreen.mainScreen().bounds.width-15)/2
        return CGSizeMake(length,length);
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        mModel!.addObserver(self, forKeyPath: "imageInfo", options: [.New, .Old], context: nil)
        //        myClass.value = "NewValue"
    }
    
    override func viewWillDisappear(animated: Bool) {
        mModel!.removeObserver(self, forKeyPath: "imageInfo")
    }
    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        NSLog("Called")
        //        print(change)
        collectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UICollectionViewCell
        let indexPath = self.collectionView!.indexPathForCell(cell)
        let controller = segue.destinationViewController as! PageViewManagerVC
        controller.indexPath = indexPath!
        controller.imageInfo = mModel!.imageInfo
        controller.favDic = mModel!.favDic
        
        
    }
    
    func didClickImageView(recognizer: UIGestureRecognizer) {
        if let imageView = recognizer.view as? UIImageView {
            print("didClickImageView")
            /** netViewController への遷移 */
            print("FavImage!!!!")
            if(NCMBUser.currentUser() == nil) {
                print("ログインせよ")
                // 未ログインの場合はポップアップを出して処理終了
                let alertController = UIAlertController(title: "Sorry!", message: "カワイイネをするには会員になってね", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            mModel!.updateFavData(imageView)
            //            let targetFavData: AnyObject = self.imageInfo[imageView.tag]
            //            updateFavData(targetFavData, imageView: imageView)
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print("collectionViewの設定開始")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MyCollectionViewCell
        
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        let targetImageData = mModel!.imageInfo[indexPath.row]
        let url = NSURL(string: (targetImageData.objectForKey("imagePath") as? String)!)
        
        let placeholder = UIImage(named: "transparent.png")
        let imageView = UIImageView()
        //        imageView.frame = self.cellRect!
        imageView.frame = CGRect(x: 0,y: 0,width: 132,height: 132) // The size of one cell
        
        let rect:CGRect = CGRectMake(imageView.frame.width/3*2, imageView.frame.height/3*2, imageView.frame.width/3, imageView.frame.height/3)
        let favImageView = UIImageView()
        // didClickImageViewを有効化するための処理
        favImageView.userInteractionEnabled = true
        imageView.userInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target:self, action:#selector(CollectionVC.didClickImageView(_:)))
        favImageView.addGestureRecognizer(gesture)
        favImageView.tag = indexPath.row
        favImageView.frame = rect
        favImageView.image = UIImage(named: "heart_unlike.png")
        imageView.addSubview(favImageView)
        
        
        mModel!.setFavImage(favImageView, targetImageData: targetImageData as! NCMBObject)
        
        cell.contentView.addSubview(imageView)
        imageView.setImageWithURL(url, placeholderImage: placeholder)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mModel!.imageInfo.count
    }
    
    func didClickImageView2(recognizer: UIGestureRecognizer) {
        print("hahaha")
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        let imageView = UIImageView()
        let rect:CGRect = CGRectMake(cell!.frame.width/3*2, cell!.frame.height/3*2, cell!.frame.width/3, cell!.frame.height/3)
        imageView.image = UIImage(named: "check.png")
        imageView.frame = rect
        cell!.contentView.addSubview(imageView)
        highlightCell(indexPath, flag: true)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: false)
    }
    
    
}
