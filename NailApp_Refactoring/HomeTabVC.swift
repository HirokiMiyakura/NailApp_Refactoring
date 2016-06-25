//
//  HomeTabVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/04/30.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

extension NSMutableData {
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}
class HomeTabVC: UIViewController {

    
    @IBOutlet weak var navigationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.view.translatesAutoresizingMaskIntoConstraints = false
//        self.view.frame = CGRect(x: 0,y: 400,width: 400,height: 600)
        // Do any additional setup after loading the view.
        // New,Popularの横スクロール用VC
//        self.view.translatesAutoresizingMaskIntoConstraints = true
//        self.view.bounds = CGRect(x: 0,y: 150,width: 414,height: 736)
        print(self.view.bounds)
        let pageController:UIPageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        let navigationController:SwipeVC = SwipeVC(rootViewController: pageController)
        navigationController.titleArray = ["New","Popular","Favorite"]
        let CollectionNewVC = self.storyboard!.instantiateViewControllerWithIdentifier( "collectionVC" ) as! CollectionVC
        CollectionNewVC.tabKind = "1"
        let CollectionPopularVC = self.storyboard!.instantiateViewControllerWithIdentifier( "collectionVC" ) as! CollectionVC
        CollectionPopularVC.tabKind = "2"
        let CollectionFavVC = self.storyboard!.instantiateViewControllerWithIdentifier( "collectionVC" ) as! CollectionVC
        CollectionFavVC.tabKind = "6"
        navigationController.viewControllerArray = [CollectionNewVC,CollectionPopularVC,CollectionFavVC]
        self.addChildViewController(navigationController)
        self.view.addSubview(navigationController.view)
        
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

}
