//
//  Todo.swift
//  UMai Todo
//
//  Created by Zone 3 on 9/13/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import Foundation


class Todo {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title = ""
    @objc dynamic var state = State.Pending.rawValue
}


enum State : String{
    case Pending, Done
}
