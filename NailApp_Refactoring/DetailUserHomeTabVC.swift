//
//  DetailUserHomeTabVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/08.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class DetailUserHomeTabVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Dispose of any resources that can be recreated.
        let pageController:UIPageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        let navigationController:SwipeVC = SwipeVC(rootViewController: pageController)
        let DetailUserProfileVC = self.storyboard!.instantiateViewControllerWithIdentifier( "detailUsersProfileVC" ) as! DetailUsersProfileVC
        let CollectionNewVC = self.storyboard!.instantiateViewControllerWithIdentifier( "collectionVC" ) as! CollectionVC
        CollectionNewVC.tabKind = "1"
        
        navigationController.viewControllerArray = [DetailUserProfileVC,CollectionNewVC]
        self.addChildViewController(navigationController)
        self.view.addSubview(navigationController.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
