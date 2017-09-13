//
//  TableCell.swift
//  UMai Todo
//
//  Created by Zone 3 on 9/13/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit


class TableCell : UITableViewCell{
    
    var flag : Int? {
        didSet{
            if flag == 0 { todoIcon.image = UIImage(named: "diamondu") }
            else{todoIcon.image = UIImage(named: "diamond")}
        }
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "tableCell")
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let todoTitle : UILabel = {
        let m = UILabel()
        m.font = UIFont(name: "Noteworthy-Bold", size: 16)
        m.translatesAutoresizingMaskIntoConstraints = false
        m.textColor = Utilities.getColorWithHexString("#686868")

        return m
    }()
    
    let todoIcon : UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: "diamond")
        return icon
    }()
    
    
    func setupViews(){
        addSubview(todoTitle)
        addSubview(todoIcon)
        
        todoTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        todoTitle.leftAnchor.constraint(equalTo: todoIcon.rightAnchor, constant : 8).isActive = true
        todoTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -8) .isActive = true
        todoTitle.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        todoIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        todoIcon.leftAnchor.constraint(equalTo: leftAnchor,  constant : 36).isActive = true
        todoIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        todoIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
}
