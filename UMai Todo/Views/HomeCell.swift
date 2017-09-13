//
//  HomeCell.swift
//  UMai Todo
//
//  Created by Zone 3 on 9/13/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit
import RealmSwift

class HomeCell : UICollectionViewCell, UITableViewDelegate,UITableViewDataSource{
    
    
    var tnote = ["money", "flesh", "gold", "royal", "hemp","sorry", "coded", "umai"]
    var todos = [Todo]()
    var flag : Int?{
        didSet{
            todos =  flag! == 0 ? TodoDAO().getTodosByType(type: State.Pending.rawValue) : TodoDAO().getTodosByType(type: State.Done.rawValue)
            tnote =  flag == 0 ? ["money", "flesh", "gold", "royal", "hemp","sorry", "coded", "umai"] : ["gfrt", "best", "master", "help", "love","crime", "story", "umai"]
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var tableView : UITableView = {
        let table = UITableView()
//        table.frame = frame
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.delegate = self
        table.dataSource = self
        
        table.register(TableCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
  
    
  
    func setupViews(){
        addSubview(tableView)
        
        tableView.contentInset = UIEdgeInsetsMake(8, 0, 8, 0 )
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(8, 0, 8, 0 )
        
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    
    }
    
    func reload(){
         todos =  flag! == 0 ? TodoDAO().getTodosByType(type: State.Pending.rawValue) : TodoDAO().getTodosByType(type: State.Done.rawValue)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCell
        
        cell.todoTitle.text = todos[indexPath.row].title
        cell.flag = flag
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let todo = self.todos[indexPath.row]
            self.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            TodoDAO().delete(todo: todo)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableCell
        if flag == 1{
            cell.todoStatusChange.image = UIImage(named:"cancel")
        }else {
            cell.todoStatusChange.image = UIImage(named:"mark")
        }
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            cell.todoStatusChange.alpha = 1
        }, completion: { (flag) in
            let todo = self.todos[indexPath.row]
            var change = ""
            if todo.state == State.Done.rawValue{
                change = State.Pending.rawValue
            }else {
               change = State.Done.rawValue
            }
            TodoDAO().Update(todo: todo, state: change)
            self.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            self.reload()
        })
        
        
    }
    
}
