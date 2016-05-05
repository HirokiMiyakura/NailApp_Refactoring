//
//  CollectionProtocol.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/04/30.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

protocol CollectionProtocol:  UICollectionViewDataSource {
    
    func loadImageData()
    func addObserver(observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions, context: UnsafeMutablePointer<Void>)
    func removeObserver(observer: NSObject, forKeyPath keyPath: String)
    var imageInfo: NSArray {get}
    var userName: String {get}
    func setFavImage(favImageView: UIImageView, targetImageData: NCMBObject)

}
