//
//  CodeDef.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/01.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import Foundation
import UIKit

let screenBounds = UIScreen.mainScreen().bounds
let screenSize   = screenBounds.size
let screenWidth  = screenSize.width
let screenHeight = screenSize.height
let gridWidth : CGFloat = (screenSize.width/2)-5.0
let navigationHeight : CGFloat = 44.0
let statubarHeight : CGFloat = 20.0
let navigationHeaderAndStatusbarHeight : CGFloat = navigationHeight + statubarHeight
let urlUploadImagesPhp = "http://dsh4k2h4k2.esy.es/uploadToFileServer.php"
//let urlUploadImages = "http://test.localhost/NailApp_NoUseNifty/uploadToFileServer.php"
let urlUploadImagesLocation = "http://dsh4k2h4k2.esy.es/images/"
//let urlUploadImagesLocation = "http://test.localhost/NailApp_NoUseNifty/images/"
let urlUploadProfileImagesPhp = "http://dsh4k2h4k2.esy.es/uploadProfileImageToFileServer.php"
//let urlUploadProfileImagesPhp = "http://test.localhost/NailApp_NoUseNifty/uploadProfileImageToFileServer.php"
let urlUploadProfileImagesLocation = "http://dsh4k2h4k2.esy.es/profileImages/"
//let urlUploadProfileImagesLocation = "http://test.localhost/NailApp_NoUseNifty/profileImages/"
let TAB_HOME = 0
let TAB_SEARCH = 1
let TAB_UPLOAD = 2
let TAB_MYPAGE = 3

var gblUserName: String?
var gblParam = [:] as Dictionary<String, AnyObject>