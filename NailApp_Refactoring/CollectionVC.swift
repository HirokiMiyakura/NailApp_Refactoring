//
//  CollectionVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/04/30.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
//    private let mModel = CollectionVM();
    private var mModel: CollectionProtocol?
    var tabKind: String?
    var userName: String?
//    override func loadView() {
//        self.view = UINib(nibName: "CollectionView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! CollectionView
//    }
//    override func loadView() {
//        self.view = UINib(nibName: "CustomView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! CustomView
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mModel = CollectionFactory.getCollectionClass(tabKind!)
//        let nib: UINib = UINib(nibName: "CollectionViewCell", bundle: nil)
//        collectionView.registerNib(nib, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = mModel
        
        mModel!.loadImageData()
        
        let refreshControl = UIRefreshControl()
        //下に引っ張った時に、リフレッシュさせる関数を実行する。”：”を忘れがちなので注意。
        refreshControl.addTarget(self, action: "reloadCollection:", forControlEvents: UIControlEvents.ValueChanged)
        //UICollectionView上に、ロード中...を表示するための新しいビューを作る
        self.collectionView?.addSubview(refreshControl)
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
        let width: CGFloat = super.view.frame.width / 3 - 6
        let height: CGFloat = width
        print(width)
        print(height)
        let rect:CGRect = CGRectMake(0, 0, width, height)
        
        return CGSize(width: width, height: height) // The size of one cell
        
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
        
        
    }
    
    
}
