//
//  Item.swift
//  Todoey
//
//  Created by POST MD on 6/25/18.
//  Copyright © 2018 Grinning Zen Media and Design. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String =  ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?

    //this is the inverse to List<Item> in Category file in Data Model.
    //the category listed below states the class and the type (self).
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
    
}
