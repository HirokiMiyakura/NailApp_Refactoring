//
//  PageViewManagerVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/01.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class PageViewManagerVC: UIViewController, UIPageViewControllerDelegate {

    var pageViewController: UIPageViewController?
    var _PageViewManagerM: PageViewManagerM? = nil
    var indexPath: NSIndexPath = NSIndexPath()
    var imageInfo = []
    var favDic: [Int:Bool] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "詳細"
        // Do any additional setup after loading the view.
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController!.delegate = self
        let startingViewController: DetailVC = self.pageViewManagerM.viewControllerAtIndex(indexPath.row, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })
        
        self.pageViewController!.dataSource = self.pageViewManagerM
        
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)
        
        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
        var pageViewRect = self.view.bounds
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0)
        }
        self.pageViewController!.view.frame = pageViewRect
        
        self.pageViewController!.didMoveToParentViewController(self)
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
    var pageViewManagerM: PageViewManagerM {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
        if _PageViewManagerM == nil {
            // memoArrayとindexPathを引数にinitを呼ぶ
            //            _modelController = ModelController(_imageInfo: imageInfo, _indexPath: indexPath)
            _PageViewManagerM = PageViewManagerM(_imageInfo: imageInfo, _indexPath: indexPath, _favDic: favDic)
        }
        return _PageViewManagerM!
    }

}
