//
//  Category.swift
//  Todoey
//
//  Created by 潘鹤群 on 2023/8/20.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
