//
//  Category.swift
//  Todoey
//
//  Created by POST MD on 6/25/18.
//  Copyright © 2018 Grinning Zen Media and Design. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    //this describes the forwad relationship. ie in each category there are items. List is similar to Array and from Realm
    let items = List<Item>()
}



