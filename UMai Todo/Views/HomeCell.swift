//
//  HomeCell.swift
//  UMai Todo
//
//  Created by Zone 3 on 9/13/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit

class HomeCell : UICollectionViewCell, UITableViewDelegate,UITableViewDataSource{
    
    
    var tnote = ["money", "flesh", "gold", "royal", "hemp","sorry", "coded", "umai"]
    var todos = [Todo]()
    var flag : Int?{
        didSet{
//            todos =  flag == 0 ? TodoDAO().getTodosByType(type: State.Pending.rawValue) : TodoDAO().getTodosByType(type: State.Done.rawValue)
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
    
    
    let v : UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
  
    func setupViews(){
        addSubview(tableView)
        addSubview(v)
        
        tableView.contentInset = UIEdgeInsetsMake(8, 0, 8, 0 )
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(8, 0, 8, 0 )
        
        tableView.topAnchor.constraint(equalTo: topAnchor, constant : 4).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor , constant : -8).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        //        v.topAnchor.constraint(equalTo: topAnchor, constant : 40).isActive = true
        //        v.leftAnchor.constraint(equalTo: leftAnchor,constant : 40).isActive = true
        //        v.bottomAnchor.constraint(equalTo: bottomAnchor,constant : -40).isActive = true
        //        v.rightAnchor.constraint(equalTo: rightAnchor, constant : -40).isActive = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tnote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCell
        
        cell.todoTitle.text = tnote[indexPath.row]
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
            tnote.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableCell
        
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut, animations: {
            cell.todoStatusChange.alpha = 1
        }, completion: { (flag) in
            self.tnote.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.reloadData()})
        
        
        
        
//        let todo  = todos[indexPath.row]
//        if todo.state = State.Pending.rawValue{
//            TodoDAO().Update(todo: todo, state: State.Done.rawValue)
//        }else{
//            TodoDAO().Update(todo: todo, state: State.Pending.rawValue)
//        }
    }
    
}
