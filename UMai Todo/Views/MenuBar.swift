//
//  MenuBar.swift
//  UMai Todo
//
//  Created by Zone 3 on 9/12/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit


class MenuBar : UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    let todoTypes = ["Pending", "Done"]

    var homeController : HomeController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "MenuCell")
        backgroundColor = Utilities.getColorWithHexString("#F5F5F5")
        setupView()
        setupSelectedHorizontalBar()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var xConstraint : NSLayoutConstraint?
    
    func setupSelectedHorizontalBar(){
        let horizontalView = UIView()
        horizontalView.backgroundColor = Utilities.getColorWithHexString("#00B2B7")
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(horizontalView)
        
        
        xConstraint = horizontalView.leftAnchor.constraint(equalTo: self.leftAnchor)
        xConstraint?.isActive = true
        horizontalView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        horizontalView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        horizontalView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        
    }
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.backgroundColor = Utilities.getColorWithHexString("#F5F5F5")
        cv.dataSource = self
        return cv
    }()
    
    func setupView(){
        
        addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeController?.changeTodoCollectionType(index : indexPath.row)
        xConstraint?.constant = indexPath.row == 0 ? 0 :  frame.width/2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.titleView.text = todoTypes[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width : frame.width/2 - 6, height : 50)
    }
    
}


class MenuCell : UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet{
            titleView.textColor = isHighlighted ? Utilities.getColorWithHexString("#00B2B7") :  Utilities.getColorWithHexString("#686868")

        }
        
    }
    
    override var isSelected: Bool{
        didSet{
            titleView.textColor = isSelected ? Utilities.getColorWithHexString("#00B2B7")  : Utilities.getColorWithHexString("#686868")
            
        }
        
    }
    
    
    let titleView : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "MarkerFelt-Wide", size: 14)
        label.textAlignment = .center
        label.textColor = Utilities.getColorWithHexString("#686868")
        label.backgroundColor = Utilities.getColorWithHexString("#F5F5F5")
        label.layer.borderWidth = 0
        label.layer.borderColor = UIColor.clear.cgColor

        return label
    }()
    
    
    func setupViews(){
        addSubview(titleView)
        titleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        titleView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
    }
}






