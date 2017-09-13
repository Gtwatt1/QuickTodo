////
////  TodoDAO.swift
////  UMai Todo
////
////  Created by Zone 3 on 9/13/17.
////  Copyright © 2017 Zone 3. All rights reserved.
////
//
//import Foundation
//
//
//class TodoDAO{
//    let realm: Realm
//    
//    public init(){
//        realm  = try! Realm()
//    }
//    
//    func save(todo : Todo){
//        try! realm.write {
//            realm.add(todo)
//        }
//        
//    }
//    
//    
//    func Update(todo: Todo, state: String){
//        let dTodo = find(id: todo.id)
//        try! realm.write {
//            dTodo.state = state
//        }
//        
//    }
//    
//    func getTodosByType(type: String) -> [Todo]{
//        
//        let predicate = NSPredicate(format: "state =  %@",type)
//        return realm.objects(Todo.self).filter(predicate)
//        return [Todo]()
//    }
//    
//    func delete(todo: Todo){
//        try! realm.write {
//            realm.delete(todo)
//        }
//        
//    }
//    
//    func find(id: String) -> Todo{
//        let predicate = NSPredicate(format: "id =  %@",id)
//        return realm.objects(Todo.self).filter(predicate).first ?? nil
//    }
//    
//}

