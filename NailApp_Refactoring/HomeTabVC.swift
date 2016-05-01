//
//  HomeTabVC.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/04/30.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

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
        let CollectionVC1 = self.storyboard!.instantiateViewControllerWithIdentifier( "collectionVC" ) as! CollectionVC
        CollectionVC1.tabKind = "1"
        let CollectionVC2 = self.storyboard!.instantiateViewControllerWithIdentifier( "collectionVC" ) as! CollectionVC
        CollectionVC2.tabKind = "2"
        navigationController.viewControllerArray = [CollectionVC1,CollectionVC2]
        self.addChildViewController(navigationController)
        navigationView.addSubview(navigationController.view)
        
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
