//
//  CollectionFactory.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/04/30.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class CollectionFactory: NSObject {

    static func getCollectionClass(tabKind: String) -> CollectionProtocol {
        if (tabKind == "1") {
            return CollectionNewVM()
        } else if (tabKind == "2") {
            return CollectionPopularVM()
        } else if (tabKind == "3") {
            return CollectionNewVM()
        } else if (tabKind == "4"){
            return CollectionUsersVM()
        } else if (tabKind == "5") {
            return CollectionOwnVM()
        } else if (tabKind == "6") {
            return CollectionFavVM()
        }else {
            return CollectionBaseVM()
        }
    }
}
