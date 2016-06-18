//
//  PageViewManagerM.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/01.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
//import NCMB

class PageViewManagerM: NSObject, UIPageViewControllerDataSource {

    var pageData: [String] = []
    var imageArray: NSArray = NSArray()
    var memoArray: NSArray = NSArray()
    var imageInfo = []
    var favDic: [Int:Bool] = [:]
    var indexImageInfoArray: Int = 0
    
    // memoArrayとindexPathを引数に持つinit
    init(_imageInfo: NSArray, _indexPath: NSIndexPath, _favDic: [Int:Bool]) {
        super.init()
        // Create the data model.
        let dateFormatter = NSDateFormatter()
        // 年月。１２月まで。実際不要。
        pageData = dateFormatter.monthSymbols
        // 前画面で選択したcellのindex。
        indexImageInfoArray = _indexPath.row
        // imageInfoの実態。JSON形式。
        imageInfo = _imageInfo
        
        favDic = _favDic
    }
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DetailVC? {
        // Return the data view controller for the given index.
        // 一番最初、indexには前画面で選択したcellのindexが入る。
        if (index >= self.imageInfo.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let detailVC = storyboard.instantiateViewControllerWithIdentifier("DetailVC") as! DetailVC
        
        //        let targetImageData = self.imageInfo[indexImageInfoArray]
        let targetImageData = self.imageInfo[index]
        //        dataViewController.dataObject = self.imageInfo[indexImageInfoArray] as! String
        // dataViewControllerのインスタンス変数に情報を注入
        detailVC.imageCollectionObject = targetImageData as? NCMBObject
        detailVC.favDic = self.favDic
        detailVC.index = index
        // ここで二つのVCを返却すればいい感じで次の画像も取得してセットしておくことができるかも。
        return detailVC
    }
    
    func indexOfViewController(viewController: DetailVC) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        //        return pageData.indexOf(viewController.dataObject) ?? NSNotFound
        return self.imageInfo.indexOfObject(viewController.imageCollectionObject!) ?? NSNotFound
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        //        print("before")
        //        if (self.indexImageInfoArray == 0) || (self.indexImageInfoArray == NSNotFound) {
        //            return nil
        //        }
        //        self.indexImageInfoArray -= 1
        //        return self.viewControllerAtIndex(self.indexImageInfoArray, storyboard: viewController.storyboard!)
        var index = self.indexOfViewController(viewController as! DetailVC)
        print(index)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        //        print("after")
        //        if self.indexImageInfoArray == NSNotFound {
        //            return nil
        //        }
        //
        //        self.indexImageInfoArray += 1
        //        if self.indexImageInfoArray == self.imageInfo.count {
        //            return nil
        //        }
        //        return self.viewControllerAtIndex(self.indexImageInfoArray, storyboard: viewController.storyboard!)
        
        print("after")
        
        var index = self.indexOfViewController(viewController as! DetailVC)
        print(index)
        if index == NSNotFound {
            return nil
        }
        
        index++
        //        if index == self.pageData.count {
        //            return nil
        //        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (completed) {
            print("previous")
            var dvc = pageViewController.viewControllers![0] as! DetailVC
            print(dvc)
        }
        
        
    }
}
